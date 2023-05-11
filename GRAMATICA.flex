%option noyywrap

%{
#include "GRAMATICA.tab.h"
extern YYSTYPE yylval;
%}
%%
\n	return(0);
\&\& return DOBLEAMPERSAN;
\|\| return DOBLEBARRA;
\! return EXCLAMACION;
\+	return MAS;
\-	return MENOS;
\*	return POR;
\/	return DIV;
\(	return LPAREN;
\)	return RPAREN;
\"	return COMILLA;
\=	return IGUAL;
\>	return MAYQUE;
\<	return MENQUE;
\;	return PUNTOCOMA;
\.\. return CONCAT;
\%  return MODULO;
\^  return EXPON;
"si" return SI;
"osi" return OSI;
"sino" return SINO;
"mientras"  return MIENTRAS;
"fin" return FIN;

[0-9]+          {yylval.intVal = atoi(yytext); return ENT;}
[0-9]+"."[0-9]+ {yylval.floatVal = atof(yytext); return REAL;}
[a-zA-Z]+		{yylval.stringVal=strdup(yytext); printf( yytext);return TEXT ;}
%%