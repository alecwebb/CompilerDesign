%{
#include <stdio.h>
#include <stdlib.h>
int state = 0;
int indentstate = 0;	//maintain indentation
int iffs = 0;		//maintain if statement indentation
int i;			//loop initialization
int add = 0;		//addition found
int sub = 0;		//subtraction found
int iff = 0;		//if statement found
int call = 0;		//for result assignments
int namecall = 0; 	//no result assignment
int ret = 0;		//return found

void
indent(int offset){
  for( i = 0; i < (offset); i++ ){ // HANDLE INDENTATION [3 spaces]
	printf("   ");
  }
}

%}
a	[Aa]
b	[Bb]
c	[Cc]
d	[Dd]
e	[Ee]
f	[Ff]
g	[Gg]
h	[Hh]
i	[Ii]
j	[Jj]
k	[Kk]
l	[Ll]
m	[Mm]
n	[Nn]
o	[Oo]
p	[Pp]
q	[Qq]
r	[Rr]
s	[Ss]
t	[Tt]
u	[Uu]
v	[Vv]
w	[Ww]
x	[Xx]
y	[Yy]
z	[Zz]
%%
"<"{f}{u}{n}{c}{t}{i}{o}{n}		{// ENCOUNTERED FUNCTION
					  state = 1; 
					  indentstate++;
					}
"<"{i}{f}				{// ENCOUNTERED IF
					  iff = 1; 
					  iffs++; 
					  indentstate++;
					}
"<"{a}{d}{d}				{// ENCOUNTERED ADDITION
					  add = 1; 
					  indentstate++;
					}
"<"{s}{u}{b}				{// ENCOUNTERED SUBTRACTION
					  sub = 1; 
					  indentstate++;
					}
"<call name"				{// ENCOUNTERED CALL W/ NO RESULT
					  call = 2; 
					  indentstate++; 
					  namecall=1;
					}
"<"{c}{a}{l}{l}				{// ENCOUNTERED CALL
					  call = 1; 
					  indentstate++;
					}
"<"{r}{e}{t}{u}{r}{n}			{// ENCOUNTERED RETURN
					  ret = 1; 
					  indentstate++;
					}
"<else/>"				{// ENCOUNTERED ELSE
					  indent( indentstate + iffs );
					  printf( "} else { \n" );
					}


"</"{f}{u}{n}{c}{t}{i}{o}{n}">"		{ //END OF FUNCTION
					  printf("}\n"); 
					  state = 0; 
					  indentstate = 0;
					  iffs = 0;		
					  add = 0;		
					  sub = 0;
					  iff = 0;
					  call = 0;
					  namecall = 0;
					  ret = 0;
					}

\"[^"]*\"				{
					//FUNCTION BLOCK
					  if ( state == 1 ) {  // function name
						indent( indentstate - 1 );
						indentstate--;
						yytext[yyleng-1] = 0;
						printf( "int %s(", yytext + 1 );
						state = 2;
					  } else if ( state == 2 ) {  // first param
						yytext[yyleng-1] = 0;
						printf( "int %s", yytext + 1 );
						state = 3;
					  } else if ( state == 3 ) {  // up to n params
						yytext[yyleng-1] = 0;
						printf( ", int %s", yytext + 1 );

					//IF STATEMENT BLOCK
					  } else if ( iff == 1 ) {
						indent( indentstate + iffs - 1 );
						yytext[yyleng-1] = 0;
						printf( "if (%s) { \n", yytext + 1 );

					//RETURN BLOCK
					  } else if ( ret == 1 ) {  
						indent( indentstate + iffs );
						yytext[yyleng-1] = 0;
						printf( "return %s", yytext + 1 );

					//ADDITION BLOCK
					  } else if (add == 1) {  //add step 1 assign var
						indent( indentstate + iffs );
						yytext[yyleng-1] = 0;
						printf( "%s = ", yytext + 1 ); 
						add = 2;
					  } else if ( add == 2 ) {  // first add arg
						yytext[yyleng-1] = 0;
						printf( "%s", yytext + 1 ); 
						add = 3;
					  } else if ( add == 3 ) {  // up to n add args
						yytext[yyleng-1] = 0;
						printf( " + %s", yytext + 1 );

					//SUBTRACTION BLOCK
					  } else if ( sub == 1 ) {  //sub step 1 assign var
						indent( indentstate + iffs );
						yytext[yyleng-1] = 0;
						printf( "%s = ", yytext + 1 ); 
						sub = 2;
					  } else if ( sub == 2 ) {  // first sub arg
						yytext[yyleng-1] = 0;
						printf( "%s", yytext + 1 ); 
						sub = 3;
					  } else if ( sub == 3 ) {  // up to n sub args
						yytext[yyleng-1] = 0;
						printf( " - %s", yytext+1 );
					  
					//CALL BLOCK
					  } else if ( call == 1 ) {  // has an assignment
						indent(indentstate + iffs);
						yytext[yyleng-1] = 0;
						printf( "%s = ", yytext + 1 ); 
						call = 2;
					  } else if (call == 2 ) {  // function name with bracket
						if( namecall == 1 ){
						  indent( indentstate + iffs );
						}
						yytext[yyleng-1] = 0;
						printf( "%s(", yytext + 1 ); call = 3;
					  } else if ( call == 3 ) {  // first call arg
						yytext[yyleng-1] = 0;
						printf("%s", yytext + 1 ); call = 4;
					  } else if ( call == 4 ) {  // up to n call arg
						yytext[yyleng-1] = 0;
						printf( ",%s", yytext + 1 );
					  }
					}


"</if>"					{ 
					  indent( indentstate + iffs );
					  printf( "}\n" );
					  iffs--; 
					}

"/>"					{ 
					  indentstate--;
					  if( call != 0 ) {
					    printf( ");\n" );
					    call = 0;
					    namecall = 0;
					  } else {
					    printf( ";\n" ); 
					    add = 0; 
					    ret = 0; 
					    sub = 0; 
					    call = 0;
					  }
					};


">"					{
					  if ( ( state==2 ) || ( state==3 ) ) { // FINISH FUNCTION
					    printf( ") {\n" );
					    state = 0;  
					  } else if ( iff != 0 ) {
					    iff = 0;
					    indentstate--;
					  }
					}

.	;
[\n]	;
%%

int
main() {
  printf("int a,b,c,d,e,f,g,h,i,j,k,l,m;\n");
  printf("int n,o,p,q,r,s,t,u,v,w,x,y,z;\n\n");
  yylex();
}
