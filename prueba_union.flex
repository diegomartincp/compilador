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
\(	return PAR_OP;
\)	return PAR_CL;
[0-9]+          {yylval.intVal = atoi(yytext); return ENT;}
[0-9]+"."[0-9]+ {yylval.floatVal = atof(yytext); return REAL;}
%%
