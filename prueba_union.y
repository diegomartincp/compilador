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
    char* type;
  }st;
}

/* declare non-terminals */
%type <st> exp term factor

/* Declarar tokens recogidos de FLEX*/
%token MAS MENOS POR DIV
/*Los que son números hay que definir su tipo */
%token <intVal> ENT

/*Left*/
%left MAS MENOS POR DIV

%start command
%%
command: exp {printf(" El resultado es %d\n", $1.entero); }
   ;

exp: exp MAS term {$$.entero = $1.entero + $3.entero; }
   | exp MENOS term {$$.entero = $1.entero - $3.entero; }
   | term {$$.entero = $1.entero; }
   ;

term: term POR factor {$$.entero = $1.entero * $3.entero; }
    | term DIV factor {$$.entero = $1.entero / $3.entero; }
    | factor {$$.entero = $1.entero; }
    ;
factor: ENT {$$.entero = $1; }  //$1 no se indica su tipo pues ya se sabe que es entero
    | '(' exp ')' {$$.entero = $2.entero; }
    ;
%%

main()
{ return yyparse();
}


yyerror()
{ 
} 
