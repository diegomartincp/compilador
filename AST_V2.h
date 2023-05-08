#include <math.h>
#include <stdbool.h> //Para usar booleanos

extern FILE *yyout;

//Array que almacena que registros $tn están disponibles. TRUE es disponible y FALSE es ocupado
//Hay 10 registros T, desde el 0 hasta el 9
bool array_registros_t[10] = {true, true, true, true, true, true, true, true, true, true};
//Hay 32 registros F, desde el 0 hasta el 9
bool array_registros_f[32] = {true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true};

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
    if(strcmp(a->tipo, "entero")==0){
        array_registros_t[a->registro]=true;
    }else{
        array_registros_f[a->registro]=true;
    }
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

  if(strcmp(a->tipo, "entero")==0){
    //Asignar registro para float
    a->registro = buscarRegistroLibreT(); //Buscamos un registro no ocupado y se almacena en él
    printf("El nodo ha reservado el registro t%d \n",a->registro);
  }else{
    //Asignar registro para float
    a->registro = buscarRegistroLibreF();
    printf("El nodo ha reservado el registro f%d \n",a->registro);
  }
  
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

  if(strcmp(a->tipo, "entero")==0){
    //Asignar registro para float
    a->registro = buscarRegistroLibreT(); //Buscamos un registro no ocupado y se almacena en él
    printf("El nodo con un %f ha reservado el registro t%d \n",a->value,a->registro);
  }else{
    //Asignar registro para float
    a->registro = buscarRegistroLibreF();
    printf("El nodo con un %f ha reservado el registro f%d \n",a->value,a->registro);
  }
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
    case 'L':
      v = a->value;
      printf("Hoja con %f\n",v);
      //Cargar el valor en su registro asignado
       if(strcmp(a->tipo, "entero")==0){
        //Cargar un real
        fprintf(yyout,"addi $t%d, $zero, %d\n",a->registro, (int)a->value);
       }
       else{
        //Cargar un float
        fprintf(yyout,"l.s $f%d, %f\n",a->registro,a->value);
       }
      
	  break;

      //OPERACION SUMA
      case '+':
        printf("-> suma\n");
        v = eval(a->l) + eval(a->r);

        if(strcmp(a->tipo, "entero")==0){
            //Si el resultado es entero, los tres registros son T
            fprintf(yyout,"add $t%d, $t%d, $t%d\n",a->registro,a->l->registro,a->r->registro);
        }else{
            //Si el registro de R o L es de tipo T, primero hay que copiar su contenido a un
            //registro de tipo F y liberar el registro antiguo
            if(strcmp(a->l->tipo, "entero")==0){
                int registro_antiguo=a->l->registro;
                liberarRegistro(a->l);   //Liberar el antiguo
                a->l->registro = buscarRegistroLibreF();    //Usar el nuevo
                //Copiamos del registro antiguo al nuevo
                fprintf(yyout,"mtcl $t%d, $f%d\n",registro_antiguo,a->l->registro);
                //Convertir a float el registro nuevo
                fprintf(yyout,"cvt.s.w $f%d, $f%d\n",a->l->registro ,a->l->registro);

            }
            if(strcmp(a->r->tipo, "entero")==0){
                int registro_antiguo=a->r->registro;
                liberarRegistro(a->r);   //Liberar el antiguo
                a->r->registro = buscarRegistroLibreF();    //Usar el nuevo
                //Copiamos del registro antiguo al nuevo
                fprintf(yyout,"mtc1 $t%d, $f%d\n",registro_antiguo,a->r->registro);
                //Convertir a float el registro nuevo
                fprintf(yyout,"cvt.s.w $f%d, $f%d\n",a->l->registro ,a->r->registro);
            }
            //Ahora usamos solo registros tipo F para sumar el float
            fprintf(yyout,"add.s $f%d, $f%d, $f%d\n",a->registro,a->l->registro,a->r->registro);
        }     

        //liberar los registros de los nodos L y R
        liberarRegistro(a->l);
        liberarRegistro(a->r);
	  break;
      case '-':
        printf("-> resta\n");
        v = eval(a->l) - eval(a->r); 
			  //printf("%lf - %lf = %lf\n", eval(a->l), eval(a->r), v);
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
