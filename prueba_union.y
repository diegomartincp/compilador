//ESTE EJEMPLO SOLO FUNCIONA CON ENTEROS, SE HAN INTRODUCIDO LOS REALES SOLO PARA VER QUE LOS RECONOCE
%{
#include <ctype.h>
#include <stdio.h>
%}

/* declare type possibilities of symbols */
%union {
  int intVal;
  float floatVal;
  char* stringVal;
  struct atributos{
    float real;
    int entero;
    char* string;
    char* tipo; //Cadena de caracteres
  }st;
}

/* Los no terminales hacen uso de la estructura */
%type <st> exp term factor

/* Declarar tokens recogidos de FLEX*/
%token MAS MENOS POR DIV PAR_OP PAR_CL

/*Los que son números hay que definir su tipo */
%token <intVal> ENT
%token <floatVal> REAL

//Definir la asociatividad. POR y DIV tienen mayor precedencia que MAS y MENOS
%left MAS MENOS
%left  POR DIV  

%start command
%%
command: exp {printf(" El resultado es %d\n", $1.entero); }
   ;

exp: exp MAS term {$$.entero = $1.entero + $3.entero; }
   | exp MENOS term {$$.entero = $1.entero - $3.entero; }
   | term {$$.entero = $1.entero; }
   ;

term: term POR factor {$$.entero = $1.entero * $3.entero; printf( "Multiplicacion con resultado = %ld\n", $$.entero);}
    | term DIV factor {$$.entero = $1.entero / $3.entero; printf( "Division con resultado = %ld\n", $$.entero);}
    | factor {$$.entero = $1.entero; }
    ;
    
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

    | PAR_OP exp PAR_CL {$$.entero = $2.entero;
                  printf( "PARENTESIS CON VALOR %ld\n", $$.entero);}
    ;
%%

main()
{ return yyparse();
}


yyerror()
{ 
} 
