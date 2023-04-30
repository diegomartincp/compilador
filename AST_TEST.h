#include <math.h>

// Definimos una estructura para nuestro nodo del AST
struct nodo{
  int nodetype; 
  double value; 
  char *string;
  struct nodo *l;    //Nodo izquierdo
  struct nodo *r;    //Nodo derecho
};

//Nodo NO HOJA
struct nodo * new_node(int nodetype, struct nodo *l, struct nodo *r) {
  struct nodo *a = malloc(sizeof(struct nodo));  //Crea un nuevo nodo
  if(!a) {
    exit(0); //Si el nuevo nodo es NULL significa que hay un error de memoria insuficiente
  }
  //Le asigna al nuevo nodo sus características
  a->nodetype = nodetype; 
  a->l = l;
  a->r = r;

  return a;
}

//Nodo HOJA
struct nodo * new_leaf_num(double value) {
  struct nodo *a = malloc(sizeof(struct nodo));    //Asigna la dirección de memoria para un nuevo nodo del tipo struct
    if(!a) {
    exit(0); //Si el nuevo nodo es NULL significa que hay un error de memoria insuficiente
  }
  a->nodetype = 'L';  //L de Leaf
  a->l = NULL;
  a->r = NULL;
  a->value = value;
  return a;
}

//Nodo hoja con string
struct nodo * new_leaf_text(char * string) {
  struct nodo *a = malloc(sizeof(struct nodo));    //Asigna la dirección de memoria para un nuevo nodo del tipo struct
    if(!a) {
    exit(0); //Si el nuevo nodo es NULL significa que hay un error de memoria insuficiente
  }
  a->nodetype = 'S';  //S de String
  a->l = NULL;
  a->r = NULL;
  a->string = string;
  return a;
}

//Evaluar un nodo
double eval(struct nodo *a) {
  double v;
  switch(a->nodetype) {
    case 'L': v = a->value; printf("Hoja con %f\n",v);
	  break;
      case '+':
        printf("-> suma");
        v = eval(a->l) + eval(a->r);
			  printf("%lf + %lf = %lf\n", eval(a->l), eval(a->r), v);
	  break;
      case '-':
        printf("-> resta");
        v = eval(a->l) - eval(a->r); 
			  printf("%lf - %lf = %lf\n", eval(a->l), eval(a->r), v);
    break;
      case '*':
        printf("-> multiplicacion");
        v = eval(a->l) * eval(a->r); 
    break;
      case '/':
         printf("-> division");
        v = eval(a->l) / eval(a->r); 
    break; 
    default: printf("Error: Nodo desconocido %c\n", a->nodetype); 
   }
  return v;
}
