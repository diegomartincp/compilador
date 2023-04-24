%option noyywrap

%{
#include "prueba_union.tab.h"
extern YYSTYPE yylval;
%}
%%
\n	return(0);
\+	return MAS;
\-	return MENOS;
\*	return POR;
\/	return DIV;
[0-9]+          {yylval.intVal = atoi(yytext); return ENT;}
%%
