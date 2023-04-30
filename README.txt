#1 PRUEBA CON CALCULADORA BÁSICA
bison -d -v prueba.y
flex -o prueba.lex.c prueba.flex
gcc -o analiza prueba.tab.c prueba.lex.c

# 2 PRUEBA CON CALCULADORA QUE USA UNION PARA OPERAR SOLO CON ENTEROS
bison -d -v prueba_union.y
flex -o prueba_union.lex.c prueba_union.flex
gcc -o analiza prueba_union.tab.c prueba_union.lex.c

# 3 PRUEBA CON CALCULADORA CON CONTROLES SEMÁNTICOS
bison -d -v prueba_controles_semanticos.y
flex -o prueba_controles_semanticos.lex.c prueba_controles_semanticos.flex
gcc -o controles_semanticos prueba_controles_semanticos.tab.c prueba_controles_semanticos.lex.c

# 4 PRUEBA VARIABLES EN TABLA DE SÍMBOLOS (Solo enteror)
bison -d -v prueba_variables.y
flex -o  prueba_variables.lex.c  prueba_variables.flex
gcc -o variables  prueba_variables.tab.c  prueba_variables.lex.c

# 4 PRUEBA CALCULADORA CON VARIABLES
bison -d -v controles_variables.y
flex -o  controles_variables.lex.c  controles_variables.flex
gcc -o calculadora_variables  controles_variables.tab.c  controles_variables.lex.c

# 5 PRUEBA CALCULADORA CON VARIABLES y AST
bison -d -v controles_variables_ast.y
flex -o  controles_variables_ast.lex.c  controles_variables_ast.flex
gcc -o ast  controles_variables_ast.tab.c  controles_variables_ast.lex.c