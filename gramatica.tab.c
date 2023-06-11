/* A Bison parser, made by GNU Bison 2.4.2.  */

/* Skeleton implementation for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989-1990, 2000-2006, 2009-2010 Free Software
   Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "2.4.2"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1

/* Using locations.  */
#define YYLSP_NEEDED 0



/* Copy the first part of user declarations.  */

/* Line 189 of yacc.c  */
#line 1 "gramatica.y"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "simbol_table.h"
#include "AST_V2.h"
#include <stdbool.h>

FILE *yyout;
extern FILE* yyin;

//Variables
int error_compilacion=0;
extern int linea; // Declaración de la variable "linea" como global

//Variables de la tabla de símbolos
symbol table[100];
int table_size = 0;//Se usa para conocer el índice del array disponible para insertar el siguiente número

//int numEtiqueta=0;
//bool variableGlobalFaltaEtiqueta= false;



/* Line 189 of yacc.c  */
#line 98 "gramatica.tab.c"

/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* Enabling the token table.  */
#ifndef YYTOKEN_TABLE
# define YYTOKEN_TABLE 0
#endif


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     MAS = 258,
     MENOS = 259,
     POR = 260,
     DIV = 261,
     LPAREN = 262,
     RPAREN = 263,
     CONCAT = 264,
     COMILLA = 265,
     IGUAL = 266,
     SI = 267,
     OSI = 268,
     SINO = 269,
     MIENTRAS = 270,
     FIN = 271,
     DOBLEAMPERSAN = 272,
     DOBLEBARRA = 273,
     IMPRIMIR = 274,
     COMENTARIO = 275,
     EXCLAMACION = 276,
     MAYQUE = 277,
     MENQUE = 278,
     MODULO = 279,
     EXPON = 280,
     MAYORIGUAL = 281,
     IGUALIGUAL = 282,
     MENORIGUAL = 283,
     PUNTOCOMA = 284,
     PARA = 285,
     EN = 286,
     RANGO = 287,
     COMA = 288,
     ENT = 289,
     REAL = 290,
     TEXT = 291,
     ID = 292
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 214 of yacc.c  */
#line 27 "gramatica.y"

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



/* Line 214 of yacc.c  */
#line 186 "gramatica.tab.c"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif


/* Copy the second part of user declarations.  */


/* Line 264 of yacc.c  */
#line 198 "gramatica.tab.c"

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#elif (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
typedef signed char yytype_int8;
#else
typedef short int yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(msgid) dgettext ("bison-runtime", msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(msgid) msgid
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(e) ((void) (e))
#else
# define YYUSE(e) /* empty */
#endif

/* Identity function, used to suppress warnings about constant conditions.  */
#ifndef lint
# define YYID(n) (n)
#else
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static int
YYID (int yyi)
#else
static int
YYID (yyi)
    int yyi;
#endif
{
  return yyi;
}
#endif

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#     ifndef _STDLIB_H
#      define _STDLIB_H 1
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's `empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (YYID (0))
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined _STDLIB_H \
       && ! ((defined YYMALLOC || defined malloc) \
	     && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef _STDLIB_H
#    define _STDLIB_H 1
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
	 || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

/* Copy COUNT objects from FROM to TO.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(To, From, Count) \
      __builtin_memcpy (To, From, (Count) * sizeof (*(From)))
#  else
#   define YYCOPY(To, From, Count)		\
      do					\
	{					\
	  YYSIZE_T yyi;				\
	  for (yyi = 0; yyi < (Count); yyi++)	\
	    (To)[yyi] = (From)[yyi];		\
	}					\
      while (YYID (0))
#  endif
# endif

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)				\
    do									\
      {									\
	YYSIZE_T yynewbytes;						\
	YYCOPY (&yyptr->Stack_alloc, Stack, yysize);			\
	Stack = &yyptr->Stack_alloc;					\
	yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
	yyptr += yynewbytes / sizeof (*yyptr);				\
      }									\
    while (YYID (0))

#endif

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  20
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   171

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  38
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  16
/* YYNRULES -- Number of rules.  */
#define YYNRULES  47
/* YYNRULES -- Number of states.  */
#define YYNSTATES  106

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   292

#define YYTRANSLATE(YYX)						\
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const yytype_uint8 yyprhs[] =
{
       0,     0,     3,     5,     7,    10,    12,    14,    16,    18,
      20,    22,    27,    31,    39,    46,    55,    57,    60,    66,
      73,    85,    95,   109,   113,   117,   120,   122,   126,   130,
     134,   138,   142,   146,   150,   154,   156,   160,   164,   168,
     172,   174,   176,   178,   181,   183,   186,   190
};

/* YYRHS -- A `-1'-separated list of the rules' RHS.  */
static const yytype_int8 yyrhs[] =
{
      39,     0,    -1,    40,    -1,    41,    -1,    40,    41,    -1,
      43,    -1,    44,    -1,    47,    -1,    48,    -1,    42,    -1,
      20,    -1,    19,     7,    51,     8,    -1,    37,    11,    51,
      -1,    12,     7,    49,     8,    40,    45,    16,    -1,    12,
       7,    49,     8,    40,    16,    -1,    12,     7,    49,     8,
      40,    14,    40,    16,    -1,    46,    -1,    45,    46,    -1,
      13,     7,    49,     8,    40,    -1,    15,     7,    49,     8,
      40,    16,    -1,    30,    37,    31,    32,     7,    34,    33,
      34,     8,    40,    16,    -1,    30,    37,    31,    32,     7,
      34,     8,    40,    16,    -1,    30,    37,    31,    32,     7,
      34,    33,    34,    33,    34,     8,    40,    16,    -1,    49,
      17,    50,    -1,    49,    18,    50,    -1,    21,    50,    -1,
      50,    -1,    51,    22,    51,    -1,    51,    23,    51,    -1,
      51,    26,    51,    -1,    51,    28,    51,    -1,    51,    27,
      51,    -1,    51,     3,    52,    -1,    51,     4,    52,    -1,
      51,     9,    52,    -1,    52,    -1,    52,     5,    53,    -1,
      52,     6,    53,    -1,    52,    24,    53,    -1,    52,    25,
      53,    -1,    53,    -1,    37,    -1,    34,    -1,     4,    34,
      -1,    35,    -1,     4,    35,    -1,     7,    51,     8,    -1,
      36,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,    65,    65,    87,    91,   103,   106,   109,   111,   113,
     116,   122,   142,   194,   195,   203,   214,   215,   218,   223,
     234,   242,   250,   261,   262,   263,   264,   280,   295,   309,
     323,   337,   352,   398,   446,   457,   462,   511,   561,   579,
     593,   599,   632,   640,   648,   656,   664,   667
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || YYTOKEN_TABLE
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "MAS", "MENOS", "POR", "DIV", "LPAREN",
  "RPAREN", "CONCAT", "COMILLA", "IGUAL", "SI", "OSI", "SINO", "MIENTRAS",
  "FIN", "DOBLEAMPERSAN", "DOBLEBARRA", "IMPRIMIR", "COMENTARIO",
  "EXCLAMACION", "MAYQUE", "MENQUE", "MODULO", "EXPON", "MAYORIGUAL",
  "IGUALIGUAL", "MENORIGUAL", "PUNTOCOMA", "PARA", "EN", "RANGO", "COMA",
  "ENT", "REAL", "TEXT", "ID", "$accept", "program", "statement_list",
  "statement", "imprimir_statement", "asignacion_statement",
  "si_statement", "osi_list", "osi", "mientras_statement",
  "para_statement", "condicion_list", "condicion", "exp", "term", "factor", 0
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[YYLEX-NUM] -- Internal token number corresponding to
   token YYLEX-NUM.  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    38,    39,    40,    40,    41,    41,    41,    41,    41,
      41,    42,    43,    44,    44,    44,    45,    45,    46,    47,
      48,    48,    48,    49,    49,    49,    49,    50,    50,    50,
      50,    50,    51,    51,    51,    51,    52,    52,    52,    52,
      52,    52,    53,    53,    53,    53,    53,    53
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     1,     1,     2,     1,     1,     1,     1,     1,
       1,     4,     3,     7,     6,     8,     1,     2,     5,     6,
      11,     9,    13,     3,     3,     2,     1,     3,     3,     3,
       3,     3,     3,     3,     3,     1,     3,     3,     3,     3,
       1,     1,     1,     2,     1,     2,     3,     1
};

/* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
   STATE-NUM when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,     0,     0,     0,    10,     0,     0,     0,     2,     3,
       9,     5,     6,     7,     8,     0,     0,     0,     0,     0,
       1,     4,     0,     0,     0,    42,    44,    47,    41,     0,
      26,     0,    35,    40,     0,     0,     0,    12,    43,    45,
       0,    25,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,    11,     0,
      46,     0,    23,    24,    32,    33,    34,    27,    28,    29,
      31,    30,    36,    37,    38,    39,     0,     0,     0,     0,
      14,     0,    16,    19,     0,     0,     0,    13,    17,     0,
       0,     0,    15,     0,     0,     0,    21,     0,     0,    18,
       0,     0,    20,     0,     0,    22
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
      -1,     7,     8,     9,    10,    11,    12,    81,    82,    13,
      14,    29,    30,    31,    32,    33
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -41
static const yytype_int16 yypact[] =
{
     132,    -3,     9,    12,   -41,    -9,    13,    32,   132,   -41,
     -41,   -41,   -41,   -41,   -41,     6,     6,    11,    25,    11,
     -41,   -41,   -13,    11,    11,   -41,   -41,   -41,   -41,    89,
     -41,     3,    76,   -41,   107,   150,    35,    68,   -41,   -41,
     162,   -41,   132,    11,    11,    11,    11,    11,    11,    11,
      11,    11,    11,    16,    16,    16,    16,   132,   -41,    57,
     -41,    46,   -41,   -41,    76,    76,    76,    68,    68,    68,
      68,    68,   -41,   -41,   -41,   -41,    74,    41,    72,   132,
     -41,    -2,   -41,   -41,     0,     6,    83,   -41,   -41,   132,
      50,   120,   -41,   102,    36,   132,   -41,   132,    53,   132,
     111,    97,   -41,   132,   130,   -41
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int8 yypgoto[] =
{
     -41,   -41,   -40,    -8,   -41,   -41,   -41,   -41,    -1,   -41,
     -41,   -15,    30,   -14,    63,    80
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If zero, do what YYDEFACT says.
   If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -1
static const yytype_uint8 yytable[] =
{
      21,    34,    61,    35,    15,    37,    45,    46,    89,    40,
      22,    78,    47,    23,    87,    22,    16,    76,    23,    17,
      22,    38,    39,    23,    19,    48,    49,    24,    18,    50,
      51,    52,    20,    90,    67,    68,    69,    70,    71,    86,
      25,    26,    27,    28,    97,    25,    26,    27,    28,    93,
      25,    26,    27,    21,    41,    99,    36,   100,     1,    78,
      79,     2,    80,   104,    77,     3,     4,    59,    21,    98,
      91,    45,    46,    62,    63,    84,     5,    47,    21,    85,
      88,    53,    54,     6,    94,    21,     1,   101,     0,     2,
      83,    21,    21,     3,     4,     1,    21,    42,     2,    92,
      55,    56,     3,     4,     5,   103,    43,    44,    64,    65,
      66,     6,     0,     5,     1,    57,     0,     2,    96,     0,
       6,     3,     4,     1,    43,    44,     2,   102,    95,     0,
       3,     4,     5,    72,    73,    74,    75,    43,    44,     6,
       0,     5,     1,     0,     1,     2,   105,     2,     6,     3,
       4,     3,     4,    45,    46,     0,     0,     0,    58,    47,
       5,     0,     5,     0,     0,    45,    46,     6,     0,     6,
      60,    47
};

static const yytype_int8 yycheck[] =
{
       8,    16,    42,    17,     7,    19,     3,     4,     8,    23,
       4,    13,     9,     7,    16,     4,     7,    57,     7,     7,
       4,    34,    35,     7,    11,    22,    23,    21,    37,    26,
      27,    28,     0,    33,    48,    49,    50,    51,    52,    79,
      34,    35,    36,    37,     8,    34,    35,    36,    37,    89,
      34,    35,    36,    61,    24,    95,    31,    97,    12,    13,
      14,    15,    16,   103,     7,    19,    20,    32,    76,    33,
      85,     3,     4,    43,    44,    34,    30,     9,    86,     7,
      81,     5,     6,    37,    34,    93,    12,    34,    -1,    15,
      16,    99,   100,    19,    20,    12,   104,     8,    15,    16,
      24,    25,    19,    20,    30,     8,    17,    18,    45,    46,
      47,    37,    -1,    30,    12,     8,    -1,    15,    16,    -1,
      37,    19,    20,    12,    17,    18,    15,    16,     8,    -1,
      19,    20,    30,    53,    54,    55,    56,    17,    18,    37,
      -1,    30,    12,    -1,    12,    15,    16,    15,    37,    19,
      20,    19,    20,     3,     4,    -1,    -1,    -1,     8,     9,
      30,    -1,    30,    -1,    -1,     3,     4,    37,    -1,    37,
       8,     9
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,    12,    15,    19,    20,    30,    37,    39,    40,    41,
      42,    43,    44,    47,    48,     7,     7,     7,    37,    11,
       0,    41,     4,     7,    21,    34,    35,    36,    37,    49,
      50,    51,    52,    53,    49,    51,    31,    51,    34,    35,
      51,    50,     8,    17,    18,     3,     4,     9,    22,    23,
      26,    27,    28,     5,     6,    24,    25,     8,     8,    32,
       8,    40,    50,    50,    52,    52,    52,    51,    51,    51,
      51,    51,    53,    53,    53,    53,    40,     7,    13,    14,
      16,    45,    46,    16,    34,     7,    40,    16,    46,     8,
      33,    49,    16,    40,    34,     8,    16,     8,    33,    40,
      40,    34,    16,     8,    40,    16
};

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		(-2)
#define YYEOF		0

#define YYACCEPT	goto yyacceptlab
#define YYABORT		goto yyabortlab
#define YYERROR		goto yyerrorlab


/* Like YYERROR except do call yyerror.  This remains here temporarily
   to ease the transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  However,
   YYFAIL appears to be in use.  Nevertheless, it is formally deprecated
   in Bison 2.4.2's NEWS entry, where a plan to phase it out is
   discussed.  */

#define YYFAIL		goto yyerrlab
#if defined YYFAIL
  /* This is here to suppress warnings from the GCC cpp's
     -Wunused-macros.  Normally we don't worry about that warning, but
     some users do, and we want to make it easy for users to remove
     YYFAIL uses, which will produce warnings from Bison 2.5.  */
#endif

#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)					\
do								\
  if (yychar == YYEMPTY && yylen == 1)				\
    {								\
      yychar = (Token);						\
      yylval = (Value);						\
      yytoken = YYTRANSLATE (yychar);				\
      YYPOPSTACK (1);						\
      goto yybackup;						\
    }								\
  else								\
    {								\
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;							\
    }								\
while (YYID (0))


#define YYTERROR	1
#define YYERRCODE	256


/* YYLLOC_DEFAULT -- Set CURRENT to span from RHS[1] to RHS[N].
   If N is 0, then set CURRENT to the empty location which ends
   the previous symbol: RHS[0] (always defined).  */

#define YYRHSLOC(Rhs, K) ((Rhs)[K])
#ifndef YYLLOC_DEFAULT
# define YYLLOC_DEFAULT(Current, Rhs, N)				\
    do									\
      if (YYID (N))                                                    \
	{								\
	  (Current).first_line   = YYRHSLOC (Rhs, 1).first_line;	\
	  (Current).first_column = YYRHSLOC (Rhs, 1).first_column;	\
	  (Current).last_line    = YYRHSLOC (Rhs, N).last_line;		\
	  (Current).last_column  = YYRHSLOC (Rhs, N).last_column;	\
	}								\
      else								\
	{								\
	  (Current).first_line   = (Current).last_line   =		\
	    YYRHSLOC (Rhs, 0).last_line;				\
	  (Current).first_column = (Current).last_column =		\
	    YYRHSLOC (Rhs, 0).last_column;				\
	}								\
    while (YYID (0))
#endif


/* YY_LOCATION_PRINT -- Print the location on the stream.
   This macro was not mandated originally: define only if we know
   we won't break user code: when these are the locations we know.  */

#ifndef YY_LOCATION_PRINT
# if defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL
#  define YY_LOCATION_PRINT(File, Loc)			\
     fprintf (File, "%d.%d-%d.%d",			\
	      (Loc).first_line, (Loc).first_column,	\
	      (Loc).last_line,  (Loc).last_column)
# else
#  define YY_LOCATION_PRINT(File, Loc) ((void) 0)
# endif
#endif


/* YYLEX -- calling `yylex' with the right arguments.  */

#ifdef YYLEX_PARAM
# define YYLEX yylex (YYLEX_PARAM)
#else
# define YYLEX yylex ()
#endif

/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)			\
do {						\
  if (yydebug)					\
    YYFPRINTF Args;				\
} while (YYID (0))

# define YY_SYMBOL_PRINT(Title, Type, Value, Location)			  \
do {									  \
  if (yydebug)								  \
    {									  \
      YYFPRINTF (stderr, "%s ", Title);					  \
      yy_symbol_print (stderr,						  \
		  Type, Value); \
      YYFPRINTF (stderr, "\n");						  \
    }									  \
} while (YYID (0))


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_value_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# else
  YYUSE (yyoutput);
# endif
  switch (yytype)
    {
      default:
	break;
    }
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (yytype < YYNTOKENS)
    YYFPRINTF (yyoutput, "token %s (", yytname[yytype]);
  else
    YYFPRINTF (yyoutput, "nterm %s (", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
#else
static void
yy_stack_print (yybottom, yytop)
    yytype_int16 *yybottom;
    yytype_int16 *yytop;
#endif
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)				\
do {								\
  if (yydebug)							\
    yy_stack_print ((Bottom), (Top));				\
} while (YYID (0))


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_reduce_print (YYSTYPE *yyvsp, int yyrule)
#else
static void
yy_reduce_print (yyvsp, yyrule)
    YYSTYPE *yyvsp;
    int yyrule;
#endif
{
  int yynrhs = yyr2[yyrule];
  int yyi;
  unsigned long int yylno = yyrline[yyrule];
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
	     yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr, yyrhs[yyprhs[yyrule] + yyi],
		       &(yyvsp[(yyi + 1) - (yynrhs)])
		       		       );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)		\
do {					\
  if (yydebug)				\
    yy_reduce_print (yyvsp, Rule); \
} while (YYID (0))

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef	YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif



#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static YYSIZE_T
yystrlen (const char *yystr)
#else
static YYSIZE_T
yystrlen (yystr)
    const char *yystr;
#endif
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static char *
yystpcpy (char *yydest, const char *yysrc)
#else
static char *
yystpcpy (yydest, yysrc)
    char *yydest;
    const char *yysrc;
#endif
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
	switch (*++yyp)
	  {
	  case '\'':
	  case ',':
	    goto do_not_strip_quotes;

	  case '\\':
	    if (*++yyp != '\\')
	      goto do_not_strip_quotes;
	    /* Fall through.  */
	  default:
	    if (yyres)
	      yyres[yyn] = *yyp;
	    yyn++;
	    break;

	  case '"':
	    if (yyres)
	      yyres[yyn] = '\0';
	    return yyn;
	  }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into YYRESULT an error message about the unexpected token
   YYCHAR while in state YYSTATE.  Return the number of bytes copied,
   including the terminating null byte.  If YYRESULT is null, do not
   copy anything; just return the number of bytes that would be
   copied.  As a special case, return 0 if an ordinary "syntax error"
   message will do.  Return YYSIZE_MAXIMUM if overflow occurs during
   size calculation.  */
static YYSIZE_T
yysyntax_error (char *yyresult, int yystate, int yychar)
{
  int yyn = yypact[yystate];

  if (! (YYPACT_NINF < yyn && yyn <= YYLAST))
    return 0;
  else
    {
      int yytype = YYTRANSLATE (yychar);
      YYSIZE_T yysize0 = yytnamerr (0, yytname[yytype]);
      YYSIZE_T yysize = yysize0;
      YYSIZE_T yysize1;
      int yysize_overflow = 0;
      enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
      char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
      int yyx;

# if 0
      /* This is so xgettext sees the translatable formats that are
	 constructed on the fly.  */
      YY_("syntax error, unexpected %s");
      YY_("syntax error, unexpected %s, expecting %s");
      YY_("syntax error, unexpected %s, expecting %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s");
# endif
      char *yyfmt;
      char const *yyf;
      static char const yyunexpected[] = "syntax error, unexpected %s";
      static char const yyexpecting[] = ", expecting %s";
      static char const yyor[] = " or %s";
      char yyformat[sizeof yyunexpected
		    + sizeof yyexpecting - 1
		    + ((YYERROR_VERBOSE_ARGS_MAXIMUM - 2)
		       * (sizeof yyor - 1))];
      char const *yyprefix = yyexpecting;

      /* Start YYX at -YYN if negative to avoid negative indexes in
	 YYCHECK.  */
      int yyxbegin = yyn < 0 ? -yyn : 0;

      /* Stay within bounds of both yycheck and yytname.  */
      int yychecklim = YYLAST - yyn + 1;
      int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
      int yycount = 1;

      yyarg[0] = yytname[yytype];
      yyfmt = yystpcpy (yyformat, yyunexpected);

      for (yyx = yyxbegin; yyx < yyxend; ++yyx)
	if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR)
	  {
	    if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
	      {
		yycount = 1;
		yysize = yysize0;
		yyformat[sizeof yyunexpected - 1] = '\0';
		break;
	      }
	    yyarg[yycount++] = yytname[yyx];
	    yysize1 = yysize + yytnamerr (0, yytname[yyx]);
	    yysize_overflow |= (yysize1 < yysize);
	    yysize = yysize1;
	    yyfmt = yystpcpy (yyfmt, yyprefix);
	    yyprefix = yyor;
	  }

      yyf = YY_(yyformat);
      yysize1 = yysize + yystrlen (yyf);
      yysize_overflow |= (yysize1 < yysize);
      yysize = yysize1;

      if (yysize_overflow)
	return YYSIZE_MAXIMUM;

      if (yyresult)
	{
	  /* Avoid sprintf, as that infringes on the user's name space.
	     Don't have undefined behavior even if the translation
	     produced a string with the wrong number of "%s"s.  */
	  char *yyp = yyresult;
	  int yyi = 0;
	  while ((*yyp = *yyf) != '\0')
	    {
	      if (*yyp == '%' && yyf[1] == 's' && yyi < yycount)
		{
		  yyp += yytnamerr (yyp, yyarg[yyi++]);
		  yyf += 2;
		}
	      else
		{
		  yyp++;
		  yyf++;
		}
	    }
	}
      return yysize;
    }
}
#endif /* YYERROR_VERBOSE */


/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
#else
static void
yydestruct (yymsg, yytype, yyvaluep)
    const char *yymsg;
    int yytype;
    YYSTYPE *yyvaluep;
#endif
{
  YYUSE (yyvaluep);

  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  switch (yytype)
    {

      default:
	break;
    }
}

/* Prevent warnings from -Wmissing-prototypes.  */
#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */


/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;

/* Number of syntax errors so far.  */
int yynerrs;



/*-------------------------.
| yyparse or yypush_parse.  |
`-------------------------*/

#ifdef YYPARSE_PARAM
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void *YYPARSE_PARAM)
#else
int
yyparse (YYPARSE_PARAM)
    void *YYPARSE_PARAM;
#endif
#else /* ! YYPARSE_PARAM */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void)
#else
int
yyparse ()

#endif
#endif
{


    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       `yyss': related to states.
       `yyvs': related to semantic values.

       Refer to the stacks thru separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yytype_int16 yyssa[YYINITDEPTH];
    yytype_int16 *yyss;
    yytype_int16 *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYSIZE_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yytoken = 0;
  yyss = yyssa;
  yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */

  /* Initialize stack pointers.
     Waste one element of value and location stack
     so that they stay on the same level as the state stack.
     The wasted elements are never initialized.  */
  yyssp = yyss;
  yyvsp = yyvs;

  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
	/* Give user a chance to reallocate the stack.  Use copies of
	   these so that the &'s don't force the real ones into
	   memory.  */
	YYSTYPE *yyvs1 = yyvs;
	yytype_int16 *yyss1 = yyss;

	/* Each stack pointer address is followed by the size of the
	   data in use in that stack, in bytes.  This used to be a
	   conditional around just the two extra args, but that might
	   be undefined if yyoverflow is a macro.  */
	yyoverflow (YY_("memory exhausted"),
		    &yyss1, yysize * sizeof (*yyssp),
		    &yyvs1, yysize * sizeof (*yyvsp),
		    &yystacksize);

	yyss = yyss1;
	yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
	goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
	yystacksize = YYMAXDEPTH;

      {
	yytype_int16 *yyss1 = yyss;
	union yyalloc *yyptr =
	  (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
	if (! yyptr)
	  goto yyexhaustedlab;
	YYSTACK_RELOCATE (yyss_alloc, yyss);
	YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
	if (yyss1 != yyssa)
	  YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
		  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
	YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yyn == YYPACT_NINF)
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = YYLEX;
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yyn == 0 || yyn == YYTABLE_NINF)
	goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token.  */
  yychar = YYEMPTY;

  yystate = yyn;
  *++yyvsp = yylval;

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     `$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:

/* Line 1464 of yacc.c  */
#line 65 "gramatica.y"
    {
        printf("------------------------\n");
        printf("SENTENCIA RECONOCIDA\n");
        if(error_compilacion>=1){
            printf("\nHa habido %d error(es) de compilacion\n",error_compilacion);
        }
        printf("CREANDO CODIGO .ASM\n");
        printf("------------------------\n");
        double valor = iniciar_evaluacion((yyvsp[(1) - (1)].st).a); //$1.a->registro
        /*printf(">>>Resultado evaluado= %f\n",valor);
        printf("\n>>>Variables de la tabla de símbolos: %f\n",valor);
        for (int i = 0; i < 100; i++){
        printf("%s\n",table[i].name);
        }*/
        printf("------------------------\n");
        printf("COMPILACION TERMINADA\n");
            
    ;}
    break;

  case 3:

/* Line 1464 of yacc.c  */
#line 87 "gramatica.y"
    {
        printf("-> STATEMENT\n");
        (yyval.st).a=(yyvsp[(1) - (1)].st).a;
    ;}
    break;

  case 4:

/* Line 1464 of yacc.c  */
#line 91 "gramatica.y"
    {
        printf("-> STATEMENT LIST\n");
        (yyval.st).a = new_node('SL', (yyvsp[(1) - (2)].st).a, (yyvsp[(2) - (2)].st).a);
        if((yyval.st).a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para almacenar la lista de statements\n",linea);
            }
    ;}
    break;

  case 5:

/* Line 1464 of yacc.c  */
#line 103 "gramatica.y"
    {
        (yyval.st).a=(yyvsp[(1) - (1)].st).a;
    ;}
    break;

  case 6:

/* Line 1464 of yacc.c  */
#line 106 "gramatica.y"
    {
        (yyval.st).a=(yyvsp[(1) - (1)].st).a;
    ;}
    break;

  case 7:

/* Line 1464 of yacc.c  */
#line 109 "gramatica.y"
    {
    ;}
    break;

  case 8:

/* Line 1464 of yacc.c  */
#line 111 "gramatica.y"
    {
    ;}
    break;

  case 9:

/* Line 1464 of yacc.c  */
#line 113 "gramatica.y"
    {
        (yyval.st).a=(yyvsp[(1) - (1)].st).a;
    ;}
    break;

  case 10:

/* Line 1464 of yacc.c  */
#line 116 "gramatica.y"
    {
        (yyval.st).a = new_leaf_comment();
        //No hace nada por que es un comentario :)
    ;}
    break;

  case 11:

/* Line 1464 of yacc.c  */
#line 122 "gramatica.y"
    { //imprimir un identificador
           /*if(variableGlobalFaltaEtiqueta==true){  //Hay que imprimir una etiqueta
                printf(yyout, "Etiqueta%d",numEtiqueta);
                numEtiqueta++;
            }*/
            //Evaluamos la expresión
            //double valor = iniciar_evaluacion($3.a); //Evaluar la exppresión para hacer la asignación
            //printf(">>>IMPRIMIR %f\n",valor);
            //Ya conocemos en que registro está el valor, que será float
            printf("-> IMPRIMIR\n");
            (yyval.st).a = new_node('P',(yyvsp[(3) - (4)].st).a, nodo_vacio());
            if((yyval.st).a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion imprimir\n",linea);
            }
            
        ;}
    break;

  case 12:

/* Line 1464 of yacc.c  */
#line 142 "gramatica.y"
    {
        printf("-> ASIGNACION\n");
        int i = lookup((yyvsp[(1) - (3)].stringVal),table_size,table);
        if (i == -1) {  //Si no está en la tabla de símbolos, se crea uno nuevo
            if(strcmp((yyvsp[(3) - (3)].st).tipo, "entero")==0){
                printf("Se asigna a la variable el resultado de la operacion con un %d\n",(yyvsp[(3) - (3)].st).entero);

                table[table_size].name = (yyvsp[(1) - (3)].stringVal);
                table[table_size].tipo = "entero";
                table[table_size].entero = (yyvsp[(3) - (3)].st).entero;
                table[table_size].registro = (yyvsp[(3) - (3)].st).a->registro;
                table_size++;
            }
            else if(strcmp((yyvsp[(3) - (3)].st).tipo, "real")==0){
                printf("Se asigna a la variable el resultado de la operacion con un %f\n",(yyvsp[(3) - (3)].st).real);

                table[table_size].name = (yyvsp[(1) - (3)].stringVal);
                table[table_size].tipo = "real";
                table[table_size].real = (yyvsp[(3) - (3)].st).real;
                table[table_size].registro = (yyvsp[(3) - (3)].st).a->registro;
                table_size++;
            }

            (yyval.st).a=new_node('A',(yyvsp[(3) - (3)].st).a, nodo_vacio());
            if((yyval.st).a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion asignacion\n",linea);
            }

        }else{  //Ya se encuentra en la tabla de símbolos y se conoce su posición
            printf("# Sobreescribir la varible -%s-, que se encuentra en el registro  $f%d\n",table[i].name ,table[i].registro); 
            //Si lo encuentra, tiene que coger el resultado de exp y moverlo al registro
            //que tiene asignada la variable
            if(strcmp((yyvsp[(3) - (3)].st).tipo, "entero")==0){
                table[i].tipo = "entero";
                table[i].entero = (yyvsp[(3) - (3)].st).entero;
            }
            else if(strcmp((yyvsp[(3) - (3)].st).tipo, "real")==0){
                table[i].tipo = "real";
                table[i].real = (yyvsp[(3) - (3)].st).real;
            }

            (yyval.st).a=new_node('R',(yyvsp[(3) - (3)].st).a, nodo_con_info_para_asignacion(table[i].registro));
            if((yyval.st).a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion asignacion\n",linea);
            }            
        }
    ;}
    break;

  case 13:

/* Line 1464 of yacc.c  */
#line 194 "gramatica.y"
    {printf("Bucle SI con cadena de OSI\n");;}
    break;

  case 14:

/* Line 1464 of yacc.c  */
#line 195 "gramatica.y"
    {
        printf("-> SI\n");
        (yyval.st).a = new_node('S',(yyvsp[(3) - (6)].st).a, (yyvsp[(5) - (6)].st).a);
        if((yyval.st).a->registro==-1){
            error_compilacion++;
            printf("ERROR LINEA %d: No quedan registros disponibles para realizar la sentencia SI\n",linea);
        }
        ;}
    break;

  case 15:

/* Line 1464 of yacc.c  */
#line 203 "gramatica.y"
    {
        printf("-> SI con SINO\n");
        (yyval.st).a = new_node_sino((yyvsp[(3) - (8)].st).a,(yyvsp[(5) - (8)].st).a, (yyvsp[(7) - (8)].st).a);
        if((yyval.st).a->registro==-1){
            error_compilacion++;
            printf("ERROR LINEA %d: No quedan registros disponibles para realizar la sentencia SI\n",linea);
        }
    ;}
    break;

  case 16:

/* Line 1464 of yacc.c  */
#line 214 "gramatica.y"
    {printf("UN OSI\n");;}
    break;

  case 17:

/* Line 1464 of yacc.c  */
#line 215 "gramatica.y"
    {printf("VARIOS OSI\n");;}
    break;

  case 18:

/* Line 1464 of yacc.c  */
#line 218 "gramatica.y"
    {printf("OSI\n");;}
    break;

  case 19:

/* Line 1464 of yacc.c  */
#line 223 "gramatica.y"
    {
        printf("-> MIENTRAS\n");
        (yyval.st).a = new_node('M',(yyvsp[(3) - (6)].st).a,(yyvsp[(5) - (6)].st).a);
        if((yyval.st).a->registro==-1){
            error_compilacion++;
            printf("ERROR LINEA %d: No quedan registros disponibles para realizar la sentencia MIENTRAS\n",linea);
        }
    ;}
    break;

  case 20:

/* Line 1464 of yacc.c  */
#line 234 "gramatica.y"
    {
        printf("-> PARA\n");
        (yyval.st).a = new_node_para(strdup((yyvsp[(2) - (11)].stringVal)), (yyvsp[(6) - (11)].intVal), (yyvsp[(8) - (11)].intVal), (yyvsp[(10) - (11)].st).a);
        if((yyval.st).a->registro==-1){
            error_compilacion++;
            printf("ERROR LINEA %d: No quedan registros disponibles para realizar la condicion\n",linea);
        }
    ;}
    break;

  case 21:

/* Line 1464 of yacc.c  */
#line 242 "gramatica.y"
    {
        printf("-> PARA2\n");
        (yyval.st).a = new_node_para2(strdup((yyvsp[(2) - (9)].stringVal)), (yyvsp[(6) - (9)].intVal), (yyvsp[(8) - (9)].st).a);
        if((yyval.st).a->registro==-1){
            error_compilacion++;
            printf("ERROR LINEA %d: No quedan registros disponibles para realizar la condicion\n",linea);
        }
    ;}
    break;

  case 22:

/* Line 1464 of yacc.c  */
#line 250 "gramatica.y"
    {
        printf("-> PARA3\n");
        (yyval.st).a = new_node_para3(strdup((yyvsp[(2) - (13)].stringVal)), (yyvsp[(6) - (13)].intVal), (yyvsp[(8) - (13)].intVal), (yyvsp[(10) - (13)].intVal), (yyvsp[(12) - (13)].st).a);
        if((yyval.st).a->registro==-1){
            error_compilacion++;
            printf("ERROR LINEA %d: No quedan registros disponibles para realizar la condicion\n",linea);
        }
    ;}
    break;

  case 23:

/* Line 1464 of yacc.c  */
#line 261 "gramatica.y"
    {printf("Condicion && condicion\n");;}
    break;

  case 24:

/* Line 1464 of yacc.c  */
#line 262 "gramatica.y"
    {printf("Condicion || condicion\n");;}
    break;

  case 25:

/* Line 1464 of yacc.c  */
#line 263 "gramatica.y"
    {printf("!condicion\n");;}
    break;

  case 26:

/* Line 1464 of yacc.c  */
#line 264 "gramatica.y"
    {
        (yyval.st).a = (yyvsp[(1) - (1)].st).a;
        printf("-> CONDICION\n");
        (yyval.st).a = new_node('C',(yyvsp[(1) - (1)].st).a, nodo_vacio());
        if((yyval.st).a->registro==-1){
            error_compilacion++;
            printf("ERROR LINEA %d: No quedan registros disponibles para realizar la condicion\n",linea);
        }
        //double valor = iniciar_evaluacion($1.a); //$1.a->registro
        //printf(">>>Resultado evaluado comparacion MAYOR QUE= %f\n",valor);
    ;}
    break;

  case 27:

/* Line 1464 of yacc.c  */
#line 280 "gramatica.y"
    {
        printf("-> MAYOR QUEL\n");
        if (strcmp((yyvsp[(1) - (3)].st).tipo, "texto")==0 || strcmp((yyvsp[(3) - (3)].st).tipo, "texto")==0) { 
            error_compilacion++;
            printf("ERROR: Operacion no reconocida %d",linea);
        } else {
            (yyval.st).a = new_node('>', (yyvsp[(1) - (3)].st).a, (yyvsp[(3) - (3)].st).a);
            if((yyval.st).a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la condicion 'mayor que'\n",linea);
            }
            (yyval.st).tipo = "bool";
        }
        
    ;}
    break;

  case 28:

/* Line 1464 of yacc.c  */
#line 295 "gramatica.y"
    {
        printf("-> MENOR QUE\n");
        if (strcmp((yyvsp[(1) - (3)].st).tipo, "texto")==0 || strcmp((yyvsp[(3) - (3)].st).tipo, "texto")==0) { 
            error_compilacion++;
            printf("ERROR LINEA %d: Operacion no reconocida",linea);
        } else {
            (yyval.st).a = new_node('<', (yyvsp[(1) - (3)].st).a, (yyvsp[(3) - (3)].st).a);
            if((yyval.st).a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la condicion 'menor que'\n",linea);
            }
            (yyval.st).tipo = "bool";
        }
    ;}
    break;

  case 29:

/* Line 1464 of yacc.c  */
#line 309 "gramatica.y"
    {
        printf("-> MAYOR O IGUAL\n");
        if (strcmp((yyvsp[(1) - (3)].st).tipo, "texto")==0 || strcmp((yyvsp[(3) - (3)].st).tipo, "texto")==0) { 
            error_compilacion++;
            printf("ERROR: Operacion no reconocida %d",linea);
        } else {
            (yyval.st).a = new_node('>=', (yyvsp[(1) - (3)].st).a, (yyvsp[(3) - (3)].st).a);
            if((yyval.st).a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la condicion 'mayor o igual que'\n",linea);
            }
            (yyval.st).tipo = "bool";
        }
    ;}
    break;

  case 30:

/* Line 1464 of yacc.c  */
#line 323 "gramatica.y"
    {
        printf("-> MENOR O IGUAL\n");
        if (strcmp((yyvsp[(1) - (3)].st).tipo, "texto")==0 || strcmp((yyvsp[(3) - (3)].st).tipo, "texto")==0) { 
            error_compilacion++;
            printf("ERROR: Operacion no reconocida %d",linea);
        } else {
            (yyval.st).a = new_node('<=', (yyvsp[(1) - (3)].st).a, (yyvsp[(3) - (3)].st).a);
            if((yyval.st).a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la condicion 'menor o igual que'\n",linea);
            }
            (yyval.st).tipo = "bool";
        }
    ;}
    break;

  case 31:

/* Line 1464 of yacc.c  */
#line 337 "gramatica.y"
    {
        printf("-> IGUAL QUE\n");
        if (strcmp((yyvsp[(1) - (3)].st).tipo, "texto")==0 || strcmp((yyvsp[(3) - (3)].st).tipo, "texto")==0) { 
            error_compilacion++;
            printf("ERROR: Operacion no reconocida %d",linea);
        } else {
            (yyval.st).a = new_node('==', (yyvsp[(1) - (3)].st).a, (yyvsp[(3) - (3)].st).a);
            if((yyval.st).a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la condicion 'igual igual que'\n",linea);
            }
            (yyval.st).tipo = "bool";
        }
    ;}
    break;

  case 32:

/* Line 1464 of yacc.c  */
#line 352 "gramatica.y"
    {
        if (strcmp((yyvsp[(1) - (3)].st).tipo, "entero")==0 && strcmp((yyvsp[(3) - (3)].st).tipo, "entero")==0) { //Si ambos son enteros
            (yyval.st).a = new_node('+', (yyvsp[(1) - (3)].st).a,(yyvsp[(3) - (3)].st).a); 
            if((yyval.st).a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion suma\n",linea);
            }
            (yyval.st).tipo="entero";
            (yyval.st).entero=(yyvsp[(1) - (3)].st).entero+(yyvsp[(3) - (3)].st).entero;
            printf("-> SUMA entero+entero\n");  
        }
        else if (strcmp((yyvsp[(1) - (3)].st).tipo, "real")==0 && strcmp((yyvsp[(3) - (3)].st).tipo, "real")==0){  //Si los dos son float
            (yyval.st).a = new_node('+', (yyvsp[(1) - (3)].st).a,(yyvsp[(3) - (3)].st).a);
            if((yyval.st).a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion suma\n",linea);
            }
            (yyval.st).tipo="real";
            (yyval.st).real=(yyvsp[(1) - (3)].st).real+(yyvsp[(3) - (3)].st).real;
            printf("-> SUMA real+real\n");
        }
        else if (strcmp((yyvsp[(1) - (3)].st).tipo, "entero")==0 && strcmp((yyvsp[(3) - (3)].st).tipo, "real")==0){  // Entero y real
            (yyval.st).a = new_node('+', (yyvsp[(1) - (3)].st).a,(yyvsp[(3) - (3)].st).a);
            if((yyval.st).a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion suma\n",linea);
            }
            (yyval.st).tipo="real";
            (yyval.st).real=(yyvsp[(1) - (3)].st).entero+(yyvsp[(3) - (3)].st).real;
            printf("-> SUMA entero+real\n");
        }
        else if (strcmp((yyvsp[(1) - (3)].st).tipo, "real")==0 && strcmp((yyvsp[(3) - (3)].st).tipo, "entero")==0){  // Real y entero
            (yyval.st).a = new_node('+', (yyvsp[(1) - (3)].st).a,(yyvsp[(3) - (3)].st).a);
            if((yyval.st).a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion suma\n",linea);
            }
            (yyval.st).tipo="real";
            (yyval.st).real=(yyvsp[(1) - (3)].st).real+(yyvsp[(3) - (3)].st).entero;
            printf("-> SUMA real+entero\n");
        }
        else{
            error_compilacion++;
            printf("ERROR LINEA %d: No se puede operar en línea\n",linea);
        }
    ;}
    break;

  case 33:

/* Line 1464 of yacc.c  */
#line 398 "gramatica.y"
    {
        if (strcmp((yyvsp[(1) - (3)].st).tipo, "entero")==0 && strcmp((yyvsp[(3) - (3)].st).tipo, "entero")==0) { //Si ambos son enteros
            (yyval.st).a = new_node('-', (yyvsp[(1) - (3)].st).a,(yyvsp[(3) - (3)].st).a);
            if((yyval.st).a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion resta\n",linea);
            }
            (yyval.st).tipo="entero";
            (yyval.st).entero=(yyvsp[(1) - (3)].st).entero+(yyvsp[(3) - (3)].st).entero;
            printf("-> RESTA entero-entero\n");
        }
        else if (strcmp((yyvsp[(1) - (3)].st).tipo, "real")==0 && strcmp((yyvsp[(3) - (3)].st).tipo, "real")==0){  //Si los dos son float
            (yyval.st).a = new_node('-', (yyvsp[(1) - (3)].st).a,(yyvsp[(3) - (3)].st).a);
            if((yyval.st).a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion suma\n",linea);
            }
            (yyval.st).tipo="real";
            (yyval.st).real=(yyvsp[(1) - (3)].st).real+(yyvsp[(3) - (3)].st).real;
            printf("-> RESTA real-real\n");
        }
        else if (strcmp((yyvsp[(1) - (3)].st).tipo, "entero")==0 && strcmp((yyvsp[(3) - (3)].st).tipo, "real")==0){  // Entero y real
            (yyval.st).a = new_node('-', (yyvsp[(1) - (3)].st).a,(yyvsp[(3) - (3)].st).a);
            if((yyval.st).a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion suma\n",linea);
            }
            (yyval.st).tipo="real";
            (yyval.st).real=(yyvsp[(1) - (3)].st).entero+(yyvsp[(3) - (3)].st).real;
            printf("-> RESTA entero-real\n");
        }
        else if (strcmp((yyvsp[(1) - (3)].st).tipo, "real")==0 && strcmp((yyvsp[(3) - (3)].st).tipo, "entero")==0){  // Real y entero
            (yyval.st).a = new_node('-', (yyvsp[(1) - (3)].st).a,(yyvsp[(3) - (3)].st).a);
            if((yyval.st).a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion suma\n",linea);
            }
            (yyval.st).tipo="real";
            printf("-> RESTA real-entero\n");
        }
        else{
                error_compilacion++;
                printf( "ERROR: No se puede operar\n");
        }
    ;}
    break;

  case 34:

/* Line 1464 of yacc.c  */
#line 446 "gramatica.y"
    {
        if (strcmp((yyvsp[(1) - (3)].st).tipo, "texto")==0 && strcmp((yyvsp[(3) - (3)].st).tipo, "texto")==0){
            (yyval.st).texto = strcat((yyvsp[(1) - (3)].st).texto, (yyvsp[(3) - (3)].st).texto);
            (yyval.st).tipo="texto";
            printf( "Concatenado -> %s\n",(yyval.st).texto);
        }
        else{
            error_compilacion++;
            printf( "ERROR LINEA %d: No se puede concatenar algo que no sean cadenas de texto\n",linea);
        }
    ;}
    break;

  case 35:

/* Line 1464 of yacc.c  */
#line 457 "gramatica.y"
    {
        //printf("Termino con tipo %s\n",$1.tipo);
        (yyval.st) = (yyvsp[(1) - (1)].st); ;}
    break;

  case 36:

/* Line 1464 of yacc.c  */
#line 462 "gramatica.y"
    {
        if (strcmp((yyvsp[(1) - (3)].st).tipo, "entero")==0 && strcmp((yyvsp[(3) - (3)].st).tipo, "entero")==0) { //Si ambos son enteros
            (yyval.st).a = new_node('*', (yyvsp[(1) - (3)].st).a,(yyvsp[(3) - (3)].st).a);
            if((yyval.st).a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion multiplicar\n",linea);
            }
            (yyval.st).tipo="entero";
            (yyval.st).entero=(yyvsp[(1) - (3)].st).entero+(yyvsp[(3) - (3)].st).entero;
            printf( "-> MULTIPLICACION entero*entero\n");
        }
        else if (strcmp((yyvsp[(1) - (3)].st).tipo, "real")==0 && strcmp((yyvsp[(3) - (3)].st).tipo, "real")==0){  //Si los dos son float
            (yyval.st).a = new_node('*', (yyvsp[(1) - (3)].st).a,(yyvsp[(3) - (3)].st).a);
            if((yyval.st).a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion multiplicar\n",linea);
            }
            (yyval.st).tipo="real";
            (yyval.st).real=(yyvsp[(1) - (3)].st).real+(yyvsp[(3) - (3)].st).real;
            printf( "-> MULTIPLICACION real*real\n");
        }
        else if (strcmp((yyvsp[(1) - (3)].st).tipo, "entero")==0 && strcmp((yyvsp[(3) - (3)].st).tipo, "real")==0){  // Entero y real
            (yyval.st).a = new_node('*', (yyvsp[(1) - (3)].st).a,(yyvsp[(3) - (3)].st).a);
            if((yyval.st).a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion multiplicar\n",linea);
            }
            (yyval.st).tipo="real";
            (yyval.st).real=(yyvsp[(1) - (3)].st).entero+(yyvsp[(3) - (3)].st).real;
            printf( "-> MULTIPLICACION entero*real\n");
        }
        else if (strcmp((yyvsp[(1) - (3)].st).tipo, "real")==0 && strcmp((yyvsp[(3) - (3)].st).tipo, "entero")==0){  // Real y entero
            (yyval.st).a = new_node('*', (yyvsp[(1) - (3)].st).a,(yyvsp[(3) - (3)].st).a);
            if((yyval.st).a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion multiplicar\n",linea);
            }
            (yyval.st).tipo="real";
            (yyval.st).real=(yyvsp[(1) - (3)].st).real+(yyvsp[(3) - (3)].st).entero;
            printf( "-> MULTIPLICACION real*entero\n");
        }
        else{
             error_compilacion++;
             printf( "ERROR LINEA %d: No se puede realizar la operacion multiplicar con estos operandos");
        }
    ;}
    break;

  case 37:

/* Line 1464 of yacc.c  */
#line 511 "gramatica.y"
    {
        if (strcmp((yyvsp[(1) - (3)].st).tipo, "entero")==0 && strcmp((yyvsp[(3) - (3)].st).tipo, "entero")==0) { //Si ambos son enteros
            (yyval.st).a = new_node('/', (yyvsp[(1) - (3)].st).a,(yyvsp[(3) - (3)].st).a);
            if((yyval.st).a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion dividir\n",linea);
            } 
            (yyval.st).tipo="entero";
            (yyval.st).entero=(yyvsp[(1) - (3)].st).entero+(yyvsp[(3) - (3)].st).entero;
            printf( "-> DIVISION entero/entero\n");
        }
        else if (strcmp((yyvsp[(1) - (3)].st).tipo, "real")==0 && strcmp((yyvsp[(3) - (3)].st).tipo, "real")==0){  //Si los dos son float
            (yyval.st).a = new_node('/', (yyvsp[(1) - (3)].st).a,(yyvsp[(3) - (3)].st).a); 
            if((yyval.st).a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion dividir\n",linea);
            } 
            (yyval.st).tipo="real";
            (yyval.st).real=(yyvsp[(1) - (3)].st).real+(yyvsp[(3) - (3)].st).real;
            printf( "-> DIVISION real/real\n");
        }
        else if (strcmp((yyvsp[(1) - (3)].st).tipo, "entero")==0 && strcmp((yyvsp[(3) - (3)].st).tipo, "real")==0){  // Entero y real
            (yyval.st).a = new_node('/', (yyvsp[(1) - (3)].st).a,(yyvsp[(3) - (3)].st).a); 
            if((yyval.st).a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion dividir\n",linea);
            } 
            (yyval.st).tipo="real";
            (yyval.st).real=(yyvsp[(1) - (3)].st).entero+(yyvsp[(3) - (3)].st).real;
            printf( "-> DIVISION entero/real\n");
        }
        else if (strcmp((yyvsp[(1) - (3)].st).tipo, "real")==0 && strcmp((yyvsp[(3) - (3)].st).tipo, "entero")==0){  // Real y entero
            (yyval.st).a = new_node('/', (yyvsp[(1) - (3)].st).a,(yyvsp[(3) - (3)].st).a); 
            if((yyval.st).a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion dividir\n",linea);
            } 
            (yyval.st).tipo="real";
            (yyval.st).real=(yyvsp[(1) - (3)].st).real+(yyvsp[(3) - (3)].st).entero;
            printf( "-> DIVISION real/entero\n");
        }
        else{
             error_compilacion++;
             printf( "ERROR LINEA %d: No se puede realizar la operacion dividir con estos operandos",linea);
        }
    ;}
    break;

  case 38:

/* Line 1464 of yacc.c  */
#line 561 "gramatica.y"
    { //solo se puede hacer con enteros
        printf("-> MODULO\n");
        if (strcmp((yyvsp[(1) - (3)].st).tipo, "entero")==0 && strcmp((yyvsp[(3) - (3)].st).tipo, "entero")==0) { //Si ambos son enteros
            (yyval.st).a = new_node('%', (yyvsp[(1) - (3)].st).a,(yyvsp[(3) - (3)].st).a); 
            if((yyval.st).a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion modulo\n",linea);
            } 
            (yyval.st).tipo="entero";
            printf( "-> MODULO entero %% entero \n");
        } else{
             error_compilacion++;
             printf( "ERROR LINEA %d: No se puede operar con operadores no enteros\n",linea);
        }   
    ;}
    break;

  case 39:

/* Line 1464 of yacc.c  */
#line 579 "gramatica.y"
    { //solo se puede hacer con enteros
        if (strcmp((yyvsp[(1) - (3)].st).tipo, "entero")==0 && strcmp((yyvsp[(3) - (3)].st).tipo, "entero")==0) { //Si ambos son enteros
            (yyval.st).a = new_node('^', (yyvsp[(1) - (3)].st).a,(yyvsp[(3) - (3)].st).a);
            if((yyval.st).a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para realizar la operacion exponente\n",linea);
            } 
            (yyval.st).tipo="entero";
            printf( "-> EXPONENTE entero^entero\n");
        } else{
             error_compilacion++;
             printf( "ERROR: No se puede operar\n");
        }
    ;}
    break;

  case 40:

/* Line 1464 of yacc.c  */
#line 593 "gramatica.y"
    {
        //printf("Factor con tipo %s\n",$1.tipo);
        (yyval.st) = (yyvsp[(1) - (1)].st);;}
    break;

  case 41:

/* Line 1464 of yacc.c  */
#line 599 "gramatica.y"
    {
            printf("-> ID %s\n",(yyvsp[(1) - (1)].stringVal));
            //printf("Hemos encontrado un identificador");
            //Hemos encontrado un identificador, hay que ver si está en la tabla para recogerlo y sino devolver un error
            int i = lookup((yyvsp[(1) - (1)].stringVal),table_size,table); //lo buscamos
            if(i == -1){
                printf( "ERROR LINEA %d: Se usa una variable que no ha sido definida anteriormente",linea);
            }
            else{
                //Controlamos de que tipo es
                if(table[i].tipo=="entero"){
                    (yyval.st).tipo = table[i].tipo;
                    (yyval.st).entero=table[i].entero;
                    //Crear nodo hoja con números
                    (yyval.st).a = new_var_leaf_num(table[i].entero,table[i].registro);    
                }
                else if(table[i].tipo=="real"){
                    (yyval.st).tipo = table[i].tipo;      
                    (yyval.st).real=table[i].real;
                    //Crear nodo hoja con números
                    (yyval.st).a = new_var_leaf_num(table[i].real,table[i].registro);        
                }
                else if(table[i].tipo=="texto"){
                    (yyval.st).tipo = table[i].tipo;

   //CREAR NODO TEXTO             
                }
                else{printf("ERROR LINEA %d: Variable de tipo desconocido",linea);}

            }
        ;}
    break;

  case 42:

/* Line 1464 of yacc.c  */
#line 632 "gramatica.y"
    {(yyval.st).entero = (yyvsp[(1) - (1)].intVal);
            (yyval.st).a = new_leaf_num((yyvsp[(1) - (1)].intVal));
            if((yyval.st).a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para asignar el entero %ld\n", linea,(yyval.st).entero);
            }  
            (yyval.st).tipo="entero"; 
            printf( "-> ENTERO: %ld\n", (yyval.st).entero);;}
    break;

  case 43:

/* Line 1464 of yacc.c  */
#line 640 "gramatica.y"
    {(yyval.st).entero = -(yyvsp[(2) - (2)].intVal);
            (yyval.st).a = new_leaf_num(-(yyvsp[(2) - (2)].intVal));
            if((yyval.st).a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para asignar el entero %ld\n", linea, (yyval.st).entero);
            }
            (yyval.st).tipo="entero";
            printf( "-> ENTERO NEGATIVO: %ld\n", (yyval.st).entero);;}
    break;

  case 44:

/* Line 1464 of yacc.c  */
#line 648 "gramatica.y"
    {(yyval.st).real = (yyvsp[(1) - (1)].floatVal);
            (yyval.st).a = new_leaf_num((yyvsp[(1) - (1)].floatVal));
            if((yyval.st).a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para asignar el real %f\n",linea, (yyval.st).real);
            }
            (yyval.st).tipo="real";
            printf( "-> REAL: %f\n", (yyval.st).real);;}
    break;

  case 45:

/* Line 1464 of yacc.c  */
#line 656 "gramatica.y"
    {(yyval.st).real = -(yyvsp[(2) - (2)].floatVal);
            (yyval.st).a = new_leaf_num(-(yyvsp[(2) - (2)].floatVal));
            if((yyval.st).a->registro==-1){
                error_compilacion++;
                printf("ERROR LINEA %d: No quedan registros disponibles para asignar el real %f\n",linea,  (yyval.st).real);
            }
            (yyval.st).tipo="real";
            printf( "-> REAL NEGATIVO: %f\n", (yyval.st).real);;}
    break;

  case 46:

/* Line 1464 of yacc.c  */
#line 664 "gramatica.y"
    {
            (yyval.st) = (yyvsp[(2) - (3)].st);
            printf("PARENTESIS\n");;}
    break;

  case 47:

/* Line 1464 of yacc.c  */
#line 667 "gramatica.y"
    {
            (yyval.st).texto = (yyvsp[(1) - (1)].stringVal);
            (yyval.st).tipo="texto";
            printf("Variable de tipo TEXTO: %s\n", (yyval.st).texto);;}
    break;



/* Line 1464 of yacc.c  */
#line 2324 "gramatica.tab.c"
      default: break;
    }
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now `shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*------------------------------------.
| yyerrlab -- here on detecting error |
`------------------------------------*/
yyerrlab:
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
      {
	YYSIZE_T yysize = yysyntax_error (0, yystate, yychar);
	if (yymsg_alloc < yysize && yymsg_alloc < YYSTACK_ALLOC_MAXIMUM)
	  {
	    YYSIZE_T yyalloc = 2 * yysize;
	    if (! (yysize <= yyalloc && yyalloc <= YYSTACK_ALLOC_MAXIMUM))
	      yyalloc = YYSTACK_ALLOC_MAXIMUM;
	    if (yymsg != yymsgbuf)
	      YYSTACK_FREE (yymsg);
	    yymsg = (char *) YYSTACK_ALLOC (yyalloc);
	    if (yymsg)
	      yymsg_alloc = yyalloc;
	    else
	      {
		yymsg = yymsgbuf;
		yymsg_alloc = sizeof yymsgbuf;
	      }
	  }

	if (0 < yysize && yysize <= yymsg_alloc)
	  {
	    (void) yysyntax_error (yymsg, yystate, yychar);
	    yyerror (yymsg);
	  }
	else
	  {
	    yyerror (YY_("syntax error"));
	    if (yysize != 0)
	      goto yyexhaustedlab;
	  }
      }
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
	 error, discard it.  */

      if (yychar <= YYEOF)
	{
	  /* Return failure if at end of input.  */
	  if (yychar == YYEOF)
	    YYABORT;
	}
      else
	{
	  yydestruct ("Error: discarding",
		      yytoken, &yylval);
	  yychar = YYEMPTY;
	}
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule which action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;	/* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (yyn != YYPACT_NINF)
	{
	  yyn += YYTERROR;
	  if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
	    {
	      yyn = yytable[yyn];
	      if (0 < yyn)
		break;
	    }
	}

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
	YYABORT;


      yydestruct ("Error: popping",
		  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  *++yyvsp = yylval;


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#if !defined(yyoverflow) || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEMPTY)
     yydestruct ("Cleanup: discarding lookahead",
		 yytoken, &yylval);
  /* Do not reclaim the symbols of the rule which action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
		  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  /* Make sure YYID is used.  */
  return YYID (yyresult);
}



/* Line 1684 of yacc.c  */
#line 673 "gramatica.y"


int main(int argc, char** argv) {
    if (argc < 2) {
        printf("Sin input. Introduce archivo input.\n");
        return 1;
    }
    yyin = fopen(argv[1], "rt");
    if (yyin == NULL) {
        printf("No se puedo leer el input.\n");
        return 1;
    }
    yyout = fopen( "./maquina.asm", "wt" );
	yyparse();
    fclose(yyin);
    return 0;
}

void yyerror(const char* s) {
    fprintf(stderr, "%s\n", s);
}

int yywrap() {
    return 1;
}
