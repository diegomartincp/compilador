//Pruebas de controles semánticos
%{
#include <ctype.h>
#include <stdio.h>
#include <string.h> //Esta librería de C nos permite comparar los tipos con la funcion strcmp()
#include <stdlib.h> //Se usa en la tabla de símbolos
#include "simbol_table.h" //Mi librería con las funciones para la tabla de símbolos

//Variables
int error_compilacion=0;
int linea=1;

//Variables de la tabla de símbolos
symbol table[100];
int table_size = 0;//Se usa para conocer el índice del array disponible para insertar el siguiente número

//TABLA
/*
// Declaración de la tabla de símbolos
typedef struct {
    char *name;
    char *tipo;
    float real;
    int entero;
    char* texto;
} symbol;

symbol table[100];
int table_size = 0;//Se usa para conocer el índice del array disponible para insertar el siguiente número

// Función para buscar un símbolo en la tabla
int lookup(char *name) {
    for (int i = 0; i < table_size; i++) {
        if (strcmp(table[i].name, name) == 0) {
            return i; //Devuelve la posición de la lista
        } 
    }
    return -1;  //-1 si no está en la tabla
}
*/
//FIN TABLA

%}


/* declare type possibilities of symbols */
%union {
  int intVal;
  float floatVal;
  char* stringVal;
  struct atributos{
    float real;
    int entero;
    char* texto;
    char* tipo; //Cadena de caracteres que almacena textualmente el tipo del elemento para poder ofrecer controles semánticos sobre el mismo
  }st;
}

/* Los no terminales hacen uso de la estructura */
%type <st> exp factor 

/* Declarar tokens recogidos de FLEX*/
%token MAS MENOS IGUAL PAR_OP PAR_CL PUNTOCOMA

/*Los que son números hay que definir su tipo */
%token <intVal> ENT
%token <floatVal> REAL
%token <stringVal> ID
//Definir la asociatividad. POR y DIV tienen mayor precedencia que MAS y MENOS
%left MAS MENOS


%start command
%%
command: exp {   printf("Compilacion terminada\n");
                  //Vamos a ver si existe en la tabla "Ejemplo"
                  int lugar = lookup("Ejemplo");
                  printf("lugar - %d\n",lugar);
                  if(lugar>-1){ //Si existe
                    printf("Existe en posicion: %d\n",lugar);
                    printf("Nombre: %s\n", table[lugar].name);
                    printf("Valor: %d\n", table[lugar].entero);
                  }
                  
            }
   ;


exp: exp PUNTOCOMA exp {
     printf("exp PUNTOCOMA exp\n");

    }
    | ID IGUAL factor {
        printf("ID IGUAL factor\n");
        int i = lookup($1);
        printf("-> No exister\n");
        if (i == -1) { // Si el símbolo no está en la tabla, se agrega
        printf("-> Se crea\n");
            table[table_size].name = $1;
            table[table_size].entero = $3.entero;
            table_size++;
            printf("-> Tamano:%d\n",table_size);
        } else { // Si el símbolo ya está en la tabla, se actualiza su valor
            table[i].entero = $3.entero;
        }
    }
    ;

/*
term: term POR factor
    | term DIV factor
*/

    
//Definir los números enteros y reales y sus tipos
factor: ENT {$$.entero = $1; //Asignar el valor a .entero
            $$.tipo="entero"; //Definir el tipo a "entero"
            printf( "ENTERO %ld\n", $$.entero);}   //Imprimir por pantalla lo que se acaba de hacer
    | MAS ENT {$$.entero = $2;
              $$.tipo="entero";
              printf( "ENTERO POSITIVO %ld\n", $$.entero);}
    | MENOS ENT {$$.entero = -$2;
              $$.tipo="entero";
              printf( "ENTERO NEGATIVO %ld\n", $$.entero);}

//Reales
    | REAL {$$.real = $1;
            $$.tipo="real";
            printf( "REAL  %f\n", $$.real);}
    | MAS REAL {$$.real = $2;
                $$.tipo="real";
                printf( "REAL POSITIVO %f\n", $$.real);}
    | MENOS REAL {$$.real = -$2;
                  $$.tipo="real";
                  printf( "REAL NEGATIVO %f\n", $$.real);}

    | PAR_OP exp PAR_CL {$$ = $2;//Se hace una copia
                        printf( "PARENTESIS \n");}

    ;

%%

main()
{ return yyparse();
}


yyerror()
{ 
} 
