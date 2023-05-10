/*
ESTE EJEMPLO HACEPTA UNA GRAMÁTICA: identificador=valor;operación
Ejemplo:
    mivariable=9;mivariable+3
*/
%{
#include <ctype.h>
#include <stdio.h>
#include <math.h> //Para el pow, funcion para hacer el exponente EXPON
#include <string.h> //Esta librería de C nos permite comparar los tipos con la funcion strcmp()
#include "simbol_table.h"


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
    float real;
    int entero;
    char* texto;
    char* tipo; //Cadena de caracteres que almacena textualmente el tipo del elemento para poder ofrecer controles semánticos sobre el mismo
  }st;
}

/* Los no terminales hacen uso de la estructura */
%type <st> factor comparacion

/* Declarar tokens recogidos de FLEX*/
%token MAS MENOS POR DIV MODULO EXPON PAR_OP PAR_CL CONCAT COMILLA IGUAL IGUALIGUAL 
%token DIFERENTE MENORIGUAL MAYORIGUAL PUNTOCOMA SI OSI SINO FIN MAYORQUE MENORQUE

/*Los que son números hay que definir su tipo */
%token <intVal> ENT
%token <floatVal> REAL
%token <stringVal> TEXT
//Definir la asociatividad. POR y DIV tienen mayor precedencia que MAS y MENOS
%left MAS MENOS
%left  POR DIV  
%left MODULO EXPON
%left IGUAL PUNTOCOMA

%start command
%%

command: SI PAR_OP comparacion PAR_CL FIN { 
                    if ($3.entero == 1) {
                        printf("Entramos en el if (enteros)");
                    } else if ($3.real == 1.0) {
                        printf("Entreamos en el if (reales)");
                    } else {
                        printf("No entramos en el if");
                    }
                printf("\nHemos llegado al final del arbol\n");
            }
;

comparacion: factor MAYORQUE factor {
                printf("Comparacion MAYORQUE");
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
                    printf("\nOperacion no reconocida.\n")
                }
            }
            | factor MENORQUE factor {
                printf("Comparacion MENORQUE");
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
                    printf("\nOperacion no reconocida.\n")
                }
            }
            | factor IGUALIGUAL factor {
                printf("Comparacion IGUAL IGUAL");
                if (strcmp($1.tipo, "entero")== 0 && strcmp($3.tipo, "entero")==0) {
                    if ($1.entero == $3.entero) {
                        $$.entero = 1;
                        $$.tipo = "bool";
                        printf( "\nentero==entero");
                    } else {
                        $$.entero = 0;
                        $$.tipo = "bool";
                        printf( "\nentero!=entero");
                    }
                } else if (strcmp($1.tipo, "real")== 0 && strcmp($3.tipo, "real")==0) {
                    if ($1.real == $3.real) {
                        $$.real = 1.0;
                        $$.tipo = "bool";
                        printf( "\nreal==real");
                    } else {
                        $$.real = 0.0;
                        $$.tipo = "bool";
                        printf( "\nreal!=real");
                    }
                } else {
                    printf("\nOperacion no reconocida.\n")
                }
            }
            | factor DIFERENTE factor {
                printf("Comparacion DIFERENTE");
                if (strcmp($1.tipo, "entero")== 0 && strcmp($3.tipo, "entero")==0) {
                    if ($1.entero != $3.entero) {
                        $$.entero = 1;
                        $$.tipo = "bool";
                        printf( "\nentero!=entero");
                    } else {
                        $$.entero = 0;
                        $$.tipo = "bool";
                        printf( "\nentero==entero");
                    }
                } else if (strcmp($1.tipo, "real")== 0 && strcmp($3.tipo, "real")==0) {
                    if ($1.real != $3.real) {
                        $$.entero = 1;
                        $$.tipo = "bool";
                        printf( "\real!=real");
                    } else {
                        $$.real = 0.0;
                        $$.tipo = "bool";
                        printf( "\nreal==real");
                    }
                } else {
                    printf("\nOperacion no reconocida.\n")
                }
            } 
            | factor MAYORIGUAL factor {
                printf("Comparacion MAYORIGUAL");
                if (strcmp($1.tipo, "entero")== 0 && strcmp($3.tipo, "entero")==0) {
                    if ($1.entero >= $3.entero) {
                        $$.entero = 1;
                        $$.tipo = "bool";
                        printf( "\nentero>=entero");
                    } else {
                        $$.entero = 0;
                        $$.tipo = "bool";
                        printf( "\nentero<=entero");
                    }
                } else if (strcmp($1.tipo, "real")== 0 && strcmp($3.tipo, "real")==0) {
                    if ($1.real >= $3.real) {
                        $$.real = 1.0;
                        $$.tipo = "bool";
                        printf( "\nreal>=real");
                    } else {
                        $$.real = 0.0;
                        $$.tipo = "bool";
                        printf( "\nreal<=real");
                    } 
                } else if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "real")==0) {
                    if ($1.entero >= $3.real) {
                        $$.real = 1.0;
                        $$.tipo = "bool";
                        printf( "\nentero>=real");
                    } else {
                        $$.real = 0.0;
                        $$.tipo = "bool";
                        printf( "\nentero<=real");
                    }
                } else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "entero")==0) {
                    if ($1.real >= $3.entero) {
                        $$.real = 1.0;
                        $$.tipo = "bool";
                        printf( "\nreal>=entero");
                    } else {
                        $$.real = 0.0;
                        $$.tipo = "bool";
                        printf( "\nreal<=entero");
                    }
                } else {
                    printf("\nOperacion no reconocida.\n")
                }
            }
            | factor MENORIGUAL factor {
                printf("Comparacion MENORIGUAL");
                if (strcmp($1.tipo, "entero")== 0 && strcmp($3.tipo, "entero")==0) {
                    if ($1.entero <= $3.entero) {
                        $$.entero = 1;
                        $$.tipo = "bool";
                        printf( "\nentero<=entero");
                    } else {
                        $$.entero = 0;
                        $$.tipo = "bool";
                        printf( "\nentero>=entero");
                    }
                } else if (strcmp($1.tipo, "real")== 0 && strcmp($3.tipo, "real")==0) {
                    if ($1.real <= $3.real) {
                        $$.real = 1.0;
                        $$.tipo = "bool";
                        printf( "\nreal<=real");
                    } else {
                        $$.real = 0.0;
                        $$.tipo = "bool";
                        printf( "\nreal>=real");
                    } 
                } else if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "real")==0) {
                    if ($1.entero <= $3.real) {
                        $$.real = 1.0;
                        $$.tipo = "bool";
                        printf( "\nentero<=real");
                    } else {
                        $$.real = 0.0;
                        $$.tipo = "bool";
                        printf( "\nentero>=real");
                    }
                } else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "entero")==0) {
                    if ($1.real <= $3.entero) {
                        $$.real = 1.0;
                        $$.tipo = "bool";
                        printf( "\nreal<=entero");
                    } else {
                        $$.real = 0.0;
                        $$.tipo = "bool";
                        printf( "\nreal>=entero");
                    }
                } else {
                    printf("\nOperacion no reconocida.\n")
                }
            }
;

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
//Texto
    | COMILLA TEXT COMILLA {$$.texto = $2;
            $$.tipo="texto";
            printf(" TEXTO %s\n", $$.texto);}
    ;



%%

main()
{ return yyparse();
}


yyerror()
{ 
} 
