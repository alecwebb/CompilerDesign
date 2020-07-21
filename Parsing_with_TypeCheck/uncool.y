%{
import java.io.*;
import java.util.*;
import java.util.Stack;
import java.util.Hashtable;

/*  
All of the below productions that do not have associated 
actions are using the DEFAULT action -- $$ = $1 
*/

%}

%token CLASS_T INT_T BOOL_T STRING_T IN_T 
%token THEN_T ELSE_T FI_T LOOP_T POOL_T
%token LET_T TEL_T NEW_T SELF_T ISVOID_T LE LT GT GE NE EQ NOT_T
%token OUT_STRING OUT_INT IN_INT
%token TRUE_T FALSE_T IF_T WHILE_T 
%token INT_CONST 
%token STRING_CONST
%token TYPE
%token <sval> ID TYPE
%token ASSIGN

%type <obj> program class feature_list feature formal_list formal actual_list expr_list expr
%type <sval> INT_CONST STRING_CONST type simple_constant SELF_T

%right ASSIGN
%nonassoc GE GT NE LT LE EQ
%right UM
%left '+' '-'
%left '*'
%right UC

%%

program		:	program 				
			class					
		|						{ symClass.enterScope(); }  //this keeps the class sym table open
			class					
		;

class		:	CLASS_T TYPE '{' 			{ 
								  CLASSNAME = $2; 
								  if( isMain() ){ 
									sym.enterScope(); 
								  } else {
									symClass.checkLastClass(); 
									symClass.insert($2,$2);
								  };
								} 
			feature_list '}'			{ 
								  if( isMain() ){ sym.checkMain(); sym.exitScope(); } 
								  CLASSNAME = null; 
								} 
		;

feature_list	:	feature_list feature ';'		
		|
		;

feature		:	ID '('        				
								{ 
								  if( isMain() ) {
									sym.enterScope();
								  } else {
									symClass.enterScope();
								  }
								} 
			formal_list 
			')' ':' type 				{
								  if( isMain() ) {
									sym.insert($1,$7,Integer.toString(paramCounter));
								  } else {
									symClass.insert($1,$7,Integer.toString(paramCounter));
								  };
								}
			'{' expr_list  '}'			
								{ 
								  if( isMain() ) {
									sym.retType($1,returnT);
									sym.exitScope(); 
									sym.insert($1,$7,Integer.toString(paramCounter)); 
								  } else {
									symClass.retType($1,returnT); 
									symClass.exitScope(); 
									symClass.insert($1,$7,Integer.toString(paramCounter)); 
								  }; 
								  returnT=null; 
								  paramCounter = 0;
								} 

		|	ID '(' ')' ':' type 			{ 
								  if( isMain() ) { 
									sym.enterScope(); 
									sym.insert($1,$5); 
								  } else { 
									symClass.enterScope(); 
									symClass.insert($1,$5);
								  }; 
								}
			'{' expr_list  '}'			{ 
								  if( isMain() ) {
									sym.retType($1,returnT); 
									sym.exitScope(); 
									sym.insert($1,$5);
								  } else {
									symClass.retType($1,returnT);
									symClass.exitScope(); 
									symClass.insert($1,$5);
								  };
								}

 		| 	ID ':' type				{ 
								  if( isMain() ) { 
									sym.insert($1,$3); 
									sym.checkClassType($3); 
								  } else { 
									symClass.insert($1,$3); 
									symClass.checkClassType($3);
								  };
								}

		|	ID ':' type ASSIGN simple_constant	{ 
								  if( isMain() ) { 
									sym.matchInitType($1,$3,$5,1); 
									sym.checkClassType($3);
									sym.insert($1, $3); 
								  } else {
									symClass.matchInitType($1,$3,$5,1); 
									symClass.checkClassType($3);
									symClass.insert($1, $3); 
								  }; 
								}

 		| 	ID ':' type ASSIGN STRING_CONST 	{ 
								  if( isMain() ) { 
									sym.matchInitType($1,$3,STR,1);
									sym.checkClassType($3); 
									sym.insert($1, STR);
								  } else {
									symClass.matchInitType($1,$3,STR,1); 
									symClass.checkClassType($3);
									symClass.insert($1, STR);
								  };
								}

 	 	| 	ID ':' INT_T '[' ']'  			{ 
								  if( isMain() ) { 
									sym.insert($1, ARR); 
								  } else { 
									symClass.insert($1, ARR); 
								  }; 
								}

		;

type		:	TYPE					{$$ = $1;  	}
		|	INT_T					{$$ = INT; 	}
		|	STRING_T				{$$ = STR;	}
		|	BOOL_T					{$$ = BOOL;	}
		;

simple_constant :	TRUE_T					{$$ = "True"; 	}
		|	FALSE_T					{$$ = "False";	}
		| 	INT_CONST				{$$ = $1;     	}
		;

formal_list	:	formal_list ',' formal			{ if(letFlag == 0) {paramCounter++; }}
		|	formal					{ if(letFlag == 0) {paramCounter++; }}
		;

formal		:	ID ':' type 				{ if( isMain() ) {
									sym.insert($1, $3);
 									sym.checkClassType($3);
								  } else {
									symClass.insert($1, $3);
								  }; 
								}
		;

expr		:	ID ASSIGN  expr				{ $$ = $3; 
								  if( isMain() ) {
									sym.checkAssignment($1, $3);
								  } else {
									symClass.checkAssignment($1, $3);
								  }; 
								}

 	 	|  	ID '[' expr ']'  ASSIGN  expr 		{ $$ = $6; 
								  if( isMain() ) {
									sym.checkArrAssignment($1,sym.checkArr($1,$3), $6);
								  } else {
									symClass.checkArrAssignment($1, symClass.checkArr($1,$3), $6);
								  }; 
								}

                |       NEW_T INT_T '[' expr ']'		{ $$ = ARR;  
								  if( isMain() ) {
									sym.checkPtr($4);
								  } else {
									symClass.checkPtr($4);
								  }
								}

                |       NEW_T TYPE '(' ')'			{$$ = $2; sym.checkClassType($2);}

                |       NEW_T TYPE '(' actual_list ')'		{$$ = $2; sym.checkClassType($2);}

 		| 	ID '(' ')'				{ if( isMain() ) { 
									$$ = sym.checkFunction($1);
									sym.checkArgs($1,paramCounterInUse);  
									sym.idExists($1);
								  } else {
									$$ = symClass.checkFunction($1);
									symClass.checkArgs($1,paramCounterInUse);  
									symClass.idExists($1);
								  };
								}

 		| 	ID '.'ID '(' ')'			{
								  $$ = symClass.checkFunction($3); 
								  symClass.checkArgs($3,paramCounterInUse); 
								  paramCounterInUse = 0; 
								  symClass.idExists($3); 
								}

 		| 	ID '(' actual_list ')'			{ if( isMain() ) {
									$$ = sym.checkFunction($1); 
									sym.checkArgs($1,paramCounterInUse); 
									paramCounterInUse = 0; 
									sym.idExists($1); 
								  } else {
									$$ = symClass.checkFunction($1); 
									symClass.checkArgs($1,paramCounterInUse); 
									paramCounterInUse = 0; 
									symClass.idExists($1); 
								  };
								}

 		| 	ID '.' ID '(' actual_list ')'		{
								  $$ = symClass.checkFunction($3); 
								  symClass.checkArgs($3,paramCounterInUse); 
								  paramCounterInUse = 0;
								  symClass.idExists($3);
								}

		|	IN_INT '(' ')'				{$$ = INT;}
 
		|	OUT_STRING '(' STRING_CONST ')'		//grammar handles this

		|	OUT_STRING '(' ID ')'			{	    if( isMain() ) {sym.checkOutString($3);   	} else {symClass.checkOutString($3);};	}

		|	OUT_INT '(' expr ')'			{$$ = INT;  if( isMain() ) {sym.checkOutInt($3);	} else {symClass.checkOutInt($3);};	}

		|	SELF_T					{$$ = CLASSNAME; }

		|	ID					{$$ = $1;   if( isMain() ) {sym.idExists($1);	     	} else {symClass.idExists($1);};	}

		|	ID '[' expr ']'				{	    if( isMain() ) {$$ = sym.checkArr($1, $3); 	} else {$$ = symClass.checkArr($1, $3); };}

 		| 	IF_T expr THEN_T expr ELSE_T expr FI_T  {$$ = $4;   if( isMain() ) {sym.checkIf($2, $4, $6);   	} else {symClass.checkIf($2, $4, $6);};	}

 		| 	WHILE_T expr  LOOP_T expr POOL_T        {$$ = $4;   if( isMain() ) {sym.checkWhile($2);	     	} else {symClass.checkWhile($2);};	}

 		| 	'{' expr_list '}'			{$$ = $2; }

		|	LET_T 					{	    if( isMain() ) {sym.enterScope();			} else {symClass.enterScope();}; letFlag = 1;} 
			formal_list IN_T expr TEL_T		{$$ = $5;   if( isMain() ) {sym.exitScope();			} else {symClass.exitScope();};  letFlag = 0;} 		

 		| 	expr  '+' expr				{$$ = INT;  if( isMain() ) {sym.checkIntOperands($1, $3, "+");	} else {symClass.checkIntOperands($1, $3, "+");};}

 		| 	expr  '-' expr				{$$ = INT;  if( isMain() ) {sym.checkIntOperands($1, $3, "-");	} else {symClass.checkIntOperands($1, $3, "-");};}

 		| 	expr  '*' expr				{$$ = INT;  if( isMain() ) {sym.checkIntOperands($1, $3, "*");	} else {symClass.checkIntOperands($1, $3, "*");};}

 		| 	'-' expr  %prec UC			{$$ = $2;   if( isMain() ) {sym.checkUniminus($2);		} else {symClass.checkUniminus($2);};}

 		| 	expr NE expr				{$$ = BOOL; if( isMain() ) {sym.checkOperands($1, $3);		} else {symClass.checkOperands($1, $3);};}

 		| 	expr GT expr				{$$ = BOOL; if( isMain() ) {sym.checkIntOperands($1, $3,">");	} else {symClass.checkIntOperands($1, $3,">");};}

 		| 	expr GE expr				{$$ = BOOL; if( isMain() ) {sym.checkIntOperands($1, $3,">=");	} else {symClass.checkIntOperands($1, $3,">=");};}

 		| 	expr LT expr				{$$ = BOOL; if( isMain() ) {sym.checkIntOperands($1, $3,"<");	} else {symClass.checkIntOperands($1, $3,"<");};}

 		| 	expr LE expr				{$$ = BOOL; if( isMain() ) {sym.checkIntOperands($1, $3,"<=");	} else {symClass.checkIntOperands($1, $3,"<=");};}

 		| 	expr EQ expr				{$$ = BOOL; if( isMain() ) {sym.checkOperands($1, $3);		} else {symClass.checkOperands($1, $3);};}

		|	'(' expr ')'				{$$ = $2;	}

 		|	TRUE_T 					{$$ = "True";	}

 		|	FALSE_T 				{$$ = "False";	}

 		|	INT_CONST				{$$ = $1;	}	

		;

actual_list	:	actual_list ',' expr			{ paramCounterInUse++; }
		|	expr					{ paramCounterInUse++; }
		;

expr_list	:	expr_list ';' expr			{$$ = $3; if($3 != null){ returnT = $3; };}
		|	expr 					{$$ = $1; if($1 != null){ returnT = $1; };}
		;


%%

	class SymbolTable {
		private Stack stk;
		public SymbolTable() {
			stk = new Stack();
		}
		public void enterScope() {
			stk.push(new Hashtable());
		}
		public void exitScope() {
			if( stk.empty() ) {
				throw new java.lang.RuntimeException("exitscope: empty table");
			}
			stk.pop();
		}
		public void insert(String id, String type) {
			List<String> tup = Arrays.asList(type, "0", (String)CLASSNAME); 
			if( stk.empty() ) {
				throw new java.lang.RuntimeException("insert: can't insert without a scope");
			}
			if(!checkForID(id)) {
				((Hashtable)stk.peek()).put(id, tup);
			}		
		}
		public void insert(String id, String type, String numParams) {
			List<String> tup = Arrays.asList(type, numParams, (String)CLASSNAME); 
			if( stk.empty() ) {
				throw new java.lang.RuntimeException("insert: can't insert without a scope");
			}
			if(!checkForID(id)) {
				((Hashtable)stk.peek()).put(id, tup);
			}		
		}
		public Object lookup(String id) {
			if( stk.empty() ) {
				throw new java.lang.RuntimeException("lookup: no scope");
			}
			for(int i = stk.size() -1; i >= 0; i--) {
				Object info = ((Hashtable)stk.elementAt(i)).get(id);
				if(info != null) return info;
			}			
			return null;
		}

		public Object inspect(String id) {
			if( stk.empty() ) {
				throw new java.lang.RuntimeException("inspect: no scope");
			}
			return ((Hashtable)stk.peek()).get(id);
		}
		public Boolean isMain() {
			if (((String)CLASSNAME).equals("Main")){
				mainEncountered = true;
			}
			return ((String)CLASSNAME).equals("Main");
		}
		public void checkMain(){
			Integer line;
			line = lexer.getLine();
			Object m = null;
			m = lookup("main");
			if(m == null){
				System.out.printf("ERROR: Line(%d) -- Class Main must contain method main\n", line);
			}
		}
		public void checkLastClass() {
			Integer line;
			line = lexer.getLine();
			if(mainEncountered == true){
				System.out.printf("ERROR: Line(%d) -- Class: %s cannot come after Class: Main\n", line, CLASSNAME);
			}
		}
		public Boolean checkForID(String id){
			Integer line;
			line = lexer.getLine();
			Object p = inspect(id);
			if(p != null){ 
				Object fetchClass = ((List<String>)p).get(2);
				if( ((String)fetchClass).equals( (String)CLASSNAME ) ) {
					System.out.printf("ERROR: Line(%d) -- Duplicate Definition for: %s\n", line, id);
					return true;
				} else { 
					return false;
				}
			} else {
				return false;
			}
		}
		public void idExists(String id) {
			Integer line;
			line = lexer.getLine();
			if(lookup(id) == null) {
				System.out.printf("ERROR: Line(%d) -- Unknown Identifier: %s\n", line, id);
			}
		}
		public void checkPtr(Object expr) {
			Integer line;
			line = lexer.getLine();
			Object t = null;
			String x = null;
			x = (String)expr;
			t = lookup(x);
			if(t != null) {
				Object fetch = ((List<String>)t).get(0);
				String s = null;
				s = (String)fetch;
				if(s.matches("-?\\d+") || s.equals(INT)){
				} else {
					System.out.printf("ERROR: Line(%d) -- new Int[expr] expr must be of [type: Int] [Encountered: %s]: \n", line, s);
				}
			} else if(x.matches("-?\\d+") || x.equals(INT)) {
				//grammar wont allow this
			} else {

			}
		}
		public void matchInitType(String id, String t1, String t2, Integer trigger) { //initialization
			Integer line;
			line = lexer.getLine();
			String type;
			if ( t2.equals("True") || t2.equals("False") || t2.equals("Bool") ) {
				type = BOOL;
			} else if (t2.matches("-?\\d+") || t2.equals(INT) ) {
				type = INT;
			} else if ( (t1.equals(ARR) && t2.equals(INTC)) || (t1.equals(INT) && t2.equals(INTC)) ){
				return;
			} else if ( t2.equals(ARR) ) {
				type = ARR;
			} else if ( t2.equals(t1)) {
				type = t1;
			} else if (t2.equals(STR)){
				type = STR;
			} else {
				type = t2;
			}
			if (!t1.equals(type) ) {
				switch (trigger) { 
        				case 1: 
            					System.out.printf("ERROR: Line(%d) -- Bad Initialization: [Symbol %s of type: %s] cannot initialize to [type: %s]\n", line, id, t1, type); 
            					break; 
        				case 2: 
            					System.out.printf("ERROR: Line(%d) -- Bad Assignment: [Symbol %s of type: %s] cannot have assignment of [type: %s]\n", line, id, t1, type); 
            					break; 
        				case 3: 
            					System.out.printf("ERROR: Line(%d) -- Bad Operand ('<>' OR '='): LHS and RHS must be same Type [Symbol %s of type: %s] cannot interact with [type: %s]\n", line, id, t1, type); 
            					break; 
        				case 4: //outstring
            					System.out.printf("ERROR: Line(%d) -- Parameter Type Mismatch: function out_string [Expected Type: %s] Encountered: [Symbol %s of type: %s]\n", line, type, id, t1); 
            					break; 
        				case 5: //outint
            					System.out.printf("ERROR: Line(%d) -- Parameter Type Mismatch: function out_int [Expected Type: %s] Encountered: [Symbol %s of type: %s]\n", line, type, id, t1); 
            					break; 
        				case 6: //iff
            					System.out.printf("ERROR: Line(%d) -- IF Statement Branch Type Mismatch: Branch1[Type: %s] Branch2[type: %s]\n", line, type, t1); 
            					break; 
        				case 7: //ret
            					System.out.printf("ERROR: Line(%d) -- Return Type Mismatch: Expected[Type: %s] Actual[type: %s]\n", line, t1, type); 
            					break; 
        				default:  
            					break; 
        			} 

			}
		}
		public void checkClassType(Object t) {
			Integer line;
			line = lexer.getLine();
			Object t1; 
			t1 = symClass.lookup((String)t);
			if(t1 == null) {
				String tname = (String)t;
				if(tname.equals(STR) || tname.equals(INT) || tname.equals(BOOL) || tname.equals(ARR)){
				} else {
					System.out.printf("ERROR: Line(%d) -- Unknown [Type:%s]\n", line, tname); 
				}
			}
		}
		public void checkAssignment(String id, Object a) {
			Object t1;
			Object t2 = null;
			t1 = lookup(id);
			String x = (String)a;
			if (x != null ) { t2 = lookup(x); }
			if( id != null && t1 != null && t2 != null){
				Object fetch = ((List<String>)t1).get(0);
				Object fetch2 = ((List<String>)t2).get(0);
				matchInitType(id, (String)fetch, (String)fetch2, 2);
			} else if( id != null && t1 != null && a != null){
				Object fetch = ((List<String>)t1).get(0);
				matchInitType(id, (String)fetch, (String)a, 2);
			}
		}
		public void checkArrAssignment(String id, String arrt, Object expr) {
			Object t1;
			Object t2 = null;
			t1 = lookup(id);
			String x = (String)expr;
			if (x != null ) { t2 = lookup(x); }
			if( id != null && t1 != null && t2 != null){
				Object fetch = ((List<String>)t1).get(0);
				Object fetch2 = ((List<String>)t2).get(0);
				matchInitType(id, arrt, (String)fetch2, 2);
			} else if( id != null && t1 != null && expr != null){
				Object fetch = ((List<String>)t1).get(0);
				matchInitType(id, arrt, (String)expr, 2);
			}
		}
		public String checkArr(Object id, Object expr){
			Integer line;
			line = lexer.getLine();
			Object t = null;
			t = lookup((String)id);
			Object t2 = null;
			t2 = lookup((String)expr);
			if(t != null && t2 != null){
				Object fetch = ((List<String>)t).get(0);
				Object fetch2 = ((List<String>)t2).get(0);
				if (fetch.equals(ARR) &&  fetch2.equals(INT) ) {
					return INT;
				} else if (!fetch.equals(ARR)) {
					System.out.printf("ERROR: Line(%d) -- [Symbol:%s of Type:%s is not an array]\n", line, (String)id, (String)fetch);
					return (String)id;
				} else {
					System.out.printf("ERROR: Line(%d) -- Cannot Dereference Array: %s using type: %s\n", line, (String)id, (String)fetch2);
					return (String)id;
				}

			} else if(t != null && t2 == null) {
				Object fetch = ((List<String>)t).get(0);
				String string2 = (String)expr;
				if (fetch.equals(ARR) && (string2.matches("-?\\d+") || string2.matches(INT)  )) {
					return INT;
				} else { return (String)id;}
			} else { return (String)id;}
		}
		public void checkOperands(Object a, Object b){
			Object t1;
			Object t2;
			String x = (String)a;
			String y = (String)b;
			t1 = lookup(x);
			t2 = lookup(y);
			if( t1 != null && t2 != null){ 
				Object fetch = ((List<String>)t1).get(0);
				Object fetch2 = ((List<String>)t2).get(0);
				matchInitType(x, (String)fetch, (String)fetch2, 3);
			} else if( t1 != null && t2 == null) { 
				Object fetch = ((List<String>)t1).get(0);
				matchInitType(x, (String)fetch, y, 3);
			} else if( t1 == null && t2 != null) {
				Object fetch2 = ((List<String>)t2).get(0);
				matchInitType(y, (String)fetch2, x, 3);
			} else { }
		}
		public Boolean bothSidesInt(String t, String t2){
			Boolean x;
			Boolean y;
			x = (t.matches("-?\\d+") || t.equals(INT) );
			y = (t2.matches("-?\\d+") || t2.equals(INT) );
			return (x&&y);
		}
		public String determineType(String t2){
			String type = null;
			if ( t2.equals("True") || t2.equals("False") || t2.equals("Bool") ) {
				type = BOOL;
			} else if (t2.matches("-?\\d+") || t2.equals(INT) ) {
				type = INT;
			} else if ( t2.equals(ARR) ) {
				type = ARR;
			} else {
				type = STR;
			}
			return type;
		}
		public void checkUniminus(Object a) {
			Integer line;
			line = lexer.getLine();
			Object t1;
			String x = (String)a;
			t1 = lookup(x);
			Boolean ops = true;
			String t = null;

			if(t1 != null){
				Object fetch = ((List<String>)t1).get(0);
				t = (String)fetch;
				ops = bothSidesInt(t,t);
			}
			if(!ops){
				System.out.printf("ERROR: Line(%d) -- Uniminus can only be applied to [type: Int] -- [Encountered: %s]\n",line, t);
			}
		}
		public void checkIntOperands(Object a, Object b, String symbol){
			Integer line;
			line = lexer.getLine();
			Object t1;
			Object t2;
			String x = (String)a;
			String y = (String)b;
			t1 = lookup(x);
			t2 = lookup(y);
			Boolean ops = true;
			String l = null;
			String r = null;
			if( t1 != null && t2 != null){
				Object fetch = ((List<String>)t1).get(0);
				Object fetch2 = ((List<String>)t2).get(0);
				ops = bothSidesInt((String)fetch, (String)fetch2);
				 l = (String)fetch;
				 r = (String)fetch2;
			} else if( t1 != null && t2 == null) {
				Object fetch = ((List<String>)t1).get(0);
				ops = bothSidesInt((String)fetch, y);
				 l = (String)fetch;
				 r = determineType(y);
			} else if( t1 == null && t2 != null) {
				Object fetch2 = ((List<String>)t2).get(0);
				ops = bothSidesInt((String)fetch2, x);
				 l = determineType(x);
				 r = (String)fetch2;
			} else { }
			if(!ops){
				System.out.printf("ERROR: Line(%d) -- Bad Operand, LHS and RHS must be Type Int -- [Encountered: %s %s %s]\n",line, l, symbol, r);
			}
		}

		public void checkOutString(String id) { 
			Object t1;
			t1 = lookup(id);
			if(t1 != null) {
				Object fetch = ((List<String>)t1).get(0);
				matchInitType(id, (String)fetch, STR, 4);
			}
		}
		public void checkOutInt(Object a) { 
			Object t1;
			String x = (String)a;
			t1 = lookup(x);
			if(t1 != null){
				Object fetch = ((List<String>)t1).get(0);
				if( ((String)fetch).equals(INT) ){
					matchInitType(x, (String)fetch, INT, 5);
				} else if( ((String)fetch).equals(ARR) ){
					matchInitType(x, (String)fetch, ARR, 5);
				} else {
					matchInitType(x, (String)fetch, INT, 5);
				}
			}
		}
		public String checkFunction(String id) {
			Object t1;
			t1 = lookup(id);
			if(t1 != null){
				Object fetch = ((List<String>)t1).get(0);
				return (String)fetch;
			} else {
				return "";
			}
		}
		public void checkArgs(String id, Integer paramCount) {
			Integer line;
			Object t1;
			t1 = lookup(id);
			line = lexer.getLine();
			if(t1 != null){
				Object fetch = ((List<String>)t1).get(1);
				if( Integer.parseInt((String)fetch) != paramCount) {
					System.out.printf("ERROR: Line(%d) -- # Parameter(s) [Function %s] [Expected: %s] [Actual: %d]\n", line, id, fetch, paramCount);
				}
			}
		}
		public void checkWhile(Object inv) {
			Integer line;
			Object t1 = null;
			String t;
			t = (String)inv;
			if( t != null) {
				t1 = lookup(t);
			}
			line = lexer.getLine();
			if( !(t.equals("True") || t.equals("False") || t.equals("Bool")) ) {
				if(t1 != null) {
					Object fetch = ((List<String>)t1).get(0);
					System.out.printf("ERROR: Line(%d) -- Predicate Type [Expected: %s] [Actual: %s]\n", line, BOOL, fetch);
				}
			}
		}
		public void checkIf(Object inv, Object a, Object b) {
			Object t1;
			Object t2;
			String x = (String)a;
			String y = (String)b;
			checkWhile(inv);
			if(a !=null && b != null) {
			t1 = lookup(x);
			t2 = lookup(y);
				if( t1 != null && t2 != null){ 
					Object fetch = ((List<String>)t1).get(0);
					Object fetch2 = ((List<String>)t2).get(0);
					matchInitType(x, (String)fetch, (String)fetch2, 6);
				} else if( t1 != null && t2 == null) {
					Object fetch = ((List<String>)t1).get(0);
					matchInitType(x, (String)fetch, y, 6);
				} else if( t1 == null && t2 != null) { 
					Object fetch2 = ((List<String>)t2).get(0);
					matchInitType(y, (String)fetch2, x, 6);
				} else { }
			}
		}
		public void retType(Object id, Object ret) {
			Object t1;
			Object t2;
			String x = (String)id;
			String y = (String)ret;
			if(id != null && ret != null){
			t1 = lookup(x);
			t2 = lookup(y);
				if( t1 != null && t2 != null){
					Object fetch = ((List<String>)t1).get(0);
					Object fetch2 = ((List<String>)t2).get(0);
					matchInitType(x, (String)fetch, (String)fetch2, 7);
				} else if( t1 != null && t2 == null) {
					Object fetch = ((List<String>)t1).get(0);
					matchInitType(x, (String)fetch, y, 7);
				} else if( t1 == null && t2 != null) {
					Object fetch2 = ((List<String>)t2).get(0);
					matchInitType(y, (String)fetch2, x, 7);
				} else { }
			}
		}
	}
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
	public SymbolTable sym = new SymbolTable();
	public SymbolTable symClass = new SymbolTable();
	public static String INT="Int";
	public static String STR="String";
	public static String BOOL="Bool";
	public static String ARR="Int[]";
	public static String INTC = "IntCompatible";
	public Integer scopeCounter = 0;
	public Integer paramCounter = 0;
	public Integer paramCounterInUse = 0;
	public Integer letFlag = 0;
	public Object returnT = null;
	public Object CLASSNAME = null;
	public Boolean mainEncountered = false;
	public Boolean isMain() {
		if (((String)CLASSNAME).equals("Main")){
			mainEncountered = true;
		}
		return ((String)CLASSNAME).equals("Main");
	}
	public static void main (String [] args) throws IOException {
		Parser yyparser = new Parser(new FileReader(args[0]));
		yyparser.yyparse();
	}
