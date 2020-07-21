#ifndef lint
static char yysccsid[] = "@(#)yaccpar	1.8 (Berkeley) 01/20/90";
#endif
#define YYBYACC 1
#line 2 "uncool.y"
import java.io.*;

/*  
All of the below productions that do not have associated 
actions are using the DEFAULT action -- $$ = $1 
*/

#line 14 "y.tab.c"
#define CLASS_T 257
#define INT_T 258
#define BOOL_T 259
#define STRING_T 260
#define IN_T 261
#define THEN_T 262
#define ELSE_T 263
#define FI_T 264
#define LOOP_T 265
#define POOL_T 266
#define NEW_T 267
#define SELF_T 268
#define ISVOID_T 269
#define LE 270
#define LT 271
#define GT 272
#define GE 273
#define NE 274
#define EQ 275
#define NOT_T 276
#define OUT_STRING 277
#define OUT_INT 278
#define IN_INT 279
#define TRUE_T 280
#define FALSE_T 281
#define IF_T 282
#define WHILE_T 283
#define INT_CONST 284
#define STRING_CONST 285
#define TYPE 286
#define ID 287
#define ASSIGN 288
#define UM 289
#define UC 290
#define YYERRCODE 256
short yylhs[] = {                                        -1,
    0,    0,    1,    2,    2,    3,    3,    3,    3,    3,
    3,    5,    5,    5,    5,    4,    4,    7,    8,    8,
    8,    8,    8,    8,    8,    8,    8,    8,    8,    8,
    8,    8,    8,    8,    8,    8,    8,    8,    8,    8,
    8,    8,    8,    8,    8,    8,    8,    8,    8,    8,
    8,    9,    9,    6,    6,
};
short yylen[] = {                                         2,
    2,    1,    5,    3,    0,    9,    8,    3,    5,    5,
    5,    1,    1,    1,    1,    3,    1,    3,    3,    6,
    5,    4,    5,    3,    5,    4,    6,    3,    4,    4,
    4,    1,    1,    4,    7,    5,    3,    3,    3,    3,
    2,    3,    3,    3,    3,    3,    3,    3,    1,    1,
    1,    3,    1,    3,    1,
};
short yydefred[] = {                                      0,
    0,    0,    2,    0,    1,    5,    0,    0,    3,    0,
    0,    0,    4,    0,    0,    0,   17,    0,   15,    0,
   12,    8,    0,    0,    0,    0,    0,    0,    0,   18,
   13,   14,    0,    0,   16,    9,   11,   10,    0,    0,
    0,   32,    0,    0,    0,   49,   50,    0,    0,   51,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,   41,    0,
    0,    7,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,   28,    0,
    0,    0,   24,    0,    0,    0,    0,   37,   48,    0,
    0,    0,    0,    0,    0,    0,    0,    0,   40,    6,
    0,   22,    0,   29,   30,   31,    0,    0,   26,    0,
    0,    0,   21,   23,    0,   36,    0,    0,   25,    0,
    0,    0,   27,   35,
};
short yydgoto[] = {                                       2,
    3,    7,   10,   16,   22,   55,   17,   56,   95,
};
short yysindex[] = {                                   -219,
 -247, -219,    0,  -69,    0,    0, -121,  -26,    0,   -3,
  -33, -238,    0,   10,   15,   -8,    0,  -90,    0, -228,
    0,    0, -186, -233,   16, -208, -204,  -12, -203,    0,
    0,    0,  -39, -233,    0,    0,    0,    0,   19,  -32,
 -229,    0,   43,   52,   55,    0,    0,   19,   19,    0,
  -40,   19,   19,   19,  -54,  169,   19,    7,   57, -268,
   19,   58,   51,  113,   19,  -38,   19, -187,    0,  -50,
    2,    0,   19,   19,   19,   19,   19,   19,   19,   19,
   19,   19,  -49,   19,  -17,   60,   61,   20,    0,   19,
   19,  169,    0,  169,   -7,  120,   63,    0,    0,  169,
  -27,  -27,  -27,  -27,  -27,  -27,   70,   70,    0,    0,
  126,    0,    8,    0,    0,    0,  139,  151,    0,   19,
 -183,    1,    0,    0,   19,    0,  169,   19,    0,   14,
  163,  169,    0,    0,
};
short yyrindex[] = {                                      0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,   -3,    0,   54,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
   45,    0,    0,    0,    0,  -48,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,  387,    0,   25,    0,    0,    0,    0,    0,  -47,
  404,  409,  414,  420,  425,  430,   85,  102,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
   66,    0,    0,    0,    0,    0,   26,    0,    0,    0,
    0,  437,    0,    0,
};
short yygindex[] = {                                      0,
  112,    0,    0,    0,    6,  -22,   89,  492,  -72,
};
#define YYTABLESIZE 703
short yytable[] = {                                      66,
   28,   54,   93,    9,   73,   68,   52,   15,   73,   73,
   55,   54,  113,   11,   82,   80,   86,   81,   87,   18,
   19,   20,   54,  112,   31,   19,   32,   52,   58,   33,
   70,   12,   25,  119,   83,   26,  120,    1,    4,   40,
   54,  129,   99,   82,   80,   52,   81,   21,  124,  130,
   67,  120,   21,    6,  133,   13,   59,  120,   54,   29,
  116,   82,   80,   52,   81,   53,   52,   23,   53,   52,
   72,   30,   24,   34,   98,  110,   55,   54,   14,   36,
   37,   38,   60,   39,   53,   33,   33,   33,   33,   33,
   57,   61,   82,   80,   62,   81,   85,   84,   89,   97,
  114,  115,  122,   33,  128,   53,   34,   34,   34,   34,
   34,   82,   14,    5,   35,    0,    0,    0,    0,    0,
    0,    0,    0,   53,   34,   38,    0,   38,   38,   38,
    0,    0,    0,    0,    0,    0,    0,   33,    0,    0,
    0,   53,   39,   38,   39,   39,   39,    0,    0,    0,
    0,    0,    0,    0,   82,   80,    0,   81,   34,    0,
   39,   82,   80,    0,   81,    8,    0,   82,   80,   33,
   81,    0,    0,    0,    0,    0,    0,   38,    0,    0,
   82,   80,    0,   81,    0,    0,    0,    0,    0,    0,
   34,    0,   82,   80,   39,   81,    0,   27,    0,    0,
    0,    0,    0,    0,   82,   80,    0,   81,    0,   38,
   82,   80,  121,   81,    0,    0,    0,    0,  123,    0,
    0,    0,    0,    0,    0,    0,   39,    0,   41,   42,
    0,    0,    0,    0,    0,    0,    0,    0,   43,   44,
   45,   46,   47,   48,   49,   50,    0,   65,   51,   41,
   42,    0,    0,   14,    0,    0,    0,    0,    0,   43,
   44,   45,   46,   47,   48,   49,   50,   41,   42,   51,
    0,   74,   75,   76,   77,   78,   79,   43,   44,   45,
   46,   47,   48,   49,   50,   41,   42,   51,    0,   74,
   75,   76,   77,   78,   79,   43,   44,   45,   46,   47,
   48,   49,   50,    0,    0,   51,   33,   33,   33,   33,
   33,    0,   90,    0,   33,   33,   33,   33,   33,   33,
   74,   75,   76,   77,   78,   79,    0,   34,   34,   34,
   34,   34,    0,    0,    0,   34,   34,   34,   34,   34,
   34,    0,    0,    0,    0,    0,   38,   38,   38,   38,
   38,    0,    0,    0,   38,   38,   38,   38,   38,   38,
    0,    0,    0,   39,   39,   39,   39,   39,    0,    0,
    0,   39,   39,   39,   39,   39,   39,   91,    0,    0,
    0,    0,   74,   75,   76,   77,   78,   79,    0,   74,
   75,   76,   77,   78,   79,   74,   75,   76,   77,   78,
   79,  125,    0,    0,    0,    0,    0,    0,   74,   75,
   76,   77,   78,   79,    0,    0,  126,    0,    0,    0,
   74,   75,   76,   77,   78,   79,  134,   19,    0,    0,
   19,    0,   74,   75,   76,   77,   78,   79,   74,   75,
   76,   77,   78,   79,   46,   19,    0,   46,    0,   45,
    0,    0,   45,    0,   43,    0,    0,   43,    0,    0,
   44,    0,   46,   44,    0,   42,    0,   45,   42,    0,
   47,    0,   43,   47,    0,    0,    0,   20,   44,   19,
   20,    0,    0,   42,    0,    0,    0,    0,   47,    0,
    0,    0,    0,    0,    0,   20,   46,    0,    0,    0,
    0,   45,    0,    0,    0,    0,   43,    0,    0,    0,
    0,   19,   44,    0,    0,    0,    0,   42,    0,    0,
    0,    0,   47,    0,    0,    0,    0,    0,   46,   20,
    0,    0,    0,   45,    0,    0,    0,    0,   43,   63,
   64,    0,    0,   69,   44,   71,    0,    0,    0,   42,
    0,    0,   88,    0,   47,    0,   92,   94,   96,    0,
    0,   20,    0,    0,  100,  101,  102,  103,  104,  105,
  106,  107,  108,  109,    0,  111,   94,    0,    0,    0,
    0,  117,  118,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,  127,    0,   94,    0,    0,  131,    0,    0,  132,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,   19,   19,
   19,   19,   19,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,   46,   46,   46,   46,   46,
   45,   45,   45,   45,   45,   43,   43,   43,   43,   43,
    0,   44,   44,   44,   44,   44,   42,   42,   42,   42,
   42,   47,   47,   47,   47,   47,    0,    0,   20,   20,
   20,   20,   20,
};
short yycheck[] = {                                      40,
   91,   40,   41,  125,   59,   46,   45,   41,   59,   59,
   59,   59,   85,   40,   42,   43,  285,   45,  287,  258,
  259,  260,   40,   41,  258,  259,  260,   45,  258,   24,
   53,   58,   41,   41,   57,   44,   44,  257,  286,   34,
   40,   41,   41,   42,   43,   45,   45,  286,   41,  122,
   91,   44,  286,  123,   41,   59,  286,   44,   40,  288,
   41,   42,   43,   45,   45,   41,   41,   58,   44,   44,
  125,  258,   58,   58,  125,  125,  125,  125,  287,  284,
   93,  285,   40,  123,  123,   41,   42,   43,   44,   45,
  123,   40,   42,   43,   40,   45,   40,   91,   41,  287,
   41,   41,   40,   59,  288,  123,   41,   42,   43,   44,
   45,   42,   59,    2,   26,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,  123,   59,   41,   -1,   43,   44,   45,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   93,   -1,   -1,
   -1,  123,   41,   59,   43,   44,   45,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   42,   43,   -1,   45,   93,   -1,
   59,   42,   43,   -1,   45,  287,   -1,   42,   43,  125,
   45,   -1,   -1,   -1,   -1,   -1,   -1,   93,   -1,   -1,
   42,   43,   -1,   45,   -1,   -1,   -1,   -1,   -1,   -1,
  125,   -1,   42,   43,   93,   45,   -1,  288,   -1,   -1,
   -1,   -1,   -1,   -1,   42,   43,   -1,   45,   -1,  125,
   42,   43,   93,   45,   -1,   -1,   -1,   -1,   93,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,  125,   -1,  267,  268,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  277,  278,
  279,  280,  281,  282,  283,  284,   -1,  288,  287,  267,
  268,   -1,   -1,  287,   -1,   -1,   -1,   -1,   -1,  277,
  278,  279,  280,  281,  282,  283,  284,  267,  268,  287,
   -1,  270,  271,  272,  273,  274,  275,  277,  278,  279,
  280,  281,  282,  283,  284,  267,  268,  287,   -1,  270,
  271,  272,  273,  274,  275,  277,  278,  279,  280,  281,
  282,  283,  284,   -1,   -1,  287,  262,  263,  264,  265,
  266,   -1,  262,   -1,  270,  271,  272,  273,  274,  275,
  270,  271,  272,  273,  274,  275,   -1,  262,  263,  264,
  265,  266,   -1,   -1,   -1,  270,  271,  272,  273,  274,
  275,   -1,   -1,   -1,   -1,   -1,  262,  263,  264,  265,
  266,   -1,   -1,   -1,  270,  271,  272,  273,  274,  275,
   -1,   -1,   -1,  262,  263,  264,  265,  266,   -1,   -1,
   -1,  270,  271,  272,  273,  274,  275,  265,   -1,   -1,
   -1,   -1,  270,  271,  272,  273,  274,  275,   -1,  270,
  271,  272,  273,  274,  275,  270,  271,  272,  273,  274,
  275,  263,   -1,   -1,   -1,   -1,   -1,   -1,  270,  271,
  272,  273,  274,  275,   -1,   -1,  266,   -1,   -1,   -1,
  270,  271,  272,  273,  274,  275,  264,   41,   -1,   -1,
   44,   -1,  270,  271,  272,  273,  274,  275,  270,  271,
  272,  273,  274,  275,   41,   59,   -1,   44,   -1,   41,
   -1,   -1,   44,   -1,   41,   -1,   -1,   44,   -1,   -1,
   41,   -1,   59,   44,   -1,   41,   -1,   59,   44,   -1,
   41,   -1,   59,   44,   -1,   -1,   -1,   41,   59,   93,
   44,   -1,   -1,   59,   -1,   -1,   -1,   -1,   59,   -1,
   -1,   -1,   -1,   -1,   -1,   59,   93,   -1,   -1,   -1,
   -1,   93,   -1,   -1,   -1,   -1,   93,   -1,   -1,   -1,
   -1,  125,   93,   -1,   -1,   -1,   -1,   93,   -1,   -1,
   -1,   -1,   93,   -1,   -1,   -1,   -1,   -1,  125,   93,
   -1,   -1,   -1,  125,   -1,   -1,   -1,   -1,  125,   48,
   49,   -1,   -1,   52,  125,   54,   -1,   -1,   -1,  125,
   -1,   -1,   61,   -1,  125,   -1,   65,   66,   67,   -1,
   -1,  125,   -1,   -1,   73,   74,   75,   76,   77,   78,
   79,   80,   81,   82,   -1,   84,   85,   -1,   -1,   -1,
   -1,   90,   91,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,  120,   -1,  122,   -1,   -1,  125,   -1,   -1,  128,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  262,  263,
  264,  265,  266,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,  262,  263,  264,  265,  266,
  262,  263,  264,  265,  266,  262,  263,  264,  265,  266,
   -1,  262,  263,  264,  265,  266,  262,  263,  264,  265,
  266,  262,  263,  264,  265,  266,   -1,   -1,  262,  263,
  264,  265,  266,
};
#define YYFINAL 2
#ifndef YYDEBUG
#define YYDEBUG 0
#endif
#define YYMAXTOKEN 290
#if YYDEBUG
char *yyname[] = {
"end-of-file",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,"'('","')'","'*'","'+'","','","'-'","'.'",0,0,0,0,0,0,0,0,0,0,0,
"':'","';'",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"'['",
0,"']'",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"'{'",0,"'}'",
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,"CLASS_T","INT_T","BOOL_T","STRING_T","IN_T","THEN_T",
"ELSE_T","FI_T","LOOP_T","POOL_T","NEW_T","SELF_T","ISVOID_T","LE","LT","GT",
"GE","NE","EQ","NOT_T","OUT_STRING","OUT_INT","IN_INT","TRUE_T","FALSE_T",
"IF_T","WHILE_T","INT_CONST","STRING_CONST","TYPE","ID","ASSIGN","UM","UC",
};
char *yyrule[] = {
"$accept : program",
"program : program class",
"program : class",
"class : CLASS_T TYPE '{' feature_list '}'",
"feature_list : feature_list feature ';'",
"feature_list :",
"feature : ID '(' formal_list ')' ':' type '{' expr_list '}'",
"feature : ID '(' ')' ':' type '{' expr_list '}'",
"feature : ID ':' type",
"feature : ID ':' INT_T ASSIGN INT_CONST",
"feature : ID ':' STRING_T ASSIGN STRING_CONST",
"feature : ID ':' INT_T '[' ']'",
"type : TYPE",
"type : INT_T",
"type : STRING_T",
"type : BOOL_T",
"formal_list : formal_list ',' formal",
"formal_list : formal",
"formal : ID ':' INT_T",
"expr : ID ASSIGN expr",
"expr : ID '[' expr ']' ASSIGN expr",
"expr : NEW_T INT_T '[' expr ']'",
"expr : NEW_T TYPE '(' ')'",
"expr : NEW_T TYPE '(' actual_list ')'",
"expr : ID '(' ')'",
"expr : ID '.' ID '(' ')'",
"expr : ID '(' actual_list ')'",
"expr : ID '.' ID '(' actual_list ')'",
"expr : IN_INT '(' ')'",
"expr : OUT_STRING '(' STRING_CONST ')'",
"expr : OUT_STRING '(' ID ')'",
"expr : OUT_INT '(' expr ')'",
"expr : SELF_T",
"expr : ID",
"expr : ID '[' expr ']'",
"expr : IF_T expr THEN_T expr ELSE_T expr FI_T",
"expr : WHILE_T expr LOOP_T expr POOL_T",
"expr : '{' expr_list '}'",
"expr : expr '+' expr",
"expr : expr '-' expr",
"expr : expr '*' expr",
"expr : '-' expr",
"expr : expr NE expr",
"expr : expr GT expr",
"expr : expr GE expr",
"expr : expr LT expr",
"expr : expr LE expr",
"expr : expr EQ expr",
"expr : '(' expr ')'",
"expr : TRUE_T",
"expr : FALSE_T",
"expr : INT_CONST",
"actual_list : actual_list ',' expr",
"actual_list : expr",
"expr_list : expr_list ';' expr",
"expr_list : expr",
};
#endif
#define yyclearin (yychar=(-1))
#define yyerrok (yyerrflag=0)
#ifdef YYSTACKSIZE
#ifndef YYMAXDEPTH
#define YYMAXDEPTH YYSTACKSIZE
#endif
#else
#ifdef YYMAXDEPTH
#define YYSTACKSIZE YYMAXDEPTH
#else
#define YYSTACKSIZE 500
#define YYMAXDEPTH 500
#endif
#endif
int yydebug;
int yynerrs;
int yyerrflag;
int yychar;
short *yyssp;
YYSTYPE *yyvsp;
YYSTYPE yyval;
YYSTYPE yylval;
short yyss[YYSTACKSIZE];
YYSTYPE yyvs[YYSTACKSIZE];
#define yystacksize YYSTACKSIZE
#line 148 "uncool.y"

/* Byacc/J expects a member method int yylex(). We need to provide one
   through this mechanism. See the jflex manual for more information. */

	/* reference to the lexer object */
	private scanner lexer;

	/* interface to the lexer */
	private int yylex() {
		int retVal = -1;
		try {
			retVal = lexer.yylex();
		} catch (IOException e) {
			System.err.println("IO Error:" + e);
		}
		return retVal;
	}
	
	/* error reporting */
	public void yyerror (String error) {
		System.err.println("Error : " + error + " at line " + lexer.getLine());
	}

	/* constructor taking in File Input */
	public Parser (Reader r) {
		lexer = new scanner (r, this);
	}

	public static void main (String [] args) throws IOException {
		Parser yyparser = new Parser(new FileReader(args[0]));
		yyparser.yyparse();
	}


#line 405 "y.tab.c"
#define YYABORT goto yyabort
#define YYACCEPT goto yyaccept
#define YYERROR goto yyerrlab
int
yyparse()
{
    register int yym, yyn, yystate;
#if YYDEBUG
    register char *yys;
    extern char *getenv();

    if (yys = getenv("YYDEBUG"))
    {
        yyn = *yys;
        if (yyn >= '0' && yyn <= '9')
            yydebug = yyn - '0';
    }
#endif

    yynerrs = 0;
    yyerrflag = 0;
    yychar = (-1);

    yyssp = yyss;
    yyvsp = yyvs;
    *yyssp = yystate = 0;

yyloop:
    if (yyn = yydefred[yystate]) goto yyreduce;
    if (yychar < 0)
    {
        if ((yychar = yylex()) < 0) yychar = 0;
#if YYDEBUG
        if (yydebug)
        {
            yys = 0;
            if (yychar <= YYMAXTOKEN) yys = yyname[yychar];
            if (!yys) yys = "illegal-symbol";
            printf("yydebug: state %d, reading %d (%s)\n", yystate,
                    yychar, yys);
        }
#endif
    }
    if ((yyn = yysindex[yystate]) && (yyn += yychar) >= 0 &&
            yyn <= YYTABLESIZE && yycheck[yyn] == yychar)
    {
#if YYDEBUG
        if (yydebug)
            printf("yydebug: state %d, shifting to state %d (%s)\n",
                    yystate, yytable[yyn],yyrule[yyn]);
#endif
        if (yyssp >= yyss + yystacksize - 1)
        {
            goto yyoverflow;
        }
        *++yyssp = yystate = yytable[yyn];
        *++yyvsp = yylval;
        yychar = (-1);
        if (yyerrflag > 0)  --yyerrflag;
        goto yyloop;
    }
    if ((yyn = yyrindex[yystate]) && (yyn += yychar) >= 0 &&
            yyn <= YYTABLESIZE && yycheck[yyn] == yychar)
    {
        yyn = yytable[yyn];
        goto yyreduce;
    }
    if (yyerrflag) goto yyinrecovery;
#ifdef lint
    goto yynewerror;
#endif
yynewerror:
    yyerror("syntax error");
#ifdef lint
    goto yyerrlab;
#endif
yyerrlab:
    ++yynerrs;
yyinrecovery:
    if (yyerrflag < 3)
    {
        yyerrflag = 3;
        for (;;)
        {
            if ((yyn = yysindex[*yyssp]) && (yyn += YYERRCODE) >= 0 &&
                    yyn <= YYTABLESIZE && yycheck[yyn] == YYERRCODE)
            {
#if YYDEBUG
                if (yydebug)
                    printf("yydebug: state %d, error recovery shifting\
 to state %d\n", *yyssp, yytable[yyn]);
#endif
                if (yyssp >= yyss + yystacksize - 1)
                {
                    goto yyoverflow;
                }
                *++yyssp = yystate = yytable[yyn];
                *++yyvsp = yylval;
                goto yyloop;
            }
            else
            {
#if YYDEBUG
                if (yydebug)
                    printf("yydebug: error recovery discarding state %d\n",
                            *yyssp);
#endif
                if (yyssp <= yyss) goto yyabort;
                --yyssp;
                --yyvsp;
            }
        }
    }
    else
    {
        if (yychar == 0) goto yyabort;
#if YYDEBUG
        if (yydebug)
        {
            yys = 0;
            if (yychar <= YYMAXTOKEN) yys = yyname[yychar];
            if (!yys) yys = "illegal-symbol";
            printf("yydebug: state %d, error recovery discards token %d (%s)\n",
                    yystate, yychar, yys);
        }
#endif
        yychar = (-1);
        goto yyloop;
    }
yyreduce:
#if YYDEBUG
    if (yydebug)
        printf("yydebug: state %d, reducing by rule %d (%s)\n",
                yystate, yyn, yyrule[yyn]);
#endif
    yym = yylen[yyn];
    yyval = yyvsp[1-yym];
    switch (yyn)
    {
    }
    yyssp -= yym;
    yystate = *yyssp;
    yyvsp -= yym;
    yym = yylhs[yyn];
    if (yystate == 0 && yym == 0)
    {
#if YYDEBUG
        if (yydebug)
            printf("yydebug: after reduction, shifting from state 0 to\
 state %d\n", YYFINAL);
#endif
        yystate = YYFINAL;
        *++yyssp = YYFINAL;
        *++yyvsp = yyval;
        if (yychar < 0)
        {
            if ((yychar = yylex()) < 0) yychar = 0;
#if YYDEBUG
            if (yydebug)
            {
                yys = 0;
                if (yychar <= YYMAXTOKEN) yys = yyname[yychar];
                if (!yys) yys = "illegal-symbol";
                printf("yydebug: state %d, reading %d (%s)\n",
                        YYFINAL, yychar, yys);
            }
#endif
        }
        if (yychar == 0) goto yyaccept;
        goto yyloop;
    }
    if ((yyn = yygindex[yym]) && (yyn += yystate) >= 0 &&
            yyn <= YYTABLESIZE && yycheck[yyn] == yystate)
        yystate = yytable[yyn];
    else
        yystate = yydgoto[yym];
#if YYDEBUG
    if (yydebug)
        printf("yydebug: after reduction, shifting from state %d \
to state %d\n", *yyssp, yystate);
#endif
    if (yyssp >= yyss + yystacksize - 1)
    {
        goto yyoverflow;
    }
    *++yyssp = yystate;
    *++yyvsp = yyval;
    goto yyloop;
yyoverflow:
    yyerror("yacc stack overflow");
yyabort:
    return (1);
yyaccept:
    return (0);
}
