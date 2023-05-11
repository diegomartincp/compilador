%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "simbol_table.h"
#include "AST_V2.h"

FILE *yyout;

//Variables
int error_compilacion=0;
int linea=1;

//Variables de la tabla de símbolos
symbol table[100];
int table_size = 0;//Se usa para conocer el índice del array disponible para insertar el siguiente número

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
%token EXCLAMACION MAYQUE MENQUE MODULO EXPON
%token PUNTOCOMA

/* Los no terminales hacen uso de la estructura */
%type <st> statement_list term factor statement exp asignacion_statement si_statement osi_list osi mientras_statement
%type <st> condicion_list condicion 

%token <intVal> ENT
%token <floatVal> REAL
%token <stringVal> TEXT

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
    }
    ;

//Varias cosas encadenadas
statement_list:
    statement
    | statement_list statement
    ;

//Una signación, IF o WHILE
statement:
    asignacion_statement {
        printf("Statement reconocido\n")
    }
    | si_statement {
        printf("Si statment reconocido \n");
    }
    | mientras_statement {
        printf("Mientras statement \n")
    }
    | imprimir_statement {
        printf("Mientras statement \n")
    }
    ;

imprimir_statement: IMPRIMIR LPAREN TEXT RPAREN
    | IMPRIMIR LPAREN exp RPAREN
    ;

asignacion_statement:
    TEXT IGUAL exp {
        printf("Asignacion\n");
        double valor = iniciar_evaluacion($3.a); //Evaluar la exppresión para hacer la asignación
        printf(">>>Resultado evaluado = %f\n",valor);
        int i = lookup($1,table_size,table);
        if (i == -1) {
            printf(">>>Se asigna la variable en tabla de símbolos\n");
            if(strcmp($3.tipo, "entero")==0){
                table[table_size].name = $1;
                table[table_size].entero = (int)valor;
                table[table_size].tipo = "entero";
                table[table_size].registro = $3.a->registro;   //Al asignar guarda en la tabla de símbolos el registro donde se almacena el resultado
                table_size++;
            }
            else if(strcmp($3.tipo, "real")==0){
                table[table_size].name = $1;
                table[table_size].real = (float)valor;
                table[table_size].tipo = "real";
                table[table_size].registro = $3.a->registro;
                table_size++;
            }
            else if(strcmp($3.tipo, "texto")==0){
                table[table_size].name = $1;
                table[table_size].texto = $3.texto;
                table[table_size].tipo = "texto";
                table[table_size].registro = $3.a->registro;
                table_size++;
            }
            else{
                printf("ERROR: El tipo de variable a asignar no se reconoce");
            }
        }else{//Si ya existía la variable y la hemos sobreescrito
            printf(">>>Se sobreescribe el valor de la variable: %s\n",table[i].name = $1);
            if(strcmp($3.tipo, "entero")==0){
                table[i].name = $1;
                table[i].entero = (int)valor;
                table[i].tipo = "entero";
                table[i].registro = $3.a->registro;   //Al asignar guarda en la tabla de símbolos el registro donde se almacena el resultado
                //En este caso no se incrementa el tamaño del array
            }
            else if(strcmp($3.tipo, "real")==0){
                table[i].name = $1;
                table[i].real = (float)valor;
                table[i].tipo = "real";
                table[i].registro = $3.a->registro;
                //
            }
            else if(strcmp($3.tipo, "texto")==0){
                table[i].name = $1;
                table[i].texto = $3.texto;
                table[i].tipo = "texto";
                table[i].registro = $3.a->registro;
                //
            }
        }
    }
    ;

//Si
si_statement: SI LPAREN condicion_list RPAREN statement_list osi_list FIN  {printf("SI con cadena de OSI\n");}
    | SI LPAREN condicion_list RPAREN statement_list FIN {
        printf("SI\n");
        if ($3.entero == 1) {
            printf("Entramos en el if (enteros)");
        } else if ($3.real == 1.0) {
            printf("Entreamos en el if (reales)");
        } else {
            printf("No entramos en el if");
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
    MIENTRAS LPAREN condicion_list RPAREN statement_list FIN {printf("MIENTRAS\n");}
    ;

//Lista de condiciones
condicion_list: condicion_list DOBLEAMPERSAN  condicion {printf("Condicion && condicion\n");}
    | condicion_list DOBLEBARRA condicion {printf("Condicion || condicion\n");}
    | EXCLAMACION condicion {printf("!condicion\n");}
    | condicion {printf("\nCondicion\n");}

//Condiciones
/**
OJO AQUI HAY QUE EVALUAR LAS DOS EXPRESIONES ANTES DE COMPARAR NADA, SINO NO TIENES EL RESULTADO
**/
condicion: exp MAYQUE exp {
        printf("Condicion mayor que\n");
        if (strcmp($1.tipo, "entero")== 0 && strcmp($3.tipo, "entero")==0) {
            if ($1.entero > $3.entero) {
                $$.entero = 1;
                $$.tipo = "bool";
                printf( "\nentero>entero");
            } else {
                $$.entero = 0;
                $$.tipo = "bool";
                printf( "\nentero<entero");
            }
        } else if (strcmp($1.tipo, "real")== 0 && strcmp($3.tipo, "real")==0) {
            if ($1.real > $3.real) {
                $$.real = 1.0;
                $$.tipo = "bool";
                printf( "\nreal>real");
            } else {
                $$.real = 0.0;
                $$.tipo = "bool";
                printf( "\nreal<real");
            } 
        } else if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "real")==0) {
            if ($1.entero > $3.real) {
                $$.real = 1.0;
                $$.tipo = "bool";
                printf( "\nentero>real");
            } else {
                $$.real = 0.0;
                $$.tipo = "bool";
                printf( "\nentero<real");
            }
        } else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "entero")==0) {
            if ($1.real > $3.entero) {
                $$.real = 1.0;
                $$.tipo = "bool";
                printf( "\nreal>entero");
            } else {
                $$.real = 0.0;
                $$.tipo = "bool";
                printf( "\nreal<entero");
            }
        } else {
            printf("\nOperacion no reconocida.\n");
        }
    }
    | exp MENQUE exp   {
        printf("Condicion menor que\n");
        if (strcmp($1.tipo, "entero")== 0 && strcmp($3.tipo, "entero")==0) {
            if ($1.entero < $3.entero) {
                $$.entero = 1;
                $$.tipo = "bool";
                printf( "\nentero<entero");
            } else {
                $$.entero = 0;
                $$.tipo = "bool";
                printf( "\nentero>entero");
            }
        } else if (strcmp($1.tipo, "real")== 0 && strcmp($3.tipo, "real")==0) {
            if ($1.real < $3.real) {
                $$.real = 1.0;
                $$.tipo = "bool";
                printf( "\nreal<real");
            } else {
                $$.real = 0.0;
                $$.tipo = "bool";
                printf( "\nreal>real");
            } 
        } else if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "real")==0) {
            if ($1.entero < $3.real) {
                $$.real = 1.0;
                $$.tipo = "bool";
                printf( "\nentero<real");
            } else {
                $$.real = 0.0;
                $$.tipo = "bool";
                printf( "\nentero>real");
            }
        } else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "entero")==0) {
            if ($1.real < $3.entero) {
                $$.real = 1.0;
                $$.tipo = "bool";
                printf( "\nreal<entero");
            } else {
                $$.real = 0.0;
                $$.tipo = "bool";
                printf( "\nreal>entero");
            }
        } else {
            printf("\nOperacion no reconocida.\n");
        }
    }
    | exp MAYQUE IGUAL exp {
        printf("Condicion mayor o igual que\n");
    }
    | exp MENQUE IGUAL exp {
        printf("Condicion menor o igual que\n");
    }
    | exp IGUAL IGUAL exp {
        printf("Condicion igual igual que\n");
    }

exp: exp MAS term {
        if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "entero")==0) { //Si ambos son enteros
            $$.a = new_node('+', $1.a,$3.a); 
            $$.tipo="entero";
            printf( "entero+entero = %ld\n", $$.entero);
        }
        else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "real")==0){  //Si los dos son float
            $$.a = new_node('+', $1.a,$3.a);
            $$.tipo="real";
            printf( "real+real = %f\n", $$.real);
        }
        else if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "real")==0){  // Entero y real
            $$.a = new_node('+', $1.a,$3.a);
            $$.tipo="real";
            printf( "entero+real = %f\n", $$.real);
        }
        else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "entero")==0){  // Real y entero
            $$.a = new_node('+', $1.a,$3.a);
            $$.tipo="real";
            printf( "real+entero = %f\n", $$.real);
        }
        else{
            error_compilacion++;
            printf( "ERROR: No se puede operar en línea %d",linea);
        }
    }
    | exp MENOS term {
        if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "entero")==0) { //Si ambos son enteros
            $$.a = new_node('-', $1.a,$3.a);
            $$.tipo="entero";
            printf( "entero-entero = %ld\n", $$.entero);
        }
        else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "real")==0){  //Si los dos son float
            $$.a = new_node('-', $1.a,$3.a);
            $$.tipo="real";
            printf( "real-real = %f\n", $$.real);
        }
        else if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "real")==0){  // Entero y real
            $$.a = new_node('-', $1.a,$3.a);
            $$.tipo="real";
            printf( "entero-real = %f\n", $$.real);
        }
        else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "entero")==0){  // Real y entero
            $$.a = new_node('-', $1.a,$3.a);
            $$.tipo="real";
            printf( "real-entero = %f\n", $$.real);
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
            printf( "ERROR: No se puede concatenar algo que no sean cadenas de texto");
        }
    }
    | term {$$ = $1; }   //Se hace una copia
    ;

term: term POR factor {
        if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "entero")==0) { //Si ambos son enteros
            $$.a = new_node('*', $1.a,$3.a);
            $$.tipo="entero";
            printf( "entero*entero = %ld\n", $$.entero);
        }
        else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "real")==0){  //Si los dos son float
            $$.a = new_node('*', $1.a,$3.a);
            $$.tipo="real";
            printf( "real*real = %f\n", $$.real);
        }
        else if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "real")==0){  // Entero y real
            $$.a = new_node('*', $1.a,$3.a);
            $$.tipo="real";
            printf( "entero*real = %f\n", $$.real);
        }
        else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "entero")==0){  // Real y entero
            $$.a = new_node('*', $1.a,$3.a);
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
            $$.tipo="entero";
            printf( "entero/entero = %ld\n", $$.entero);
        }
        else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "real")==0){  //Si los dos son float
            $$.a = new_node('/', $1.a,$3.a); 
            $$.tipo="real";
            printf( "real/real = %f\n", $$.real);
        }
        else if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "real")==0){  // Entero y real
            $$.a = new_node('/', $1.a,$3.a); 
            $$.tipo="real";
            printf( "entero/real = %f\n", $$.real);
        }
        else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "entero")==0){  // Real y entero
            $$.a = new_node('/', $1.a,$3.a); 
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
            $$.entero = $1.entero % $3.entero;
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
            $$.entero = pow($1.entero, $3.entero);
            $$.tipo="entero";
            printf( "entero^entero = %ld\n", $$.entero);
        } else{
             error_compilacion++;
             printf( "ERROR: No se puede operar");
        }
    }
    | factor {$$ = $1;}
/**
OJO HAY QUE CONTROLAR EL USO DE VARIABLES EN EL AST
**/
    | TEXT {
            //Hemos encontrado un identificador, hay que ver si está en la tabla para recogerlo y sino devolver un error
            int i = lookup($1,table_size,table); //lo buscamos
            if(i == -1){
                printf( "ERROR: Se usa un símbolo que no existe");
            }
            else{
                //Controlamos de que tipo es
                if(table[i].tipo=="entero"){
                    $$.tipo = table[i].tipo;
 
                    //$$.entero = table[i].entero;

                    //Crear nodo hoja con números
                    $$.a = new_var_leaf_num(table[i].entero,table[i].registro);    
                }
                else if(table[i].tipo=="real"){
                    $$.tipo = table[i].tipo;
                    //$$.real = table[i].real;           
                    
                    //Crear nodo hoja con números
                    $$.a = new_var_leaf_num(table[i].real,table[i].registro);        
                }
                else if(table[i].tipo=="texto"){
                    $$.tipo = table[i].tipo;
                    //$$.texto = table[i].texto;   
                    //$$.a = new_leaf_num($1); 
                    //Crear nodo hoja con texto
                    //$$.a = new_leaf_text(table[i].texto);                
                }
                else{printf("ERROR: Variable de tipo desconocido");}

            }
        }
    ;

factor: ENT {$$.entero = $1;
            $$.a = new_leaf_num($1); 
            $$.tipo="entero"; 
            printf( "ENTERO %ld\n", $$.entero);}   
    | MENOS ENT {$$.entero = -$2;
            $$.a = new_leaf_num(-$2);
            $$.tipo="entero";
            printf( "ENTERO NEGATIVO %ld\n", $$.entero);}
    | REAL {$$.real = $1;
            $$.a = new_leaf_num($1);
            $$.tipo="real";
            printf( "REAL  %f\n", $$.real);}
    | MAS REAL {$$.real = $2;
            $$.tipo="real";
            printf( "REAL POSITIVO %f\n", $$.real);}
    | MENOS REAL {$$.real = -$2;
            $$.a = new_leaf_num(-$2);
            $$.tipo="real";
            printf( "REAL NEGATIVO %f\n", $$.real);}
    | LPAREN exp RPAREN {
            $$ = $2;
            printf("PARENTESIS\n");}
    | COMILLA TEXT COMILLA {
            $$.texto = $2;
            $$.tipo="texto";
            printf(" TEXTO %s\n", $$.texto);}
    ;
%%

int main() {
    yyout = fopen( "./prueba.asm", "wt" );
	yyparse();
    return 0;
}

void yyerror(const char* s) {
    fprintf(stderr, "%s\n", s);
}

int yywrap() {
    return 1;
}