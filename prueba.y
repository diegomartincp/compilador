%{
#include <ctype.h>
#include <stdio.h>
%}

%token NUMERO MAS MENOS POR DIV
%start command
%%
command: exp {printf(" El resultado es %d\n", $1); }
   ;

exp: exp MAS term {$$ = $1 + $3; }
   | exp MENOS term {$$ = $1 - $3; }
   | term {$$ = $1; }
   ;

term: term POR factor {$$ = $1 * $3; }
    | term DIV factor {$$ = $1 / $3; }
    | factor {$$ = $1; }
    ;
factor: NUMERO {$$ = $1; }
    | '(' exp ')' {$$ = $2; }
    ;
%%

main()
{ return yyparse();
}


yyerror()
{ 
} 
