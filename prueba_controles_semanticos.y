//Pruebas de controles semánticos
%{
#include <ctype.h>
#include <stdio.h>
#include <string.h> //Esta librería de C nos permite comparar los tipos con la funcion strcmp()

//Variables
int error_compilacion=0;
int linea=1;

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
%type <st> exp term factor 

/* Declarar tokens recogidos de FLEX*/
%token MAS MENOS POR DIV PAR_OP PAR_CL CONCAT COMILLA

/*Los que son números hay que definir su tipo */
%token <intVal> ENT
%token <floatVal> REAL
%token <stringVal> TEXT
//Definir la asociatividad. POR y DIV tienen mayor precedencia que MAS y MENOS
%left MAS MENOS
%left POR DIV  
%left MODULO EXPON

%start command
%%
command: exp {  if(error_compilacion>=1){
                    printf("\nHa habido %d error(es) de compilacion",error_compilacion);
                }else{
                    printf("%d",error_compilacion);
                    if(strcmp($1.tipo, "entero")==0){printf(" El resultado entero es %d\n", $1.entero); }
                    else if (strcmp($1.tipo, "real")==0){printf(" El resultado real es %f\n", $1.real); }
                    else if (strcmp($1.tipo, "texto")==0){printf(" El resultado texto es %s\n", $1.texto); }     
                    else {printf(" ERROR: LA variable no tiene tipo");}  
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
            error_compilacion++;
            printf( "ERROR: No se puede operar en línea %d",linea);
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
             error_compilacion++;
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
             error_compilacion++;
             printf( "ERROR: No se puede operar");
        }
    }
    | term MODULO factor {
        if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "entero")==0) { //Si ambos son enteros
            $$.entero = $1.entero % $3.entero;
            $$.tipo="entero";
            printf( "entero %% entero = %ld\n", $$.entero);
        } else{
             error_compilacion++;
             printf( "ERROR: No se puede operar");
        }   
    }
    | term EXPON factor {
        if (strcmp($1.tipo, "entero")==0 && strcmp($3.tipo, "entero")==0) { //Si ambos son enteros
            $$.entero = pow($1.entero, $3.entero);
            $$.tipo="entero";
            printf( "entero^entero = %ld\n", $$.entero);
        } else{
             error_compilacion++;
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
