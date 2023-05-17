%option noyywrap

%{
#include "gramatica.tab.h"
extern YYSTYPE yylval;

int linea = 1; // Variable para almacenar el número de línea
%}
%%

\/\/.* return COMENTARIO;;
\#.*$ return COMENTARIO;
\/\*([^\*\/]*)\*\/ return COMENTARIO;

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
\== return IGUALIGUAL;
\>= return MAYORIGUAL;
\<= return MENORIGUAL;
\;	return PUNTOCOMA;
\.\. return CONCAT;
\%  return MODULO;
\^  return EXPON;
"si" return SI;
"osi" return OSI;
"sino" return SINO;
"mientras"  return MIENTRAS;
"fin" return FIN;
escribir|imprimir|poner return IMPRIMIR;


[0-9]+          {yylval.intVal = atoi(yytext); return ENT;}
[0-9]+"."[0-9]+ {yylval.floatVal = atof(yytext); return REAL;}
\"([a-zA-Z0-9\s]*)\" 		{yylval.stringVal=strdup(yytext); printf( yytext);return TEXT ;}
[a-zA-Z0-9\s]*		{yylval.stringVal=strdup(yytext); printf( yytext);return ID ;}

\n		{linea++;}//
%%
