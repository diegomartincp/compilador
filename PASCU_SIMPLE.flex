%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "calculadora_simple.tab.h"
extern int linea;

%}

%option noyywrap
%option yylineno

letra [a-zA-Z]
digito [0-9]
int (Integer|integer)
float (Float|float)
string (String|string)
comentario (--.*$)

%%

{int} {return INTEGER;}
{float} {return FLOAT;}
{string} {return STRING;}
{comentario} {return COMMENT;}

"+"             {return PLUS;}
"-"             {return MINUS;}
"/"             {return DIVIDE;}
"*"             {return MULTIPLY;}
"("             {return LEFT;}
")"             {return RIGHT;}

"<="			{return LESSEROREQUALSTHAN;}
">="			{return GREATEROREQUALSTHAN;}
"/="			{return DIFFERENTTHAN;}
"<"				{return LESSERTHAN;}
">"				{return GREATERTHAN;}
"="				{return EQUALS;}
";"				{return SEMI;}
":"				{return POINTS;}
":="			{return ASSIGN ;}

"true"			{return TRUE;}
"false"			{return FALSE;}

"if"            {return IF;}
"is"            {return IS;}
"procedure"     {return PROCEDURE;}
"begin"         {return BEEGIN;}
"end"			{return END ;}

[0-9]+          {yylval.intVal = atoi(yytext); return ENT;}
[0-9]+"."[0-9]+ {yylval.floatVal = atof(yytext); return REAL;}
\"([^\\\"]|\\.)*\"            {yylval.stringVal = strdup(yytext);return STR;}
{letra}({letra}|{digito}|"_")*							{yylval.stringVal=strdup(yytext); return ID ;}

"\n"            {linea=yylineno; return DONE;}
" "             {;}
.               {printf("Error: invlaid lexeme '%s'.\n", yytext); return 0;}

%%