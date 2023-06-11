#include <math.h>
#include <stdbool.h> //Para usar booleanos

extern FILE *yyout;

extern int table_size;
extern symbol table[100];

// Etiqueta para los if o while
int numEtiqueta = 0;

// Array que almacena que registros $tn están disponibles. TRUE es disponible y FALSE es ocupado
// Hay 10 registros T, desde el 0 hasta el 9
bool array_registros_t[10] = {true, true, true, true, true, true, true, true, true, true};

// Hay 32 registros F, desde el 0 hasta el 31
// El registro 32 está reservado por defecto para imprimir por pantalla
bool array_registros_f[31] = {true, true, true, true, true, true, true, true, true, true, true, true, false, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true};
// bool array_registros_f[31] = {true, true, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false};

// Usamos un array de 32 posiciones para almacenar las variables de .data
float array_variables[32][3];        // En 0 el dato y en 1 el nombre de la variable y en el 2 si esta ocupado
int siguienteVariableDisponible = 0; // Apunta al siguiente número disponible para declarar una variable en .data

// Definimos una estructura para nuestro nodo del AST
struct nodo
{
  int nodetype; // Puede ser L,+,-,*,/...
  char *tipo;   // El tipo de dato que almacena: real, entero o string
  double value;
  char *string;
  struct nodo *l;  // Nodo izquierdo
  struct nodo *r;  // Nodo derecho
  struct nodo *x;  // Nodo EXTRA para si nodo específico del SI SINO
  int registro;    // Registro donde está el resultado
  int registroIni; //inicio del for
  int registroFin; //fin del for
  int variableNum; // Indica el nombre de la variable "variableN" que se usa para declarar
  char *id;        // Identificador del para
  int inicio;      // Valor inicial del para
  int fin;         // Valor final del para
  int incremento;  // Valor para incrementar el for
  int registroInc; // Valor para comparaciones del for
};

// Ver que registros T están libres
buscarRegistroLibreT()
{
  int i = 0;
  for (size_t i = 0; i <= 9; i++) // Vamos de 0 a 30, pues el 31 está reservado para imprimir
  {
    if (array_registros_t[i] == true)
    {
      array_registros_t[i] = false; // Ocupamos el registro
      return i;                     // Devuelve el registro que está libre
    }
  }
  // Si sale del búcle for, significa que no hay ningún registro libre
  return -1;
}

// Ver que registros F están libres
buscarRegistroLibreF()
{
  int i = 0;
  for (size_t i = 0; i <= 30; i++) // Vamos de 0 a 30, pues el 31 está reservado para imprimir
  {
    if (array_registros_f[i] == true)
    {
      array_registros_f[i] = false; // Ocupamos el registro
      return i;                     // Devuelve el registro que está libre
    }
  }
  // Si sale del búcle for, significa que no hay ningún registro libre
  return -1;
}
// Recibe un nodo y libera el registro que usa tanto si es real como float
liberarRegistro(struct nodo *a)
{
  array_registros_f[a->registro] = true;
}

// Nodo NO HOJA
struct nodo *new_node(int nodetype, struct nodo *l, struct nodo *r)
{                                               //, char* tipo_
  struct nodo *a = malloc(sizeof(struct nodo)); // Crea un nuevo nodo
  if (!a)
  {
    exit(0); // Si el nuevo nodo es NULL significa que hay un error de memoria insuficiente
  }
  // Le asigna al nuevo nodo sus características
  a->nodetype = nodetype;
  a->l = l;
  a->r = r;
  // a->tipo = tipo_;

  // Asignar registro para float
  a->registro = buscarRegistroLibreF();
  printf("Se ha reservado el registro $f%d para almancear el resultado de una operacion\n\n", a->registro);

  return a;
}

// Nodo HOJA
struct nodo *new_leaf_num(double value)
{                                               //, char* tipo_
  struct nodo *a = malloc(sizeof(struct nodo)); // Asigna la dirección de memoria para un nuevo nodo del tipo struct
  if (!a)
  {
    exit(0); // Si el nuevo nodo es NULL significa que hay un error de memoria insuficiente
  }
  a->nodetype = 'L'; // L de Leaf
  a->l = NULL;
  a->r = NULL;
  a->value = value;
  // a->tipo = tipo_;

  // Asignar registro para float
  a->registro = buscarRegistroLibreF();

  // Guardar como se llama la variable de .data
  a->variableNum = siguienteVariableDisponible;
  siguienteVariableDisponible++; // Se incrementa

  printf("La variable%d almacena el valor %f en el registro $f%d \n", a->variableNum, a->value, a->registro);

  // Registrar una nueva variable en .data con el valor
  // Guarda en la misma posición que registro utiliza: Para $f14 usa la posición 14
  array_variables[a->registro][0] = a->value;
  array_variables[a->registro][1] = a->variableNum;
  array_variables[a->registro][2] = 1; // ocupado

  return a;
}

// Nodo HOJA que es una variable definida anteriormente que ya cuenta con un registro asignado
struct nodo *new_var_leaf_num(double value, int registro_)
{                                               //, char* tipo_
  struct nodo *a = malloc(sizeof(struct nodo)); // Asigna la dirección de memoria para un nuevo nodo del tipo struct
  if (!a)
  {
    exit(0); // Si el nuevo nodo es NULL significa que hay un error de memoria insuficiente
  }
  a->nodetype = 'V'; // V de Variable
  a->l = NULL;
  a->r = NULL;
  a->value = value;
  // a->tipo = tipo_;

  // Asignar registro para float
  a->registro = registro_;
  printf("El identificador estaba almacenado en el registro f%d \n", a->registro);

  /**
    //Guardar como se llama la variable de .data
    a->variableNum=siguienteVariableDisponible;
    printf("%f se almacena en la 'variable%d'\n",a->value,a->variableNum);
    siguienteVariableDisponible++; //Se incrementa
    */
  return a;
}

// Nodo HOJA que es un comentario
struct nodo *new_leaf_comment()
{                                               //, char* tipo_
  struct nodo *a = malloc(sizeof(struct nodo)); // Asigna la dirección de memoria para un nuevo nodo del tipo struct
  if (!a)
  {
    exit(0); // Si el nuevo nodo es NULL significa que hay un error de memoria insuficiente
  }
  a->nodetype = 'CM';
  a->l = NULL;
  a->r = NULL;
  a->value = 1;
  return a;
}
// Nuevo nodo para un SI con un SINO
struct nodo *new_node_sino(struct nodo *l, struct nodo *r, struct nodo *x)
{                                               //, char* tipo_
  struct nodo *a = malloc(sizeof(struct nodo)); // Crea un nuevo nodo
  if (!a)
  {
    exit(0); // Si el nuevo nodo es NULL significa que hay un error de memoria insuficiente
  }
  // Le asigna al nuevo nodo sus características
  a->nodetype = 'SN';
  a->l = l;
  a->r = r;
  a->x = x;

  // Asignar registro para float
  a->registro = buscarRegistroLibreF();
  printf("Se ha reservado el registro $f%d para almancear el SI con un SINO\n\n", a->registro);

  return a;
}

struct nodo *new_node_para(char *id, int inicio, int fin, struct nodo *r)
{
  struct nodo *a = malloc(sizeof(struct nodo));
  if (!a)
  {
    exit(0); // Si el nuevo nodo es NULL significa que hay un error de memoria insuficiente
  }
  // Le asigna al nuevo nodo sus características
  a->nodetype = 'PARA';
  a->id = id;
  a->inicio = inicio;
  a->fin = fin;
  a->r = r;
  a->registroIni = buscarRegistroLibreT();
  a->registroFin = buscarRegistroLibreT();

  return a;
}

struct nodo *new_node_para2(char *id, int fin, struct nodo *r)
{
  struct nodo *a = malloc(sizeof(struct nodo));
  if (!a)
  {
    exit(0); // Si el nuevo nodo es NULL significa que hay un error de memoria insuficiente
  }
  // Le asigna al nuevo nodo sus características
  a->nodetype = 'PARA2';
  a->id = id;
  a->fin = fin;
  a->r = r;
  a->registroIni = buscarRegistroLibreT();
  a->registroFin = buscarRegistroLibreT();

  return a;
}

struct nodo *new_node_para3(char *id, int inicio, int fin, int incremento, struct nodo *r)
{
  struct nodo *a = malloc(sizeof(struct nodo));
  if (!a)
  {
    exit(0); // Si el nuevo nodo es NULL significa que hay un error de memoria insuficiente
  }
  // Le asigna al nuevo nodo sus características
  a->nodetype = 'PARA3';
  a->id = id;
  a->inicio = inicio;
  a->fin = fin;
  a->incremento = incremento;
  a->r = r;
  a->registroIni = buscarRegistroLibreT();
  a->registroFin = buscarRegistroLibreT();
  a->registroInc = buscarRegistroLibreT();

  return a;
}

// Nodo hoja con string
struct nodo *new_leaf_text(char *string, char *tipo_)
{
  struct nodo *a = malloc(sizeof(struct nodo)); // Asigna la dirección de memoria para un nuevo nodo del tipo struct
  if (!a)
  {
    exit(0); // Si el nuevo nodo es NULL significa que hay un error de memoria insuficiente
  }
  a->nodetype = 'S'; // S de String
  a->l = NULL;
  a->r = NULL;
  // a->tipo = tipo_;
  a->string = string;
  return a;
}

// Devuelve un nodo vacío
struct nodo *nodo_vacio()
{
  struct nodo *a = malloc(sizeof(struct nodo)); // Asigna la dirección de memoria para un nuevo nodo del tipo struct
  if (!a)
  {
    exit(0); // Si el nuevo nodo es NULL significa que hay un error de memoria insuficiente
  }
  a->nodetype = NULL; // S de String
  a->l = NULL;
  a->r = NULL;
  return a;
}

// Devuelve un nodo vacío pero permite usar los campos nodetype y string para almacenar info para la asignación
struct nodo *nodo_con_info_para_asignacion(int registro)
{
  struct nodo *a = malloc(sizeof(struct nodo)); // Asigna la dirección de memoria para un nuevo nodo del tipo struct
  if (!a)
  {
    exit(0); // Si el nuevo nodo es NULL significa que hay un error de memoria insuficiente
  }
  a->registro = registro;
  a->l = NULL;
  a->r = NULL;
  return a;
}

// Evaluar un nodo
double eval(struct nodo *a)
{
  double v;
  int etiquetaTemporal;

  switch (a->nodetype)
  {

  // NODO HOJA
  case 'L':
    v = a->value;
    printf("-> HOJA donde se asigna %f (variable%d) al registro $f%d\n", v, a->variableNum, a->registro);
    // Cargar el valor en su registro asignado de tipo F
    fprintf(yyout, "  lwc1 $f%d, variable%d\n", a->registro, a->variableNum);

    break;

  // NODO HOJA que es una variable
  case 'V':
    v = a->value;
    // No volvemos hay que hacer nada xq ya está en un registro
    // printf("Esta variable esta en el registro $f%d\n", a->registro);
    break;

  // ASIGNACIÓN
  case 'A':
    // Asigna el resultado de la operación que se encuentra en el nodo a->l al registro que tenia la variable originalmente
    v = eval(a->l);

    printf("-> ASIGNACION y resolucion de una variable con un  $f%d\n", v);
    break;

  // ASIGNACIÓN y REEMPLAZAR
  case 'R':
    // Asigna el resultado de la operación que se encuentra en el nodo a->l al registro que tenia la variable originalmente
    v = eval(a->l);
    // Con la operación evaluada, se que en a->registro esta el registro con el resultado
    fprintf(yyout, "  mov.s $f%d, $f%d\n", a->r->registro, a->l->registro);

    printf("-> SOBREESCRIBIR VARIABLE tras una operacion, moviendo el registro $f%d, a la posicion original: $f%d \n", a->l->registro, a->r->registro);
    break;

  // OPERACION SUMA
  case '+':
    // printf("-> suma\n");
    v = eval(a->l) + eval(a->r);
    printf("-> SUMA (%f + %f) almacenada en $f%d y con resultado %f\n", a->l->value, a->r->value, a->registro, v);
    // Ahora usamos solo registros tipo F para sumar el float
    fprintf(yyout, "  add.s $f%d, $f%d, $f%d\n", a->registro, a->l->registro, a->r->registro);

    // liberar los registros de los nodos L y R
    liberarRegistro(a->l);
    liberarRegistro(a->r);
    break;

  // OPERACIÓN RESTA
  case '-':
    // printf("-> resta\n");
    v = eval(a->l) - eval(a->r);
    printf("-> RESTA (%f - %f) almacenada en $f%d y con resultado %f\n", a->l->value, a->r->value, a->registro, v);
    // Sentencia de la resta en ASM
    fprintf(yyout, "  sub.s $f%d, $f%d, $f%d\n", a->registro, a->l->registro, a->r->registro);

    // liberar los registros de los nodos L y R
    liberarRegistro(a->l);
    liberarRegistro(a->r);
    break;
  case '*':
    // printf("-> multiplicacion\n");
    v = eval(a->l) * eval(a->r);
    printf("-> MULTIPLICACION (%f * %f) almacenada en $f%d y con resultado %f\n", a->l->value, a->r->value, a->registro, v);
    // Sentencia de la multiplicación en ASM
    fprintf(yyout, "  mul.s $f%d, $f%d, $f%d\n", a->registro, a->l->registro, a->r->registro);

    // liberar los registros de los nodos L y R
    liberarRegistro(a->l);
    liberarRegistro(a->r);
    break;
  case '/':
    // printf("-> division\n");
    v = eval(a->l) / eval(a->r); // base l expon r devuelve l^r
    printf("-> DIVISION (%f / %f) almacenada en $f%d y con resultado %f\n", a->l->value, a->r->value, a->registro, v);
    // Sentencia de la division en ASM
    fprintf(yyout, "  div.s $f%d, $f%d, $f%d\n", a->registro, a->l->registro, a->r->registro);

    // liberar los registros de los nodos L y R
    liberarRegistro(a->l);
    liberarRegistro(a->r);
    break;
  case '%': // Statement List
    // printf("-> modulo\n");
    v = fmod(eval(a->l), eval(a->r));
    printf("-> MODULO (%f mod %f) almacenada en $f%d y con resultado %f\n", a->l->value, a->r->value, a->registro, v);
    // Sentencia de la operación de módulo en ASM
    fprintf(yyout, "  cvt.w.s $f%d, $f%d\n", a->registro, a->l->registro); // convertir valores
    fprintf(yyout, "  cvt.w.s $f%d, $f%d\n", a->registro + 1, a->r->registro);
    fprintf(yyout, "  mfc1 $t%d, $f%d\n", a->registro, a->registro); // mover a registros t, con los f no se pueden hacer modulos
    fprintf(yyout, "  mfc1 $t%d, $f%d\n", a->registro + 1, a->registro + 1);
    fprintf(yyout, "  div $t%d, $t%d\n", a->registro, a->registro + 1);
    fprintf(yyout, "  mfhi $t%d\n", a->registro); // obtenemos el residuo/modulo
    // el cociente se almacena en el registro especial LO Lower y el residuo se almacena en el registro especial HI Higher
    fprintf(yyout, "  mtc1 $t%d, $f%d\n", a->registro, a->registro);    // reconvertimos
    fprintf(yyout, "  cvt.s.w $f%d, $f%d\n", a->registro, a->registro); // reconvertimos

    // liberar los registros de los nodos L y R
    liberarRegistro(a->l);
    liberarRegistro(a->r);
    break;
  case '^':
    // printf("-> exponente\n");
    v = fmod(eval(a->l), eval(a->r));
    printf("-> EXPONENTE almacenada en $f%d y con resultado %f\n", a->registro, v);
    // Sentencia de la operación de exponente en ASM

    // liberar los registros de los nodos L y R
    liberarRegistro(a->l);
    liberarRegistro(a->r);
    break;
  case '>':
    v = eval(a->l) > eval(a->r);
    printf("-> MAYOR QUE (%f > %f) almacenada en $f%d y con resultado %f\n", a->l->value, a->r->value, a->registro, v);

    // Comparación de punto flotante de $f1 > $f2
    fprintf(yyout, "  c.lt.s $f%d, $f%d\n", a->r->registro, a->l->registro);

    // Liberar los registros de los nodos L y R
    liberarRegistro(a->l);
    liberarRegistro(a->r);
    break;
  case '<':
    v = eval(a->l) < eval(a->r);
    printf("-> MENOR QUE (%f < %f) almacenada en $f%d y con resultado %f\n", a->l->value, a->r->value, a->registro, v);

    // Comparación de punto flotante de $f1 > $f2
    fprintf(yyout, "  c.lt.s $f%d, $f%d\n", a->l->registro, a->r->registro); // MISMA OPERACIÓN QUE ARRIBA PERO INTERCAMBIADA PARA > --> <

    // Liberar los registros de los nodos L y R
    liberarRegistro(a->l);
    liberarRegistro(a->r);
    break;
  case '>=':
    v = eval(a->l) >= eval(a->r);
    printf("-> MAYOR IGUAL QUE (%f >= %f) almacenada en $f%d y con resultado %f\n", a->l->value, a->r->value, a->registro, v);

    // Comparación de punto flotante de $f1 > $f2
    fprintf(yyout, "  c.le.s $f%d, $f%d\n", a->r->registro, a->l->registro);

    // Liberar los registros de los nodos L y R
    liberarRegistro(a->l);
    liberarRegistro(a->r);
    break;
  case '<=':
    v = eval(a->l) <= eval(a->r);
    printf("-> MENOR IGUAL QUE (%f <= %f) almacenada en $f%d y con resultado %f\n", a->l->value, a->r->value, a->registro, v);

    // Comparación de punto flotante de $f1 < $f2
    fprintf(yyout, "  c.le.s $f%d, $f%d\n", a->l->registro, a->r->registro);

    // Liberar los registros de los nodos L y R
    liberarRegistro(a->l);
    liberarRegistro(a->r);
    break;
  case '==':
    v = eval(a->l) == eval(a->r);
    printf("-> IGUAL QUE (%f == %f) almacenada en $f%d y con resultado %f\n", a->l->value, a->r->value, a->registro, v);

    // Comparación de punto flotante de $f1 == $f2
    fprintf(yyout, "  c.eq.s $f%d, $f%d\n", a->l->registro, a->r->registro);
    fprintf(yyout, "  mov.s $f%d, $f%d\n", a->registro, a->l->registro);

    // Liberar los registros de los nodos L y R
    liberarRegistro(a->l);
    liberarRegistro(a->r);
    break;
  case 'C': // condicion
    printf("-> CONDICION\n");
    v = eval(a->l);
    break;
  case 'S': // SI statement
    etiquetaTemporal = numEtiqueta;
    numEtiqueta++;

    v = eval(a->l); // condicion en a->l
    printf("-> SI donde su condicion es %f\n", v);
    si_statement(a->l, etiquetaTemporal);

    // Código del IF
    eval(a->r); // el resto del codigo a->r

    // Etiqueta que se usa para saltar al resto si condicion=FALSE
    fprintf(yyout, "etiq%d:\n", etiquetaTemporal);

    break;

  case 'SN': // SI SINO statement
    etiquetaTemporal = numEtiqueta;
    numEtiqueta += 2; // Reservamos dos etiquetas
                      // etiquetaTemporal es la etiqueta del SINO
                      // etiquetaTemporal+1 es la etiqueta para ir fuera del SI y SINO

    v = eval(a->l); // condicion en a->l
    printf("-> SI con un SINO donde su condicion es %f\n", v);
    si_sino_statement(a->l, etiquetaTemporal); // Le pasamos la etiqueta del sino, es decir, "si no se cumple la condicion vamos a.." (SINO)

    // Generar el código del SI
    eval(a->r); // el resto del codigo a->r

    // Si hemos recorrido el SI, saltar al final
    fprintf(yyout, "  j etiq%d\n", etiquetaTemporal + 1);
    // Etiqueta que se usa para saltar al  SINO
    fprintf(yyout, "etiq%d:\n", etiquetaTemporal);

    // Generar el código del ELSE
    eval(a->x); // el resto del codigo a->x

    // Etiqueta que se usa para saltar al final del SI y SINO
    fprintf(yyout, "etiq%d:\n", etiquetaTemporal + 1);

    break;

  case 'M': // Mientras statement

    etiquetaTemporal = numEtiqueta;
    numEtiqueta += 2;

    // Saltar a la etiqueta del comienzo del WHILE
    fprintf(yyout, "  etiq%d:\n", etiquetaTemporal);
    v = eval(a->l); // condicion en a->l
    printf("-> MIENTRAS donde su condicion es %f\n", v);
    mientras_statement(a->l, etiquetaTemporal + 1);

    // Código del IF
    eval(a->r); // el resto del codigo a->r

    // Saltar a la etiqueta del comienzo del WHILE
    fprintf(yyout, "  j etiq%d\n", etiquetaTemporal);
    // Etiqueta que se usa para salir del WHILE
    fprintf(yyout, "etiq%d:\n", etiquetaTemporal + 1);
    // Incrementar el número de etiqueta para usar una distinta más tarde

    break;

  case 'PARA':
    printf("-> PARA AST checkeo\n");

    etiquetaTemporal = numEtiqueta;     //primera etiqueta
    numEtiqueta += 2;                   //para la segunda etiqueta

    //declarar variables de inicio y fin
    fprintf(yyout, "  li  $t%d, %d\n", a->registroIni, a->inicio);
    fprintf(yyout, "  li  $t%d, %d\n", a->registroFin, a->fin);
    
    //Iniciar el bucle
    fprintf(yyout, "  etiq%d:\n", etiquetaTemporal);
   
    //cuerpo del bucle
    eval(a->r);

    //Incrementar el contador
    fprintf(yyout, "  addi $t%d, $t%d, 1\n", a->registroIni, a->registroIni);
    //Comparacion para finalizar el bucle
    fprintf(yyout, "  bne $t%d, $t%d, etiq%d\n", a->registroIni, a->registroFin, etiquetaTemporal);
    
    fprintf(yyout, "  etiq%d:\n", etiquetaTemporal+1);

    break;

  case 'PARA2':
    printf("-> PARA2 AST checkeo\n");

    etiquetaTemporal = numEtiqueta;     //primera etiqueta
    numEtiqueta += 2;                   //para la segunda etiqueta

    //declarar variables de inicio y fin
    fprintf(yyout, "  li  $t%d, 0\n", a->registroIni);
    fprintf(yyout, "  li  $t%d, %d\n", a->registroFin, a->fin);

    //inicio bucle
    fprintf(yyout, "  etiq%d:\n", etiquetaTemporal);
   
    //cuerpo del bucle
    eval(a->r);

    //Incrementar el contador
    fprintf(yyout, "  addi $t%d, $t%d, 1\n", a->registroIni, a->registroIni);
    //Comparacion para finalizar el bucle
    fprintf(yyout, "  bne $t%d, $t%d, etiq%d\n", a->registroIni, a->registroFin, etiquetaTemporal);

    fprintf(yyout, "  etiq%d:\n", etiquetaTemporal+1);

    break;

  case 'PARA3':
    printf("-> PARA3 AST checkeo\n");

    etiquetaTemporal = numEtiqueta;     //primera etiqueta
    numEtiqueta += 2;                   //para la segunda etiqueta

    //declarar variables de inicio y fin
    fprintf(yyout, "  li  $t%d, %d\n", a->registroIni, a->inicio);
    fprintf(yyout, "  li  $t%d, %d\n", a->registroFin, a->fin);

    //inicio bucle
    fprintf(yyout, "  etiq%d:\n", etiquetaTemporal);

    //cuerpo del bucle
    eval(a->r);

    //Incrementar el contador
    fprintf(yyout, "  addi $t%d, $t%d, %d\n", a->registroIni, a->registroIni, a->incremento);   //incrementamos el contador
    
    //Comparacion para finalizar el bucle
    fprintf(yyout, "  slt $t%d, $t%d, $t%d\n", a->registroInc, a->registroIni, a->registroFin);
    fprintf(yyout, "  beq $t%d, $t%d, etiq%d\n", a->registroIni, a->registroFin, etiquetaTemporal);
    fprintf(yyout, "  beq $t%d, $zero, etiq%d\n", a->registroInc, etiquetaTemporal+1);
    fprintf(yyout, "  beq $t%d, 1, etiq%d\n", a->registroInc, etiquetaTemporal);

    fprintf(yyout, "  etiq%d:\n", etiquetaTemporal+1);

    break;

  case 'P': // Imprimir
    // printf("-> Statement Imprimir\n");
    //  Resuelve la operación evaluandola
    eval(a->l);
    // Imprime el resultado almacenado en al registro de
    imprimir(a->l);
    break;

  case 'SL': // Statement List
    // printf("-> Statement List\n");
    v = eval(a->l); // statement_list
    eval(a->r);     // staetment
    break;
    
  case 'CM': // Comentario
    v = 1;   // No hay que hacer nada por que es un comentario
    break;
  
  default:
    printf("Error: Nodo desconocido %c\n", a->nodetype);
  }
  return v;
}

double iniciar_evaluacion(struct nodo *a)
{
  // Crea todas las variables necesarias en .data
  fprintf(yyout, "\n.data #Variables\n");
  // Variable que SIEMPRE se imprime para el salto de línea
  fprintf(yyout, "  newLine: .asciiz \"\\n\"\n");
  // Variable que SIEMPRE se imprime para tener un zero float
  fprintf(yyout, "  zero_f: .float 0.0\n");
  // Recorremos el array de las variables que hay que definir
  for (int i = 0; i < 32; i++)
  {
    // Si el espacio del array tiene algo
    if (array_variables[i][2] == 1)
    {
      // printf("%d\n", array_variables[i][0]);
      //  Define la variable
      fprintf(yyout, "  variable%d: .float %f\n", (int)array_variables[i][1], array_variables[i][0]);
      // La elimina pues ya se ha declarado
      array_variables[i][2] = 0;
    }
  }

  fprintf(yyout, "\n.text #Operaciones\n");
  fprintf(yyout, "  lwc1 $f31, zero_f\n\n");

  return eval(a); // Con las variables ya definidas, comienza a evaluar la operación
}

void imprimir(struct nodo *a)
{
  // Preparar para imprimir
  fprintf(yyout, "  li $v0, 2\n");
  // Mover del registro n al registro 12
  fprintf(yyout, "  add.s $f12, $f31, $f%d\n", a->registro);
  // fprintf(yyout,"  mov.s $f12, $f%d\n",a->registro);
  // Llamada al sistema
  fprintf(yyout, "  syscall\n");

  // Salto de línea
  fprintf(yyout, "  li $v0, 4\n");
  fprintf(yyout, "  la $a0, newLine\n");
  fprintf(yyout, "  syscall\n");
}

void si_statement(struct nodo *a, int numEtiqueta)
{
  // Calibrar que el valor del registro de la comparación sea 0
  fprintf(yyout, "  bc1f etiq%d\n", numEtiqueta);
  // salto a etiqueta
  // fprintf(yyout, "Etiq%d:\n", numEtiqueta);
}

void si_sino_statement(struct nodo *a, int numEtiqueta)
{
  // Si no se cumple el SI hay que ir a la etiqueta del SINO
  fprintf(yyout, "  bc1f etiq%d\n", numEtiqueta);
}

void mientras_statement(struct nodo *a, int numEtiqueta)
{
  // Calibrar que el valor del registro de la comparación sea 0
  fprintf(yyout, "  bc1f etiq%d\n", numEtiqueta);
  // Saltar a la etiqueta si la condición es falsa
  // fprintf(yyout, "Etiq%d:\n", numEtiqueta);
}