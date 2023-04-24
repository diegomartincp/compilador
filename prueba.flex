%option noyywrap

%{
#include "prueba.tab.h"
extern YYSTYPE yylval;
%}
%%
[0-9]+	yylval = atoi(yytext); return NUMERO;
\n	return(0);
\+	return MAS;
\-	return MENOS;
\*	return POR;
\/	return DIV;
%%
