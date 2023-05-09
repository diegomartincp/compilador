#include <math.h>
#include <stdbool.h> //Para usar booleanos

extern FILE *yyout;

//Array que almacena que registros $tn están disponibles. TRUE es disponible y FALSE es ocupado
//Hay 10 registros T, desde el 0 hasta el 9
bool array_registros_t[10] = {true, true, true, true, true, true, true, true, true, true};
//Hay 32 registros F, desde el 0 hasta el 9
bool array_registros_f[32] = {true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true};
//Usamos un array de 32 posiciones para almacenar las variables de .data
float array_variables[32];
int cima_array_variables=0; //Apunta a la siguiente posición libre de array_variables

// Definimos una estructura para nuestro nodo del AST
struct nodo{
  int nodetype;     //Puede ser L,+,-,*,/...
  char* tipo;       //El tipo de dato que almacena: real, entero o string
  double value; 
  char *string;
  struct nodo *l;    //Nodo izquierdo
  struct nodo *r;    //Nodo derecho
  int registro;      //Registro donde está el resultado
};

//Ver que registros T están libres
buscarRegistroLibreT(){
  bool encontrado=false;
  int i=0;
  while(encontrado==false){
    if(array_registros_t[i]==true){
      encontrado=true;
      array_registros_t[i]=false;  //Ocupamos el registro
      return i;  //Devuelve el registro que está libre
    } 
    i++;
  }
  return -1;
}

//Ver que registros F están libres
buscarRegistroLibreF(){
  bool encontrado=false;
  int i=0;
  while(encontrado==false){
    if(array_registros_f[i]==true){
      encontrado=true;
      array_registros_f[i]=false;  //Ocupamos el registro
      return i;  //Devuelve el registro que está libre
    } 
    i++;
  }
  return -1;
}
//Recibe un nodo y libera el registro que usa tanto si es real como float
liberarRegistro(struct nodo *a){
  array_registros_f[a->registro]=true;
}



//Nodo NO HOJA
struct nodo * new_node(int nodetype, char* tipo_, struct nodo *l, struct nodo *r) {
  struct nodo *a = malloc(sizeof(struct nodo));  //Crea un nuevo nodo
  if(!a) {
    exit(0); //Si el nuevo nodo es NULL significa que hay un error de memoria insuficiente
  }
  //Le asigna al nuevo nodo sus características
  a->nodetype = nodetype; 
  a->l = l;
  a->r = r;
  a->tipo = tipo_;

  //Asignar registro para float
  a->registro = buscarRegistroLibreF();
  printf("El nodo ha reservado el registro f%d \n",a->registro);
 
  return a;
}

//Nodo HOJA
struct nodo * new_leaf_num(double value, char* tipo_) {
  struct nodo *a = malloc(sizeof(struct nodo));    //Asigna la dirección de memoria para un nuevo nodo del tipo struct
    if(!a) {
    exit(0); //Si el nuevo nodo es NULL significa que hay un error de memoria insuficiente
  }
  a->nodetype = 'L';  //L de Leaf
  a->l = NULL;
  a->r = NULL;
  a->value = value;
  a->tipo = tipo_;

  //Asignar registro para float
  a->registro = buscarRegistroLibreF();
  printf("El nodo ha reservado el registro f%d \n",a->registro);

  //Registrar una nueva variable en .data con el valor
  //Guarda en la misma posición que registro utiliza: Para $f14 usa la posición 14
  array_variables[a->registro]=a->value;
  cima_array_variables++;

  return a;
}

//Nodo hoja con string
struct nodo * new_leaf_text(char * string, char* tipo_) {
  struct nodo *a = malloc(sizeof(struct nodo));    //Asigna la dirección de memoria para un nuevo nodo del tipo struct
    if(!a) {
    exit(0); //Si el nuevo nodo es NULL significa que hay un error de memoria insuficiente
  }
  a->nodetype = 'S';  //S de String
  a->l = NULL;
  a->r = NULL;
  a->tipo = tipo_;
  a->string = string;
  return a;
}


//Evaluar un nodo
double eval(struct nodo *a) {
  printf("EVALUA\n");
  double v;
  switch(a->nodetype) {

    //NODO HOJA
    case 'L':
      v = a->value;
      printf("Hoja con %f\n",v);
      //Cargar el valor en su registro asignado de tipo F
      fprintf(yyout,"  lwc1 $f%d, variable%d\n",a->registro,a->registro);
      
	  break;

    //OPERACION SUMA
    case '+':
      printf("-> suma\n");
      v = eval(a->l) + eval(a->r);

      //Ahora usamos solo registros tipo F para sumar el float
      fprintf(yyout,"  add.s $f%d, $f%d, $f%d\n",a->registro,a->l->registro,a->r->registro);   

      //liberar los registros de los nodos L y R
      liberarRegistro(a->l);
      liberarRegistro(a->r);
	  break;

    //OPERACIÓN RESTA
    case '-':
        printf("-> resta\n");
        v = eval(a->l) - eval(a->r); 
			  
        //Sentencia de la resta en ASM
        fprintf(yyout,"  sub.s $f%d, $f%d, $f%d\n",a->registro,a->l->registro,a->r->registro);   

        //liberar los registros de los nodos L y R
        liberarRegistro(a->l);
        liberarRegistro(a->r);
    break;
      case '*':
        printf("-> multiplicacion\n");
        v = eval(a->l) * eval(a->r); 

        //Sentencia de la multiplicación en ASM
        fprintf(yyout,"  mul.s $f%d, $f%d, $f%d\n",a->registro,a->l->registro,a->r->registro);   

        //liberar los registros de los nodos L y R
        liberarRegistro(a->l);
        liberarRegistro(a->r);
    break;
      case '/':
         printf("-> division\n");
        v = eval(a->l) / eval(a->r); 

        //Sentencia de la multiplicación en ASM
        fprintf(yyout,"  div.s $f%d, $f%d, $f%d\n",a->registro,a->l->registro,a->r->registro);   

        //liberar los registros de los nodos L y R
        liberarRegistro(a->l);
        liberarRegistro(a->r);
    break; 
    default: printf("Error: Nodo desconocido %c\n", a->nodetype); 
   }
  return v;
}

double iniciar_evaluacion(struct nodo *a){
  //Crea todas las variables necesarias en .data
  fprintf(yyout,".data #Variables\n");
  //Recorremos el array de las variables que hay que definir
  for (int i = 0; i < 32; i++){
    //Si el espacio del array tiene algo
    if(array_variables[i]!=0){
      printf("%d\n",array_variables[i]);
      //Define la variable
      fprintf(yyout,"  variable%d: .float %f\n",i,array_variables[i]);
      //La elimina pues ya se ha declarado
      //array_variables[i]=NULL;
    }
  }

  fprintf(yyout,"\n.text #Operaciones\n");

  return eval(a);  //Con las variables ya definidas, comienza a evaluar la operación
}
