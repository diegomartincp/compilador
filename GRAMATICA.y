%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
%}

/* declare type possibilities of symbols */
%union {
  int intVal;
  float floatVal;
  char* stringVal;
  struct atributos{
    struct nodo *a;  //El sctruct del AST para poder almacenar los nodos
    float real;
    int entero;
    char* texto;
    char* tipo; //Cadena de caracteres que almacena textualmente el tipo del elemento para poder ofrecer controles semánticos sobre el mismo
  }st;
}


/* Declarar tokens recogidos de FLEX*/
%token MAS MENOS POR DIV LPAREN RPAREN CONCAT COMILLA IGUAL SI OSI MIENTRAS FIN DOBLEAMPERSAN DOBLEBARRA EXCLAMACION MAYQUE MENQUE
%token PUNTOCOMA
%token ENT REAL TEXT

%left MAS MENOS
%left  POR DIV  

%%

program:
    statement_list  {printf("-> SENTENCIA RECONOCIDA")}
    ;

//Varias cosas encadenadas
statement_list:
    statement
    | statement_list statement
    ;

//Una signación, IF o WHILE
statement:
    asignacion_statement
    | si_statement
    | mientras_statement
    ;

asignacion_statement:
    TEXT IGUAL exp
    ;

//Si
si_statement: SI LPAREN condicion_list RPAREN statement_list osi_list FIN  {printf("SI con cadena de OSI\n")}
    | SI LPAREN condicion_list RPAREN statement_list FIN {printf("SI\n")}
    ;
//Varios osi encadenados
osi_list:
    osi    {printf("UN OSI\n")}
    | osi_list osi  {printf("VARIOS OSI\n")}
    ;
//un osi
osi: OSI LPAREN condicion_list RPAREN statement_list {printf("OSI\n")}
    ;

//mientras
mientras_statement:
    MIENTRAS LPAREN condicion_list RPAREN statement_list FIN {printf("MIENTRAS\n")}
    ;

//Lista de condiciones
condicion_list: condicion_list DOBLEAMPERSAN  condicion {printf("Condicion && condicion\n")}
    | condicion_list DOBLEBARRA condicion {printf("Condicion || condicion\n")}
    | EXCLAMACION condicion {printf("!condicion\n")}
    | condicion {printf("condicion\n")}

//Condiciones
condicion: exp MAYQUE exp {printf("Condicion mayor que\n")}
    | exp MENQUE exp   {printf("Condicion menor que\n")}
    | exp MAYQUE IGUAL exp   {printf("Condicion mayor o igual que\n")}
    | exp MENQUE IGUAL exp  {printf("Condicion menor o igual que\n")}
    | exp IGUAL IGUAL exp {printf("Condicion igual igual que\n")}

exp: exp MAS term {printf("SUMA\n")}
   | exp MENOS term {printf("RESTA\n")}
   | exp CONCAT term {printf("CONCATENAR\n")}//Concatenar strings
   | term
   ;

term: term POR factor {printf("MULTIPLICAR\n")}
    | term DIV factor {printf("DIVIDIR\n")}
    | factor
    ;
factor: ENT  {printf("ENTERO\n")} //Imprimir por pantalla lo que se acaba de hacer
    | MENOS ENT {printf("MENOS ENTERO\n")}

//Reales
    | REAL {printf("REAL\n")}
    | MENOS REAL {printf("MENOS REAL\n")}
    | LPAREN exp RPAREN {printf("PARENTESIS\n")}
//Texto
    | COMILLA TEXT COMILLA {printf("TEXTO\n")}
    ;

%%

int main() {
    yyparse();
    return 0;
}

void yyerror(const char* s) {
    fprintf(stderr, "%s\n", s);
}

int yywrap() {
    return 1;
}