/*
ESTE EJEMPLO HACEPTA UNA GRAMÁTICA: identificador=valor;operación
Ejemplo:
    mivariable=9;mivariable+3
*/
%{
#include <ctype.h>
#include <stdio.h>
#include <string.h> //Esta librería de C nos permite comparar los tipos con la funcion strcmp()
#include <stdlib.h> //Para usar malloc
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

/* Los no terminales hacen uso de la estructura */
%type <st> exp term factor asignacion

/* Declarar tokens recogidos de FLEX*/
%token MAS MENOS POR DIV PAR_OP PAR_CL CONCAT COMILLA IGUAL PUNTOCOMA

/*Los que son números hay que definir su tipo */
%token <intVal> ENT
%token <floatVal> REAL
%token <stringVal> TEXT
//Definir la asociatividad. POR y DIV tienen mayor precedencia que MAS y MENOS
%left MAS MENOS
%left  POR DIV  
%left IGUAL PUNTOCOMA

%start command
%%
command: exp {  if(error_compilacion>=1){
                    printf("\nHa habido %d error(es) de compilacion",error_compilacion);
                }else{
                    printf(">>>TERMINADO\n");
                    //EVALUAR
                    double valor = eval($1.a);
                    printf(">>>Resultado evaluado = %f\n",valor);
                    /*
                    if(strcmp($1.tipo, "entero")==0){printf(" El resultado entero es %d\n", $1.entero); }
                    else if (strcmp($1.tipo, "real")==0){printf(" El resultado real es %f\n", $1.real); }
                    else if (strcmp($1.tipo, "texto")==0){printf(" El resultado texto es %s\n", $1.texto); }     
                    else {printf(" ERROR: LA variable no tiene tipo");}  
                    */
                }
            }
        | asignacion PUNTOCOMA exp {  if(error_compilacion>=1){
                    printf("\nHa habido %d error(es) de compilacion",error_compilacion);
                }else{
                    printf(error_compilacion);
                    if(strcmp($3.tipo, "entero")==0){printf(" El resultado entero es %d\n", $3.entero); }
                    else if (strcmp($3.tipo, "real")==0){printf(" El resultado real es %f\n", $3.real); }
                    else if (strcmp($3.tipo, "texto")==0){printf(" El resultado texto es %s\n", $3.texto); }     
                    else {printf(" ERROR: LA variable no tiene tipo");}  
                }
            }
   ;
asignacion: TEXT IGUAL exp{
    printf("Asignacion\n");
        int i = lookup($1,table_size,table);
        if (i == -1) { // Si el símbolo no está en la tabla, se agrega
        printf("-> Se crea\n");
            if(strcmp($3.tipo, "entero")==0){
                table[table_size].name = $1;
                table[table_size].entero = $3.entero;
                table[table_size].tipo = "entero";
                table_size++;
            }
            else if(strcmp($3.tipo, "real")==0){
                table[table_size].name = $1;
                table[table_size].real = $3.real;
                table[table_size].tipo = "real";
                table_size++;
            }
            else if(strcmp($3.tipo, "texto")==0){
                table[table_size].name = $1;
                table[table_size].texto = $3.texto;
                table[table_size].tipo = "texto";
                table_size++;
            }
            else{
                printf("ERROR: El tipo de variable a asignar no se reconoce");
            }

        } else { // Si el símbolo ya está en la tabla, se actualiza su valor
        printf("-> Se actualiza\n");
            table[i].entero = $3.entero;
        }
}
;

/*
exp: exp MAS term
    |exp MENOS term
    |exp CONCAT term 
    |term
*/
exp: exp MAS term {
        if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "entero")==0) { //Si ambos son enteros
            $$.a = new_node('+',"entero", $1.a,$3.a);
            $$.tipo="entero";
            printf( "entero+entero\n");
        }
        else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "real")==0){  //Si los dos son float
            $$.a = new_node('+',"real", $1.a,$3.a);
            $$.tipo="real";
            printf( "real+real\n");
        }
        else if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "real")==0){  // Entero y real
            $$.a = new_node('+',"real", $1.a,$3.a);
            $$.tipo="real";
            printf( "entero+real \n");
        }
        else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "entero")==0){  // Real y entero
            $$.a = new_node('+',"real", $1.a,$3.a);
            $$.tipo="real";
            printf( "real+entero\n");
        }
        else{
            error_compilacion++;
            printf( "ERROR: No se puede operar en línea %d",linea);
        }
    }
    | exp MENOS term {
        if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "entero")==0) { //Si ambos son enteros
            $$.a = new_node('-',"entero", $1.a,$3.a);
            $$.tipo="entero";
            printf( "entero-entero \n");
        }
        else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "real")==0){  //Si los dos son float
            $$.a = new_node('-',"real", $1.a,$3.a);
            $$.tipo="real";
            printf( "real-real\n");
        }
        else if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "real")==0){  // Entero y real
            $$.a = new_node('-',"real", $1.a,$3.a);
            $$.tipo="real";
            printf( "entero-real\n");
        }
        else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "entero")==0){  // Real y entero
            $$.a = new_node('-',"real", $1.a,$3.a);
            $$.tipo="real";
            printf( "real-entero\n");
        }
        else{
                error_compilacion++;
                printf( "ERROR: No se puede operar");
        }
    }
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

/*
term: term POR factor
    | term DIV factor
*/
term: term POR factor {
        if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "entero")==0) { //Si ambos son enteros
            $$.a = new_node('*',"entero", $1.a,$3.a);
            $$.tipo="entero";
            printf( "entero*entero\n");
        }
        else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "real")==0){  //Si los dos son float
            $$.a = new_node('*',"real", $1.a,$3.a);
            $$.tipo="real";
            printf( "real*real\n");
        }
        else if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "real")==0){  // Entero y real
            $$.a = new_node('*',"real", $1.a,$3.a);
            $$.tipo="real";
            printf( "entero*real\n");
        }
        else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "entero")==0){  // Real y entero
            $$.a = new_node('*',"real", $1.a,$3.a);
            $$.tipo="real";
            printf( "real*entero\n");
        }
        else{
             error_compilacion++;
             printf( "ERROR: No se puede operar");
        }
    }
    | term DIV factor {
        if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "entero")==0) { //Si ambos son enteros
            $$.a = new_node('/',"real", $1.a,$3.a); 
            $$.tipo="real";
            printf( "entero/entero->real \n");
        }
        else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "real")==0){  //Si los dos son float
            $$.a = new_node('/',"real", $1.a,$3.a); 
            $$.tipo="real";
            printf( "real/real \n");
        }
        else if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "real")==0){  // Entero y real
            $$.a = new_node('/',"real", $1.a,$3.a); 
            $$.tipo="real";
            printf( "entero/real \n");
        }
        else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "entero")==0){  // Real y entero
            $$.a = new_node('/',"real", $1.a,$3.a); 
            $$.tipo="real";
            printf( "real/entero \n");
        }
        else{
             error_compilacion++;
             printf( "ERROR: No se puede operar");
        }
    }
    | factor {$$ = $1;} //Se hace una copia
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
                $$.a = new_leaf_num(table[i].entero,"entero");    
            }
            else if(table[i].tipo=="real"){
                $$.tipo = table[i].tipo;
                //$$.real = table[i].real;           

                //Crear nodo hoja con números
                $$.a = new_leaf_num(table[i].real,"real");        
            }
            else if(table[i].tipo=="texto"){
                $$.tipo = table[i].tipo;
                //$$.texto = table[i].texto;   

                //Crear nodo hoja con texto
                $$.a = new_leaf_text(table[i].texto,"string");                
            }
            else{printf("ERROR: Variable de tipo desconocido");}

        }
        }
    ;

    
//Definir los números enteros y reales y sus tipos
factor: ENT {
            $$.entero = $1; //Asignar el valor a .entero
            $$.a = new_leaf_num($1,"entero");    
            $$.tipo="entero"; //Definir el tipo a "entero"
            printf( "ENTERO %ld\n", $$.entero);}   //Imprimir por pantalla lo que se acaba de hacer
    | MAS ENT {
            $$.entero = $2;
            $$.a = new_leaf_num($2,"entero");
            $$.tipo="entero";
            printf( "ENTERO POSITIVO %ld\n", $$.entero);}
    | MENOS ENT {
            $$.entero = -$2;
            $$.a = new_leaf_num(-$2,"entero");
              $$.tipo="entero";
              printf( "ENTERO NEGATIVO %ld\n", $$.entero);}

//Reales
    | REAL {
            $$.real = $1;
            $$.a = new_leaf_num($1,"real");
            $$.tipo="real";
            printf( "REAL  %f\n", $$.real);}
    | MAS REAL {
            $$.real = $2;
            $$.a = new_leaf_num($2,"real");
                $$.tipo="real";
                printf( "REAL POSITIVO %f\n", $$.real);}
    | MENOS REAL {
                $$.real = -$2;
                $$.a = new_leaf_num(-$2,"real");
                  $$.tipo="real";
                  printf( "REAL NEGATIVO %f\n", $$.real);}

    | PAR_OP exp PAR_CL {$$ = $2;//Se hace una copia
                        printf( "PARENTESIS \n");}
//Texto
    | COMILLA TEXT COMILLA {$$.texto = $2;
            $$.tipo="texto";
            printf(" TEXTO %s\n", $$.texto);}
    ;

%%

main()
{ 
    yyout = fopen( "./prueba.asm", "wt" );
	yyparse();
    return 0;
}


yyerror()
{ 
} 
