%option noyywrap

%{
#include "prueba_variables.tab.h"
extern YYSTYPE yylval;
%}
letra [a-zA-Z]
digito [0-9]
%%
\n	return(0);
\(	return PAR_OP;
\)	return PAR_CL;
\; return PUNTOCOMA;
\= return IGUAL;
[0-9]+          {yylval.intVal = atoi(yytext); return ENT;}
[0-9]+"."[0-9]+ {yylval.floatVal = atof(yytext); return REAL;}
{letra}({letra}|{digito}|"_")*							{yylval.stringVal=strdup(yytext); return ID ;}

%%
