%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "simbol_table.h"
#include "AST_V2.h"
#include <stdbool.h>

FILE *yyout;
extern FILE* yyin;

//Variables
int error_compilacion=0;
extern int linea; // Declaración de la variable "linea" como global

//Variables de la tabla de símbolos
symbol table[100];
int table_size = 0;//Se usa para conocer el índice del array disponible para insertar el siguiente número

//int numEtiqueta=0;
//bool variableGlobalFaltaEtiqueta= false;

%}

/* declare type possibilities of symbols */
%union {
  int intVal;
  float floatVal;
  char* stringVal;
  struct atributos{
    struct nodo *a;  //El sctruct del AST para poder almacenar los nodos
    float real;
    int entero;
    char* texto;
    char* tipo; //Cadena de caracteres que almacena textualmente el tipo del elemento para poder ofrecer controles semánticos sobre el mismo
  }st;
}


/* Declarar tokens recogidos de FLEX*/
%token MAS MENOS POR DIV LPAREN RPAREN CONCAT COMILLA IGUAL SI OSI SINO MIENTRAS FIN DOBLEAMPERSAN DOBLEBARRA IMPRIMIR COMENTARIO
%token EXCLAMACION MAYQUE MENQUE MODULO EXPON MAYORIGUAL IGUALIGUAL MENORIGUAL
%token PUNTOCOMA PARA EN RANGO COMA

/* Los no terminales hacen uso de la estructura */
%type <st> statement_list term factor statement exp asignacion_statement si_statement osi_list osi mientras_statement imprimir_statement
%type <st> condicion_list condicion para_statement

%token <intVal> ENT
%token <floatVal> REAL
%token <stringVal> TEXT
%token <stringVal> ID

%left MAYQUE MENQUE MAYORIGUAL MENORIGUAL IGUALIGUAL
%left MAS MENOS
%left POR DIV  
%left IGUAL PUNTOCOMA

%start program

%%

program:
    statement_list  {
        printf("------------------------\n");
        printf("SENTENCIA RECONOCIDA\n");
        if(error_compilacion>=1){
            printf("\nHa habido %d error(es) de compilacion\n",error_compilacion);
        }
        printf("CREANDO CODIGO .ASM\n");
        printf("------------------------\n");
        double valor = iniciar_evaluacion($1.a); //$1.a->registro
        /*printf(">>>Resultado evaluado= %f\n",valor);
        printf("\n>>>Variables de la tabla de símbolos: %f\n",valor);
        for (int i = 0; i < 100; i++){
        printf("%s\n",table[i].name);
        }*/
        printf("------------------------\n");
        printf("COMPILACION TERMINADA\n");
            
    }
    ;

//Varias cosas encadenadas
statement_list:
    statement {
        printf("-> STATEMENT\n");
        $$.a=$1.a;
    }
    | statement_list statement {
        printf("-> STATEMENT LIST\n");
        $$.a = new_node('SL', $1.a, $2.a);
        if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para almacenar la lista de statements\n",linea);
            }
    }
    ;

//Una signación, IF o WHILE
statement:
    asignacion_statement {
        $$.a=$1.a;
    }
    | si_statement {
        $$.a=$1.a;
    }
    | mientras_statement {
    }
    | para_statement {
    }
    | imprimir_statement {
        $$.a=$1.a;
    }
    | COMENTARIO {
        $$.a = new_leaf_comment();
        //No hace nada por que es un comentario :)
    }
    ;

imprimir_statement: 
    IMPRIMIR LPAREN exp RPAREN{ //imprimir un identificador
           /*if(variableGlobalFaltaEtiqueta==true){  //Hay que imprimir una etiqueta
                printf(yyout, "Etiqueta%d",numEtiqueta);
                numEtiqueta++;
            }*/
            //Evaluamos la expresión
            //double valor = iniciar_evaluacion($3.a); //Evaluar la exppresión para hacer la asignación
            //printf(">>>IMPRIMIR %f\n",valor);
            //Ya conocemos en que registro está el valor, que será float
            printf("-> IMPRIMIR\n");
            $$.a = new_node('P',$3.a, nodo_vacio());
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion imprimir\n",linea);
            }
            
        }
    ;

asignacion_statement:
    ID IGUAL exp {
        printf("-> ASIGNACION\n");
        int i = lookup($1,table_size,table);
        if (i == -1) {  //Si no está en la tabla de símbolos, se crea uno nuevo
            if(strcmp($3.tipo, "entero")==0){
                printf("Se asigna a la variable el resultado de la operacion con un %d\n",$3.entero);

                table[table_size].name = $1;
                table[table_size].tipo = "entero";
                table[table_size].entero = $3.entero;
                table[table_size].registro = $3.a->registro;
                table_size++;
            }
            else if(strcmp($3.tipo, "real")==0){
                printf("Se asigna a la variable el resultado de la operacion con un %f\n",$3.real);

                table[table_size].name = $1;
                table[table_size].tipo = "real";
                table[table_size].real = $3.real;
                table[table_size].registro = $3.a->registro;
                table_size++;
            }

            $$.a=new_node('A',$3.a, nodo_vacio());
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion asignacion\n",linea);
            }

        }else{  //Ya se encuentra en la tabla de símbolos y se conoce su posición
            printf("# Sobreescribir la varible -%s-, que se encuentra en el registro  $f%d\n",table[i].name ,table[i].registro); 
            //Si lo encuentra, tiene que coger el resultado de exp y moverlo al registro
            //que tiene asignada la variable
            if(strcmp($3.tipo, "entero")==0){
                table[i].tipo = "entero";
                table[i].entero = $3.entero;
            }
            else if(strcmp($3.tipo, "real")==0){
                table[i].tipo = "real";
                table[i].real = $3.real;
            }

            $$.a=new_node('R',$3.a, nodo_con_info_para_asignacion(table[i].registro));
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion asignacion\n",linea);
            }            
        }
    }
    ;

//Si
si_statement: 
    SI LPAREN condicion_list RPAREN statement_list osi_list FIN  {printf("Bucle SI con cadena de OSI\n");}
    | SI LPAREN condicion_list RPAREN statement_list FIN {
        printf("-> SI\n");
        $$.a = new_node('S',$3.a, $5.a);
        if($$.a->registro==-1){
            error_compilacion++;
            printf("ERROR LINEA %d: No quedan registros disponibles para realizar la sentencia SI\n",linea);
        }
        }
    | SI LPAREN condicion_list RPAREN statement_list SINO statement_list FIN {
        printf("-> SI con SINO\n");
        $$.a = new_node_sino($3.a,$5.a, $7.a);
        if($$.a->registro==-1){
            error_compilacion++;
            printf("ERROR LINEA %d: No quedan registros disponibles para realizar la sentencia SI\n",linea);
        }
    }
    ;
//Varios osi encadenados
osi_list:
    osi    {printf("UN OSI\n");}
    | osi_list osi  {printf("VARIOS OSI\n");}
    ;
//un osi
osi: OSI LPAREN condicion_list RPAREN statement_list {printf("OSI\n");}
    ;

//mientras
mientras_statement:
    MIENTRAS LPAREN condicion_list RPAREN statement_list FIN {
        printf("-> MIENTRAS\n");
        $$.a = new_node('M',$3.a,$5.a);
        if($$.a->registro==-1){
            error_compilacion++;
            printf("ERROR LINEA %d: No quedan registros disponibles para realizar la sentencia MIENTRAS\n",linea);
        }
    }
    ;

para_statement:
    PARA ID EN RANGO LPAREN ENT COMA ENT RPAREN statement_list FIN {
        printf("-> PARA\n");
        $$.a = new_node_para(strdup($2), $6, $8, $10.a);
        if($$.a->registro==-1){
            error_compilacion++;
            printf("ERROR LINEA %d: No quedan registros disponibles para realizar la condicion\n",linea);
        }
    }
    |PARA ID EN RANGO LPAREN ENT RPAREN statement_list FIN {
        printf("-> PARA2\n");
        $$.a = new_node_para2(strdup($2), $6, $8.a);
        if($$.a->registro==-1){
            error_compilacion++;
            printf("ERROR LINEA %d: No quedan registros disponibles para realizar la condicion\n",linea);
        }
    }
    | PARA ID EN RANGO LPAREN ENT COMA ENT COMA ENT RPAREN statement_list FIN {
        printf("-> PARA3\n");
        $$.a = new_node_para3(strdup($2), $6, $8, $10, $12.a);
        if($$.a->registro==-1){
            error_compilacion++;
            printf("ERROR LINEA %d: No quedan registros disponibles para realizar la condicion\n",linea);
        }
    }
    ;

//Lista de condiciones
condicion_list: condicion_list DOBLEAMPERSAN  condicion {printf("Condicion && condicion\n");}
    | condicion_list DOBLEBARRA condicion {printf("Condicion || condicion\n");}
    | EXCLAMACION condicion {printf("!condicion\n");}
    | condicion {
        $$.a = $1.a;
        printf("-> CONDICION\n");
        $$.a = new_node('C',$1.a, nodo_vacio());
        if($$.a->registro==-1){
            error_compilacion++;
            printf("ERROR LINEA %d: No quedan registros disponibles para realizar la condicion\n",linea);
        }
        //double valor = iniciar_evaluacion($1.a); //$1.a->registro
        //printf(">>>Resultado evaluado comparacion MAYOR QUE= %f\n",valor);
    }

//Condiciones
/**
OJO AQUI HAY QUE EVALUAR LAS DOS EXPRESIONES ANTES DE COMPARAR NADA, SINO NO TIENES EL RESULTADO
**/
condicion: 
    exp MAYQUE exp {
        printf("-> MAYOR QUEL\n");
        if (strcmp($1.tipo, "texto")==0 || strcmp($3.tipo, "texto")==0) { 
            error_compilacion++;
            printf("ERROR: Operacion no reconocida %d",linea);
        } else {
            $$.a = new_node('>', $1.a, $3.a);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la condicion 'mayor que'\n",linea);
            }
            $$.tipo = "bool";
        }
        
    }
    | exp MENQUE exp   {
        printf("-> MENOR QUE\n");
        if (strcmp($1.tipo, "texto")==0 || strcmp($3.tipo, "texto")==0) { 
            error_compilacion++;
            printf("ERROR LINEA %d: Operacion no reconocida",linea);
        } else {
            $$.a = new_node('<', $1.a, $3.a);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la condicion 'menor que'\n",linea);
            }
            $$.tipo = "bool";
        }
    }
    | exp MAYORIGUAL exp {
        printf("-> MAYOR O IGUAL\n");
        if (strcmp($1.tipo, "texto")==0 || strcmp($3.tipo, "texto")==0) { 
            error_compilacion++;
            printf("ERROR: Operacion no reconocida %d",linea);
        } else {
            $$.a = new_node('>=', $1.a, $3.a);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la condicion 'mayor o igual que'\n",linea);
            }
            $$.tipo = "bool";
        }
    }
    | exp MENORIGUAL exp {
        printf("-> MENOR O IGUAL\n");
        if (strcmp($1.tipo, "texto")==0 || strcmp($3.tipo, "texto")==0) { 
            error_compilacion++;
            printf("ERROR: Operacion no reconocida %d",linea);
        } else {
            $$.a = new_node('<=', $1.a, $3.a);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la condicion 'menor o igual que'\n",linea);
            }
            $$.tipo = "bool";
        }
    }
    | exp IGUALIGUAL exp {
        printf("-> IGUAL QUE\n");
        if (strcmp($1.tipo, "texto")==0 || strcmp($3.tipo, "texto")==0) { 
            error_compilacion++;
            printf("ERROR: Operacion no reconocida %d",linea);
        } else {
            $$.a = new_node('==', $1.a, $3.a);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la condicion 'igual igual que'\n",linea);
            }
            $$.tipo = "bool";
        }
    }

exp: 
    exp MAS term {
        if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "entero")==0) { //Si ambos son enteros
            $$.a = new_node('+', $1.a,$3.a); 
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion suma\n",linea);
            }
            $$.tipo="entero";
            $$.entero=$1.entero+$3.entero;
            printf("-> SUMA entero+entero\n");  
        }
        else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "real")==0){  //Si los dos son float
            $$.a = new_node('+', $1.a,$3.a);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion suma\n",linea);
            }
            $$.tipo="real";
            $$.real=$1.real+$3.real;
            printf("-> SUMA real+real\n");
        }
        else if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "real")==0){  // Entero y real
            $$.a = new_node('+', $1.a,$3.a);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion suma\n",linea);
            }
            $$.tipo="real";
            $$.real=$1.entero+$3.real;
            printf("-> SUMA entero+real\n");
        }
        else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "entero")==0){  // Real y entero
            $$.a = new_node('+', $1.a,$3.a);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion suma\n",linea);
            }
            $$.tipo="real";
            $$.real=$1.real+$3.entero;
            printf("-> SUMA real+entero\n");
        }
        else{
            error_compilacion++;
            printf("ERROR LINEA %d: No se puede operar en línea\n",linea);
        }
    }
    | exp MENOS term {
        if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "entero")==0) { //Si ambos son enteros
            $$.a = new_node('-', $1.a,$3.a);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion resta\n",linea);
            }
            $$.tipo="entero";
            $$.entero=$1.entero+$3.entero;
            printf("-> RESTA entero-entero\n");
        }
        else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "real")==0){  //Si los dos son float
            $$.a = new_node('-', $1.a,$3.a);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion suma\n",linea);
            }
            $$.tipo="real";
            $$.real=$1.real+$3.real;
            printf("-> RESTA real-real\n");
        }
        else if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "real")==0){  // Entero y real
            $$.a = new_node('-', $1.a,$3.a);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion suma\n",linea);
            }
            $$.tipo="real";
            $$.real=$1.entero+$3.real;
            printf("-> RESTA entero-real\n");
        }
        else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "entero")==0){  // Real y entero
            $$.a = new_node('-', $1.a,$3.a);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion suma\n",linea);
            }
            $$.tipo="real";
            printf("-> RESTA real-entero\n");
        }
        else{
                error_compilacion++;
                printf( "ERROR: No se puede operar\n");
        }
    }
/**
FALTA POR HACER LA CONCATENACIÓN
**/
    | exp CONCAT term {
        if (strcmp($1.tipo, "texto")==0 && strcmp($3.tipo, "texto")==0){
            $$.texto = strcat($1.texto, $3.texto);
            $$.tipo="texto";
            printf( "Concatenado -> %s\n",$$.texto);
        }
        else{
            error_compilacion++;
            printf( "ERROR LINEA %d: No se puede concatenar algo que no sean cadenas de texto\n",linea);
        }
    }
    | term {
        //printf("Termino con tipo %s\n",$1.tipo);
        $$ = $1; }   //Se hace una copia
    ;

term: 
    term POR factor {
        if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "entero")==0) { //Si ambos son enteros
            $$.a = new_node('*', $1.a,$3.a);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion multiplicar\n",linea);
            }
            $$.tipo="entero";
            $$.entero=$1.entero+$3.entero;
            printf( "-> MULTIPLICACION entero*entero\n");
        }
        else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "real")==0){  //Si los dos son float
            $$.a = new_node('*', $1.a,$3.a);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion multiplicar\n",linea);
            }
            $$.tipo="real";
            $$.real=$1.real+$3.real;
            printf( "-> MULTIPLICACION real*real\n");
        }
        else if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "real")==0){  // Entero y real
            $$.a = new_node('*', $1.a,$3.a);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion multiplicar\n",linea);
            }
            $$.tipo="real";
            $$.real=$1.entero+$3.real;
            printf( "-> MULTIPLICACION entero*real\n");
        }
        else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "entero")==0){  // Real y entero
            $$.a = new_node('*', $1.a,$3.a);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion multiplicar\n",linea);
            }
            $$.tipo="real";
            $$.real=$1.real+$3.entero;
            printf( "-> MULTIPLICACION real*entero\n");
        }
        else{
             error_compilacion++;
             printf( "ERROR LINEA %d: No se puede realizar la operacion multiplicar con estos operandos");
        }
    }
/**
OJO HAY QUE CONTROLAR NO DIVIDIR ENTRE 0
**/
    | term DIV factor {
        if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "entero")==0) { //Si ambos son enteros
            $$.a = new_node('/', $1.a,$3.a);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion dividir\n",linea);
            } 
            $$.tipo="entero";
            $$.entero=$1.entero+$3.entero;
            printf( "-> DIVISION entero/entero\n");
        }
        else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "real")==0){  //Si los dos son float
            $$.a = new_node('/', $1.a,$3.a); 
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion dividir\n",linea);
            } 
            $$.tipo="real";
            $$.real=$1.real+$3.real;
            printf( "-> DIVISION real/real\n");
        }
        else if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "real")==0){  // Entero y real
            $$.a = new_node('/', $1.a,$3.a); 
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion dividir\n",linea);
            } 
            $$.tipo="real";
            $$.real=$1.entero+$3.real;
            printf( "-> DIVISION entero/real\n");
        }
        else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "entero")==0){  // Real y entero
            $$.a = new_node('/', $1.a,$3.a); 
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion dividir\n",linea);
            } 
            $$.tipo="real";
            $$.real=$1.real+$3.entero;
            printf( "-> DIVISION real/entero\n");
        }
        else{
             error_compilacion++;
             printf( "ERROR LINEA %d: No se puede realizar la operacion dividir con estos operandos",linea);
        }
    }

/**
OJO HAY QUE HACER ESTA OPERACIÓN EN EL AST Y ASM
**/
    | term MODULO factor { //solo se puede hacer con enteros
        printf("-> MODULO\n");
        if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "entero")==0) { //Si ambos son enteros
            $$.a = new_node('%', $1.a,$3.a); 
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion modulo\n",linea);
            } 
            $$.tipo="entero";
            printf( "-> MODULO entero %% entero \n");
        } else{
             error_compilacion++;
             printf( "ERROR LINEA %d: No se puede operar con operadores no enteros\n",linea);
        }   
    }
/**
OJO HAY QUE HACER ESTA OPERACIÓN EN EL AST Y ASM
**/
    | term EXPON factor { //solo se puede hacer con enteros
        if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "entero")==0) { //Si ambos son enteros
            $$.a = new_node('^', $1.a,$3.a);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion exponente\n",linea);
            } 
            $$.tipo="entero";
            printf( "-> EXPONENTE entero^entero\n");
        } else{
             error_compilacion++;
             printf( "ERROR: No se puede operar\n");
        }
    }
    | factor {
        //printf("Factor con tipo %s\n",$1.tipo);
        $$ = $1;}
/**
OJO HAY QUE CONTROLAR EL USO DE VARIABLES EN EL AST
**/
    | ID {
            printf("-> ID %s\n",$1);
            //printf("Hemos encontrado un identificador");
            //Hemos encontrado un identificador, hay que ver si está en la tabla para recogerlo y sino devolver un error
            int i = lookup($1,table_size,table); //lo buscamos
            if(i == -1){
                printf( "ERROR LINEA %d: Se usa una variable que no ha sido definida anteriormente",linea);
            }
            else{
                //Controlamos de que tipo es
                if(table[i].tipo=="entero"){
                    $$.tipo = table[i].tipo;
                    $$.entero=table[i].entero;
                    //Crear nodo hoja con números
                    $$.a = new_var_leaf_num(table[i].entero,table[i].registro);    
                }
                else if(table[i].tipo=="real"){
                    $$.tipo = table[i].tipo;      
                    $$.real=table[i].real;
                    //Crear nodo hoja con números
                    $$.a = new_var_leaf_num(table[i].real,table[i].registro);        
                }
                else if(table[i].tipo=="texto"){
                    $$.tipo = table[i].tipo;

            //CREAR NODO TEXTO             
                }
                else{printf("ERROR LINEA %d: Variable de tipo desconocido",linea);}

            }
        }
    ;

factor: 
    ENT {$$.entero = $1;
            $$.a = new_leaf_num($1);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para asignar el entero %ld\n", linea,$$.entero);
            }  
            $$.tipo="entero"; 
            printf( "-> ENTERO: %ld\n", $$.entero);}   
    | MENOS ENT {$$.entero = -$2;
            $$.a = new_leaf_num(-$2);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para asignar el entero %ld\n", linea, $$.entero);
            }
            $$.tipo="entero";
            printf( "-> ENTERO NEGATIVO: %ld\n", $$.entero);}
    | REAL {$$.real = $1;
            $$.a = new_leaf_num($1);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para asignar el real %f\n",linea, $$.real);
            }
            $$.tipo="real";
            printf( "-> REAL: %f\n", $$.real);}
    | MENOS REAL {$$.real = -$2;
            $$.a = new_leaf_num(-$2);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para asignar el real %f\n",linea,  $$.real);
            }
            $$.tipo="real";
            printf( "-> REAL NEGATIVO: %f\n", $$.real);}
    | LPAREN exp RPAREN {
            $$ = $2;
            printf("PARENTESIS\n");}
    | TEXT  {
            $$.texto = $1;
            $$.tipo="texto";
            printf("Variable de tipo TEXTO: %s\n", $$.texto);}
    ;

%%

int main(int argc, char** argv) {
    if (argc < 2) {
        printf("Sin input. Introduce archivo input.\n");
        return 1;
    }
    yyin = fopen(argv[1], "rt");
    if (yyin == NULL) {
        printf("No se puedo leer el input.\n");
        return 1;
    }
    yyout = fopen( "./maquina.asm", "wt" );
	yyparse();
    fclose(yyin);
    return 0;
}

void yyerror(const char* s) {
    fprintf(stderr, "%s\n", s);
}

int yywrap() {
    return 1;
}