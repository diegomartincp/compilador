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
int linea=1;

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
%token MAS MENOS POR DIV LPAREN RPAREN CONCAT COMILLA IGUAL SI OSI SINO MIENTRAS FIN DOBLEAMPERSAN DOBLEBARRA IMPRIMIR
%token EXCLAMACION MAYQUE MENQUE MODULO EXPON MAYORIGUAL IGUALIGUAL MENORIGUAL
%token PUNTOCOMA

/* Los no terminales hacen uso de la estructura */
%type <st> statement_list term factor statement exp asignacion_statement si_statement osi_list osi mientras_statement imprimir_statement
%type <st> condicion_list condicion 

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
        printf("-> SENTENCIA RECONOCIDA");
        if(error_compilacion>=1){
            printf("\nHa habido %d error(es) de compilacion",error_compilacion);
        }
        double valor = iniciar_evaluacion($1.a); //$1.a->registro
        /*printf(">>>Resultado evaluado= %f\n",valor);
        printf("\n>>>Variables de la tabla de símbolos: %f\n",valor);
        for (int i = 0; i < 100; i++){
        printf("%s\n",table[i].name);
        }*/
        printf("\nCodigo ASM generado correctamente");
            
    }
    ;

//Varias cosas encadenadas
statement_list:
    statement {
        $$.a=$1.a;
    }
    | statement_list statement {
        $$.a = new_node('SL', $1.a, $2.a);
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
    | imprimir_statement {
        $$.a=$1.a;
    }
    ;

imprimir_statement: IMPRIMIR LPAREN exp RPAREN{ //imprimir un identificador
           /*if(variableGlobalFaltaEtiqueta==true){  //Hay que imprimir una etiqueta
                printf(yyout, "Etiqueta%d",numEtiqueta);
                numEtiqueta++;
            }*/
            //Evaluamos la expresión
            //double valor = iniciar_evaluacion($3.a); //Evaluar la exppresión para hacer la asignación
            //printf(">>>IMPRIMIR %f\n",valor);
            //Ya conocemos en que registro está el valor, que será float
            $$.a = new_node('P',$3.a, nodo_vacio());
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR: No quedan registros disponibles para realizar la operación imprimir\n");
            }
            
        }
    ;

asignacion_statement:
    ID IGUAL exp {
        printf("Asignacion con datos de tipo %s\n",$3.tipo);

        int i = lookup($1,table_size,table);
        if (i == -1) {  //Si no está en la tabla de símbolos, se crea uno nuevo
            if(strcmp($3.tipo, "entero")==0){
                table[table_size].name = $1;
                table[table_size].tipo = "entero";
                table[table_size].registro = $3.a->registro;
                table_size++;
            }
            //real string
            $$.a=new_node('A',$3.a, nodo_vacio());
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR: No quedan registros disponibles para realizar la operación asignacion\n");
            }

        }else{  //Ya se encuentra en la tabla de símbolos y se conoce su posición
            printf("Esta var se encuentra en el registro  $f%d\n",table[i].registro); 
            //Si lo encuentra, tiene que coger el resultado de exp y moverlo al registro
            //que tiene asignada la variable
            if(strcmp($3.tipo, "entero")==0){
                table[i].tipo = "entero";
            }
            //real string
            $$.a=new_node('R',$3.a, nodo_con_info_para_asignacion(table[i].registro));
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR: No quedan registros disponibles para realizar la operación asignacion\n");
            }            
        }
    }
    ;

//Si
si_statement: SI LPAREN condicion_list RPAREN statement_list osi_list FIN  {printf("Bucle SI con cadena de OSI\n");}
    | SI LPAREN condicion_list RPAREN statement_list FIN {
        printf("Bucle SI\n");
        $$.a = new_node('S',$3.a, $5.a);
        if($$.a->registro==-1){
            error_compilacion++;
            printf("ERROR: No quedan registros disponibles para realizar la sentencia SI\n");
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
        printf("Bucle MIENTRAS\n");
        $$.a = new_node('M',$3.a,$5.a);
        if($$.a->registro==-1){
            error_compilacion++;
            printf("ERROR: No quedan registros disponibles para realizar la sentencia MIENTRAS\n");
        }
    }
    ;

//Lista de condiciones
condicion_list: condicion_list DOBLEAMPERSAN  condicion {printf("Condicion && condicion\n");}
    | condicion_list DOBLEBARRA condicion {printf("Condicion || condicion\n");}
    | EXCLAMACION condicion {printf("!condicion\n");}
    | condicion {
        $$.a = $1.a;
        printf("\nCondicion\n");
        $$.a = new_node('C',$1.a, nodo_vacio());
        if($$.a->registro==-1){
            error_compilacion++;
            printf("ERROR: No quedan registros disponibles para realizar la operación condicion\n");
        }
        //double valor = iniciar_evaluacion($1.a); //$1.a->registro
        //printf(">>>Resultado evaluado comparacion MAYOR QUE= %f\n",valor);
    }

//Condiciones
/**
OJO AQUI HAY QUE EVALUAR LAS DOS EXPRESIONES ANTES DE COMPARAR NADA, SINO NO TIENES EL RESULTADO
**/
condicion: exp MAYQUE exp {
        printf("Condicion mayor que\n");
        if (strcmp($1.tipo, "texto")==0 || strcmp($3.tipo, "texto")==0) { 
            printf("\nOperacion no reconocida.\n");
        } else {
            $$.a = new_node('>', $1.a, $3.a);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR: No quedan registros disponibles para realizar la condicion 'mayor que'\n");
            }
            $$.tipo = "bool";
        }
        
    }
    | exp MENQUE exp   {
        printf("Condicion menor que\n");
        if (strcmp($1.tipo, "texto")==0 || strcmp($3.tipo, "texto")==0) { 
            printf("\nOperacion no reconocida.\n");
        } else {
            $$.a = new_node('<', $1.a, $3.a);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR: No quedan registros disponibles para realizar la condicion 'menor que'\n");
            }
            $$.tipo = "bool";
        }
    }
    | exp MAYORIGUAL exp {
        printf("Condicion mayor o igual que\n");
        if (strcmp($1.tipo, "texto")==0 || strcmp($3.tipo, "texto")==0) { 
            printf("\nOperacion no reconocida.\n");
        } else {
            $$.a = new_node('>=', $1.a, $3.a);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR: No quedan registros disponibles para realizar la condicion 'mayor o igual que'\n");
            }
            $$.tipo = "bool";
        }
    }
    | exp MENORIGUAL exp {
        printf("Condicion menor o igual que\n");
        if (strcmp($1.tipo, "texto")==0 || strcmp($3.tipo, "texto")==0) { 
            printf("\nOperacion no reconocida.\n");
        } else {
            $$.a = new_node('<=', $1.a, $3.a);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR: No quedan registros disponibles para realizar la condicion 'menor o igual que'\n");
            }
            $$.tipo = "bool";
        }
    }
    | exp IGUALIGUAL exp {
        printf("Condicion igual igual que\n");
        if (strcmp($1.tipo, "texto")==0 || strcmp($3.tipo, "texto")==0) { 
            printf("\nOperacion no reconocida.\n");
        } else {
            $$.a = new_node('==', $1.a, $3.a);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR: No quedan registros disponibles para realizar la condicion 'igual igual que'\n");
            }
            $$.tipo = "bool";
        }
    }

exp: exp MAS term {
        if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "entero")==0) { //Si ambos son enteros
            $$.a = new_node('+', $1.a,$3.a); 
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR: No quedan registros disponibles para realizar la operacion suma\n");
            }
            $$.tipo="entero";
            printf(" operacion(entero+entero): resultado = %ld\n", $1.entero+$3.entero);  
        }
        else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "real")==0){  //Si los dos son float
            $$.a = new_node('+', $1.a,$3.a);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR: No quedan registros disponibles para realizar la operacion suma\n");
            }
            $$.tipo="real";
            printf(" operacion(real+real): resultado = %f\n", $1.real+$3.real);
        }
        else if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "real")==0){  // Entero y real
            $$.a = new_node('+', $1.a,$3.a);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR: No quedan registros disponibles para realizar la operacion suma\n");
            }
            $$.tipo="real";
            printf("operacion(entero+real): resultado = %f\n", $1.entero+$3.real);
        }
        else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "entero")==0){  // Real y entero
            $$.a = new_node('+', $1.a,$3.a);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR: No quedan registros disponibles para realizar la operacion suma\n");
            }
            $$.tipo="real";
            printf("operacion(real+entero): resultado = %f\n", $1.real+$3.entero);
        }
        else{
            error_compilacion++;
            printf("ERROR: No se puede operar en línea %d",linea);
        }
    }
    | exp MENOS term {
        if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "entero")==0) { //Si ambos son enteros
            $$.a = new_node('-', $1.a,$3.a);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR: No quedan registros disponibles para realizar la operacion resta\n");
            }
            $$.tipo="entero";
            printf("operacion(entero-entero): resultado =  %ld\n", $1.entero-$3.entero);
        }
        else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "real")==0){  //Si los dos son float
            $$.a = new_node('-', $1.a,$3.a);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR: No quedan registros disponibles para realizar la operacion suma\n");
            }
            $$.tipo="real";
            printf("operacion(real-real): resultado = %f\n", $1.real-$3.real);
        }
        else if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "real")==0){  // Entero y real
            $$.a = new_node('-', $1.a,$3.a);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR: No quedan registros disponibles para realizar la operacion suma\n");
            }
            $$.tipo="real";
            printf("operacion(entero-real): resultado =	 %f\n", $1.entero-$3.real);
        }
        else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "entero")==0){  // Real y entero
            $$.a = new_node('-', $1.a,$3.a);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR: No quedan registros disponibles para realizar la operacion suma\n");
            }
            $$.tipo="real";
            printf("operacion(real-entero): resultado =	 %f\n", $1.real-$3.entero);
        }
        else{
                error_compilacion++;
                printf( "ERROR: No se puede operar");
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
            printf( "ERROR: No se puede concatenar algo que no sean cadenas de texto\n");
        }
    }
    | term {
        //printf("Termino con tipo %s\n",$1.tipo);
        $$ = $1; }   //Se hace una copia
    ;

term: term POR factor {
        if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "entero")==0) { //Si ambos son enteros
            $$.a = new_node('*', $1.a,$3.a);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR: No quedan registros disponibles para realizar la operacion multiplicar\n");
            }
            $$.tipo="entero";
            printf( "entero*entero = %ld\n", $$.entero);
        }
        else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "real")==0){  //Si los dos son float
            $$.a = new_node('*', $1.a,$3.a);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR: No quedan registros disponibles para realizar la operacion multiplicar\n");
            }
            $$.tipo="real";
            printf( "real*real = %f\n", $$.real);
        }
        else if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "real")==0){  // Entero y real
            $$.a = new_node('*', $1.a,$3.a);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR: No quedan registros disponibles para realizar la operacion multiplicar\n");
            }
            $$.tipo="real";
            printf( "entero*real = %f\n", $$.real);
        }
        else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "entero")==0){  // Real y entero
            $$.a = new_node('*', $1.a,$3.a);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR: No quedan registros disponibles para realizar la operacion multiplicar\n");
            }
            $$.tipo="real";
            printf( "real*entero = %f\n", $$.real);
        }
        else{
             error_compilacion++;
             printf( "ERROR: No se puede operar");
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
                printf("ERROR: No quedan registros disponibles para realizar la operacion dividir\n");
            } 
            $$.tipo="entero";
            printf( "entero/entero = %ld\n", $$.entero);
        }
        else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "real")==0){  //Si los dos son float
            $$.a = new_node('/', $1.a,$3.a); 
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR: No quedan registros disponibles para realizar la operacion dividir\n");
            } 
            $$.tipo="real";
            printf( "real/real = %f\n", $$.real);
        }
        else if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "real")==0){  // Entero y real
            $$.a = new_node('/', $1.a,$3.a); 
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR: No quedan registros disponibles para realizar la operacion dividir\n");
            } 
            $$.tipo="real";
            printf( "entero/real = %f\n", $$.real);
        }
        else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "entero")==0){  // Real y entero
            $$.a = new_node('/', $1.a,$3.a); 
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR: No quedan registros disponibles para realizar la operacion dividir\n");
            } 
            $$.tipo="real";
            printf( "real/entero = %f\n", $$.real);
        }
        else{
             error_compilacion++;
             printf( "ERROR: No se puede operar");
        }
    }

/**
OJO HAY QUE HACER ESTA OPERACIÓN EN EL AST Y ASM
**/
    | term MODULO factor { //solo se puede hacer con enteros
        if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "entero")==0) { //Si ambos son enteros
            $$.a = new_node('%', $1.a,$3.a); 
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR: No quedan registros disponibles para realizar la operacion modulo\n");
            } 
            $$.tipo="entero";
            printf( "entero %% entero = %ld\n", $$.entero);
        } else{
             error_compilacion++;
             printf( "ERROR: No se puede operar");
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
                printf("ERROR: No quedan registros disponibles para realizar la operacion exponente\n");
            } 
            $$.tipo="entero";
            printf( "entero^entero = %ld\n", $$.entero);
        } else{
             error_compilacion++;
             printf( "ERROR: No se puede operar");
        }
    }
    | factor {
        //printf("Factor con tipo %s\n",$1.tipo);
        $$ = $1;}
/**
OJO HAY QUE CONTROLAR EL USO DE VARIABLES EN EL AST
**/
    | ID {
            //printf("Hemos encontrado un identificador");
            //Hemos encontrado un identificador, hay que ver si está en la tabla para recogerlo y sino devolver un error
            int i = lookup($1,table_size,table); //lo buscamos
            if(i == -1){
                printf( "ERROR: Se usa un símbolo que no existe");
            }
            else{
                //Controlamos de que tipo es
                if(table[i].tipo=="entero"){
                    $$.tipo = table[i].tipo;

                    //Crear nodo hoja con números
                    $$.a = new_var_leaf_num(table[i].entero,table[i].registro);    
                }
                else if(table[i].tipo=="real"){
                    $$.tipo = table[i].tipo;      
                    
                    //Crear nodo hoja con números
                    $$.a = new_var_leaf_num(table[i].real,table[i].registro);        
                }
                else if(table[i].tipo=="texto"){
                    $$.tipo = table[i].tipo;

   //CREAR NODO TEXTO             
                }
                else{printf("ERROR: Variable de tipo desconocido");}

            }
        }
    ;

factor: ENT {$$.entero = $1;
            $$.a = new_leaf_num($1);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR: No quedan registros disponibles para asignar el entero %ld\n", $$.entero);
            }  
            $$.tipo="entero"; 
            printf( "Variable de tipo ENTERO: %ld\n", $$.entero);}   
    | MENOS ENT {$$.entero = -$2;
            $$.a = new_leaf_num(-$2);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR: No quedan registros disponibles para asignar el entero %ld\n", $$.entero);
            }
            $$.tipo="entero";
            printf( "Variable de tipo ENTERO NEGATIVO: %ld\n", $$.entero);}
    | REAL {$$.real = $1;
            $$.a = new_leaf_num($1);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR: No quedan registros disponibles para asignar el real %f\n", $$.real);
            }
            $$.tipo="real";
            printf( "Variable de tipo REAL: %f\n", $$.real);}
    | MENOS REAL {$$.real = -$2;
            $$.a = new_leaf_num(-$2);
            if($$.a->registro==-1){
                error_compilacion++;
                printf("ERROR: No quedan registros disponibles para asignar el real %f\n", $$.real);
            }
            $$.tipo="real";
            printf( "Variable de tipo REAL NEGATIVO: %f\n", $$.real);}
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
    yyout = fopen( "./prueba.asm", "wt" );
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