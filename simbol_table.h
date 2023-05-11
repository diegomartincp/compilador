//#include <string.h>

// Declaración de la tabla de símbolos
typedef struct {
    char *name;
    char *tipo;
    float real;
    int entero;
    char* texto;
    int registro;      //Registro donde está el resultado
} symbol;

/*
Esto es lo que hay que poner en el fichero bison para usarlo
symbol table[100];
int table_size = 0;//Se usa para conocer el índice del array disponible para insertar el siguiente número
*/

// Función para buscar un símbolo en la tabla
int lookup(char *name, int table_size, symbol table[]) {
    for (int i = 0; i < table_size; i++) {
        if (strcmp(table[i].name, name) == 0) {
            return i; //Devuelve la posición de la lista
        } 
    }
    return -1;  //-1 si no está en la tabla
}