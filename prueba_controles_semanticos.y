//Pruebas de controles semánticos
%{
#include <ctype.h>
#include <stdio.h>
#include <string.h> //Esta librería de C nos permite comparar los tipos con la funcion strcmp()
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
command: exp {  if(strcmp($1.tipo, "entero")==0){printf(" El resultado entero es %d\n", $1.entero); }
                else{printf(" El resultado real es %f\n", $1.real); }
            }
   ;

exp: exp MAS term {
        if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "entero")==0) { //Si ambos son enteros
        $$.entero = $1.entero + $3.entero;
        $$.tipo="entero";
        printf( "entero+entero = %ld\n", $$.entero);
        }
        else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "real")==0){  //Si los dos son float
            $$.real = $1.real + $3.real;
            $$.tipo="real";
            printf( "real+real = %f\n", $$.real);
        }
        else if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "real")==0){  // Entero y real
            $$.real = $1.entero + $3.real;
            $$.tipo="real";
            printf( "entero+real = %f\n", $$.real);
        }
        else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "entero")==0){  // Real y entero
            $$.real = $1.real + $3.entero;
            $$.tipo="real";
            printf( "real+entero = %f\n", $$.real);
        }
        else{
             printf( "ERROR: No se puede operar");
        }
    }
   | exp MENOS term {
        if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "entero")==0) { //Si ambos son enteros
        $$.entero = $1.entero - $3.entero;
        $$.tipo="entero";
        printf( "entero-entero = %ld\n", $$.entero);
        }
        else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "real")==0){  //Si los dos son float
            $$.real = $1.real - $3.real;
            $$.tipo="real";
            printf( "real-real = %f\n", $$.real);
        }
        else if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "real")==0){  // Entero y real
            $$.real = $1.entero - $3.real;
            $$.tipo="real";
            printf( "entero-real = %f\n", $$.real);
        }
        else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "entero")==0){  // Real y entero
            $$.real = $1.real - $3.entero;
            $$.tipo="real";
            printf( "real-entero = %f\n", $$.real);
        }
        else{
             printf( "ERROR: No se puede operar");
        }
    }
   | term {$$ = $1; }   //Se hace una copia
   ;

term: term POR factor {
        if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "entero")==0) { //Si ambos son enteros
            $$.entero = $1.entero * $3.entero;
            $$.tipo="entero";
            printf( "entero*entero = %ld\n", $$.entero);
        }
        else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "real")==0){  //Si los dos son float
            $$.real = $1.real * $3.real;
            $$.tipo="real";
            printf( "real*real = %f\n", $$.real);
        }
        else if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "real")==0){  // Entero y real
            $$.real = $1.entero * $3.real;
            $$.tipo="real";
            printf( "entero*real = %f\n", $$.real);
        }
        else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "entero")==0){  // Real y entero
            $$.real = $1.real * $3.entero;
            $$.tipo="real";
            printf( "real*entero = %f\n", $$.real);
        }
        else{
             printf( "ERROR: No se puede operar");
        }
    }
    | term DIV factor {
        if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "entero")==0) { //Si ambos son enteros
            $$.entero = $1.entero / $3.entero;
            $$.tipo="entero";
            printf( "entero/entero = %ld\n", $$.entero);
        }
        else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "real")==0){  //Si los dos son float
            $$.real = $1.real / $3.real;
            $$.tipo="real";
            printf( "real/real = %f\n", $$.real);
        }
        else if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "real")==0){  // Entero y real
            $$.real = $1.entero / $3.real;
            $$.tipo="real";
            printf( "entero/real = %f\n", $$.real);
        }
        else if (strcmp($1.tipo, "real")==0 && strcmp($3.tipo, "entero")==0){  // Real y entero
            $$.real = $1.real / $3.entero;
            $$.tipo="real";
            printf( "real/entero = %f\n", $$.real);
        }
        else{
             printf( "ERROR: No se puede operar");
        }
    }
    | factor {$$ = $1;} //Se hace una copia
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
