%{
#include <stdio.h>

// Definimos una estructura para nuestro AST
struct ast {
  int nodetype;
  struct ast *l;
  struct ast *r;
};

// Definimos los tipos de nodos que tendrá nuestro AST
enum {
  ND_PLUS = 1,
  ND_MINUS,
  ND_TIMES,
  ND_DIV,
  ND_NUM,
};

// Función para crear un nuevo nodo del AST
struct ast *new_ast(int nodetype, struct ast *l, struct ast *r) {
  struct ast *node = malloc(sizeof(struct ast));
  node->nodetype = nodetype;
  node->l = l;
  node->r = r;
  return node;
}

// Función para crear un nodo de número del AST
struct ast *new_num(int value) {
  struct ast *node = malloc(sizeof(struct ast));
  node->nodetype = ND_NUM;
  node->l = NULL;
  node->r = NULL;
  node->value = value;
  return node;
}

// Indicamos a Bison que genere un analizador léxico y sintáctico para nuestro lenguaje
%}
%token <num> NUMBER
%left '+' '-'
%left '*' '/'

// Definimos la gramática de nuestro lenguaje
%%
expr: expr '+' expr   { $$ = new_ast(ND_PLUS, $1, $3); }
    | expr '-' expr   { $$ = new_ast(ND_MINUS, $1, $3); }
    | expr '*' expr   { $$ = new_ast(ND_TIMES, $1, $3); }
    | expr '/' expr   { $$ = new_ast(ND_DIV, $1, $3); }
    | '(' expr ')'    { $$ = $2; }
    | NUMBER          { $$ = new_num($1); }
    ;

// Función de error personalizada para Bison
void yyerror(char *s) {
  fprintf(stderr, "Error: %s\n", s);
}

// Función principal
int main() {
  yyparse();
  return 0;
}