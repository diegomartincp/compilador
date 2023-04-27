%option noyywrap

%{
#include "controles_variables.tab.h"
extern YYSTYPE yylval;
%}
%%
\n	return(0);
\+	return MAS;
\-	return MENOS;
\*	return POR;
\/	return DIV;
\%  return MODULO;
\^  return EXPON; 
\(	return PAR_OP;
\)	return PAR_CL;
\"	return COMILLA;
\=	return IGUAL;
\;	return PUNTOCOMA;
\.\.	return CONCAT;
[0-9]+          {yylval.intVal = atoi(yytext); return ENT;}
[0-9]+"."[0-9]+ {yylval.floatVal = atof(yytext); return REAL;}
[a-zA-Z]+		{yylval.stringVal=strdup(yytext); printf( yytext);return TEXT ;}
%%
