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
%token ISVOID_T LE LT GT GE NE EQ NOT_T
%token OUT_STRING OUT_INT IN_INT
%token TRUE_T FALSE_T IF_T WHILE_T 
%token INT_CONST 
%token STRING_CONST
%token TYPE
%token <sval> ID
%token ASSIGN
%type <obj> program feature_list feature formal_list formal actual_list expr_list expr
%type <sval> INT_CONST STRING_CONST
%right ASSIGN
%nonassoc GE GT NE LT LE EQ
%right UM
%left '+' '-'
%left '*'
%right UC
%%

program		:	CLASS_T TYPE '{' 
												{start_file(); 
												 sym.enterScope(); //enter scope
												}
			feature_list '}'
												{ sym.exitScope(); //exit scope 
												}
		;

feature_list	:	feature_list feature ';'
		|
		;

feature		:	ID '('        
														{ sym.enterScope();//enter scope 
														  start_function($1);
														}
	 		formal_list ')' 							
	 		':' INT_T 
			'{' expr_list  '}'	
														{ end_function($9);
														  rm.flushRegisters();
														  sym.exitScope();//exit scope
														  paramCounter = 0;
														}

		|	ID '(' ')' ':' INT_T 
														{if ($1.equals("main")) start_main();
                         								 else start_function($1);
			 											 sym.enterScope();//enter scope
														}
			'{' expr_list  '}'	
														{if ($1.equals("main")) end_main();
                         								 else end_function($8);
                         								 rm.flushRegisters();
			 											 sym.exitScope();//exit scope
														}

 		| 	ID ':' INT_T 
														{ //add symbol table
														  global_int($1);
														  sym.insertLabel($1);
														}

 		| 	ID ':' INT_T ASSIGN INT_CONST 
														{ //add symbol table
														  global_int_assigned($1, $5);
														  sym.insertLabel($1);
														}

 		| 	ID ':' STRING_T ASSIGN STRING_CONST 
														{ //add symbol table
														  global_string_assigned($1, $5);
														  //sym.insertLabel($1);
														}

 	 	| 	ID ':' INT_T '[' INT_CONST  ']'  
														{ //add symbol table
														  global_array($1, $5);
														  //sym.insertLabel($1);
														}

		;

formal_list	:	formal_list ',' formal
		|	formal
		;

formal		:	ID ':' INT_T 
														{ //add symbol table
															System.out.printf("#Formal ID:%s\n", $1);
															Register regf = rm.getRegister();
															sym.insert($1, regf.toString(), Integer.toString(paramCounter + 1));
															paramCounter++;
														}
		;

expr		:	ID ASSIGN  expr							{
														  Object r = sym.lookup($1);
														  if(r != null) {
														  	Object fetch = ((List<String>)r).get(0);
															String s = null;
															s = (String)fetch;
														  	Register reg = strToReg(s);
														  	if( (reg.toString()).contains("rip") ){ //variables
														  			System.out.printf("\tmovq %s, %s\n", $3.toString(), reg.toString() );
														  			$$ = reg;

														  			rm.freeRegister((Register)$3);
														  	} else {
														  			$$ = reg;
														  			rm.freeRegister((Register)$3); //MAYBE ATTEMPTING REG REDUCTION
														  	}
														  }
														}

 	 	|  	ID '[' expr ']'  ASSIGN  expr 				{ assign_array($1,$3,$6); $$ = $6; 
 	 													  rm.freeRegister((Register)$6);//maybe
 	 													  rm.freeRegister((Register)$3);//maybe
 	 													}

 		| 	ID '(' ')'									{ call_func_no_params($1); 
 														  $$ = collect_return(rm.getRegister());
 														}

 		| 	ID '(' 										{ 
 														  isActualList = true; 
 														  save_reg(); 
 														} 
 			actual_list ')'								{ 
 														  call_func_with_params($1); 
										 				  isActualList = false; 
										 				  paramInUse = 0; 
										 				  load_reg();
										 				  $$ = collect_return(rm.getRegister());
										 				}	

		|	IN_INT '(' ')'								{ $$ = in_int_updated(); }

		|	OUT_STRING '(' STRING_CONST ')'				{ save_reg(); 
														  outString($3); 
														  load_reg(); 
														  $$ = Register.RAX;
														}

		|	OUT_STRING '(' ID ')'						{ save_reg(); 
														  outStringID($3); 
														  load_reg(); 
														  $$ = Register.RAX;
														} 

		|	OUT_INT '(' expr ')'						{ save_reg(); 
														  outInt($3); 	 
														  load_reg(); 
														  $$ = Register.RAX;
														}

		|	ID 											{ 
														  Object r = sym.lookup($1);
														  if(r != null) {
														  	Object fetch = ((List<String>)r).get(0);
															String s = null;
															s = (String)fetch;
														  	Register regx = strToReg(s);
														  	$$ = regx;
														  	Object paramId = ((List<String>)r).get(1);
														  	String paramIdString = (String)paramId;
														  	reload_params(paramIdString, regx);
														  	if( ($$.toString()).contains("rip") ){ //variables
 														 			Register reg = rm.getRegister();
														  			System.out.printf("\tmovq %s, %s\n", $$.toString(), reg.toString() );
														  			$$ = reg;
														  	}
														  }
														}

		|	ID '[' expr ']' 							{
														  String r = $1+"(,"+$3.toString()+",8)";
														  Register areg = Register.toRegister(Register.R, r);
														  Register destreg = rm.getRegister();
														  System.out.printf("\tmovq %s,%s\n", ((Register)areg).toString(), ((Register)destreg).toString());
														  $$ = destreg;
														  rm.freeRegister((Register)$3);
														}

 		| 	IF_T 										{ labelstack.insert(Label, Label2); }
 			expr 										{ if_top($3); ifStore = rm.getRegister();}
 			THEN_T 										
 			expr 										{ if_middle($6, ifStore); }
 			ELSE_T 
 			expr 										{ if_bottom($9, ifStore); }
 			FI_T 										{ 
 														  $$ = Register.RAX;
 														  if_end(ifStore);
 														  labelstack.removeLabels();
 														}

 		| 	WHILE_T 									{ 
 														  labelstack.insert(Label, Label2);
 													 	  while_top(); 
 														  whileStore = rm.getRegister();
 														}
 			expr  										{ while_check($3);}
 			LOOP_T 
 			expr 										{ while_body($6);}
 			POOL_T 										{ 
 														  labelstack.removeLabels();
 														  $$ = $6;
 														}

 		| 	'{' expr_list '}'							{ $$ = $2; }

 		| 	expr  '+' expr								{ $$ = addition($1, $3); }

 		| 	expr  '-' expr								{ $$ = subtraction($1, $3); }

 		| 	expr  '*' expr								{ $$ = multiplication($1, $3); }

 		| 	'-' expr  %prec UC							{ $$ = negate($2);}

 		| 	expr NE expr								{ $$ = not_equal_to($1, $3);}

 		| 	expr GT expr								{ $$ = greater_than($1, $3);}

 		| 	expr GE expr								{ $$ = greater_than_eq($1, $3);}

 		| 	expr LT expr								{ $$ = less_than($1, $3);}

 		| 	expr LE expr								{ $$ = less_than_eq($1, $3);}

 		| 	expr EQ expr								{ $$ = equal_to($1, $3);}

		|	'(' expr ')'								{ $$ = $2; }

 		|	TRUE_T 										{ 
 															$$ = rm.getRegister(); 
 														 	System.out.printf("\tmovq $%s, %s\n", "1", $$.toString());
 														 	rm.freeRegister((Register)$$);
 														}

 		|	FALSE_T 									{ 
 															$$ = rm.getRegister(); 
 														 	System.out.printf("\tmovq $%s, %s\n", "0", $$.toString());
 														 	rm.freeRegister((Register)$$);
 														}

 		|	INT_CONST									{
 															$$ = rm.getRegister(); 
 														 	System.out.printf("\tmovq $%s, %s\n", $1, $$.toString());
 														}

		;

actual_list	:	actual_list ',' expr					{ 
														  Register reg = func_param_to_reg(paramInUse);
														  System.out.printf("\tmovq %s, %s\n", $3.toString(), reg.toString());
														  rm.freeRegister((Register)$3);
														  paramInUse++; 
														}
		|	expr 										{ 
														  Register reg = func_param_to_reg(paramInUse);
														  System.out.printf("\tmovq %s, %s\n", $1.toString(), reg.toString());
														  rm.freeRegister((Register)$1);
														  paramInUse++; 
														}
		;

expr_list	:	expr_list ';' expr 						{ $$ = $3; }
		|	expr 										{ $$ = $1; }
		;

%%

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

	public 			SymbolTable 			sym 			= new SymbolTable();
	public 			RegisterManager 		rm 				= new RegisterManager();
	public 			LabelStack 				labelstack 		= new LabelStack();
	public 			Object 					CLASSNAME 		= null;
	public static 	String 					INT 			= "Int";
	public static 	String 					STR 			= "String";
	public static 	String 					BOOL 			= "Bool";
	public static 	String 					ARR 			= "Int[]";
	public 			Integer 				stringLabel 	= 0;
	public 			Integer 				Label 			= 0;
	public 			Integer 				Label2 			= 1;
	public 			Integer 				paramCounter 	= 0;
	public 			Integer 				paramInUse 		= 0;
	public 			Boolean 				isActualList 	= false;
	public 			Register 				ifStore;
	public 			Register 				whileStore;

	public static void main (String [] args) throws IOException {
		Parser yyparser = new Parser(new FileReader(args[0]));
		yyparser.yyparse();
	}

	void start_file() {
        System.out.print("\t.section\t.rodata\n");
        System.out.print(".LC0:\n\t.string \"%d \"\n");
        System.out.print(".LC1:\n\t.string \"%s \"\n");
        System.out.print(".LC2:\n\t.string \"%d\"\n");
        System.out.print("\t.data\n\t.align\t8\n");
        System.out.print(".INPUT:\n\t.quad\t0\n\n");
	}
	void start_main() {
		System.out.print("\t.text\n\t.globl main\n\t.type main,@function\n");
		System.out.print("main:\n");
		System.out.print("\tpushq %rbp\n");
		System.out.print("\tmovq %rsp,%rbp\n");
		System.out.print("\tpushq %rbx\n\tpushq %rbp\n\tpushq %r12\n\tpushq %r13\n\tpushq %r14\n\tpushq %r15\n");
		System.out.print("\tsubq $128, %rsp\n\n");
	}
	void end_main(){
 		System.out.print("\n\taddq $128, %rsp\n");
 		System.out.print("\tpopq %r15 \n\tpopq %r14 \n\tpopq %r13 \n\tpopq %r12 \n\tpopq %rbp \n\tpopq %rbx\n");
		System.out.print("\tmovl $0, %eax\n\tpopq %rbp\n\tret\n\n");
	}
	void start_function(String id) { //TODO: IMPLEMENT A SAVE AND RETRIVE LIKE WITH SAVE AND LOAD
		//System.out.print("\t#BEGIN: start_function()\n");
		System.out.printf("\t.text\n\t.globl %s\n\t.type %s,@function\n", id, id);
		System.out.printf("%s:\n", id);
		System.out.print("\tpushq %rbp\n");
		System.out.print("\tmovq %rsp,%rbp\n");
		System.out.print("\tpushq %rbx\n");
		System.out.print("\tpushq %r12\n");
		System.out.print("\tpushq %r13\n");
		System.out.print("\tpushq %r14\n");
		System.out.print("\tpushq %r15\n");
		System.out.print("\tpushq %rbp\n");
		System.out.print("\tsubq $128, %rsp\n");
		System.out.print("\tmovq %rdi,0(%rsp)\n");
		System.out.print("\tmovq %rsi,8(%rsp)\n");
		System.out.print("\tmovq %rdx,16(%rsp)\n");
		System.out.print("\tmovq %rcx,24(%rsp)\n");
		System.out.print("\tmovq %r8,32(%rsp)\n");
		System.out.print("\tmovq %r9,40(%rsp)\n");
		//System.out.print("\t#END: start_function()\n");
	}
	void end_function(Object ret) { //TODO: IMPLEMENT A SAVE AND RETRIVE LIKE WITH SAVE AND LOAD
		//System.out.print("\t#BEGIN: end_function()\n");
		if(ret != null){ //stores the return value
			System.out.printf("\tmovq %s, %%rax\n", ((Register)ret).toString());
		}
		System.out.print("\taddq $128, %rsp\n");
		System.out.print("\tpopq %rbp\n");
		System.out.print("\tpopq %r15\n");
		System.out.print("\tpopq %r14\n");
		System.out.print("\tpopq %r13\n");
		System.out.print("\tpopq %r12\n");
		System.out.print("\tpopq %rbx\n");
		System.out.print("\tpopq %rbp\n");
		System.out.print("\tret\n");
		//System.out.print("\t#END: end_function()\n");
	}
	void save_reg() {
		System.out.print("\t#BEGIN: save_reg()\n");
		System.out.print("\tmovq %rdi, 64(%rsp)\n");
		System.out.print("\tmovq %rsi, 72(%rsp)\n"); 
		System.out.print("\tmovq %rdx, 80(%rsp)\n"); 
		System.out.print("\tmovq %rcx, 88(%rsp)\n"); 
		System.out.print("\tmovq %r8, 96(%rsp)\n"); 
		System.out.print("\tmovq %r9, 104(%rsp)\n"); 
		System.out.print("\tmovq %r10, 112(%rsp)\n"); 
		System.out.print("\tmovq %r11, 120(%rsp)\n");
		rm.saveRegister(Register.RDX);
		rm.saveRegister(Register.RCX);
		rm.saveRegister(Register.R8);
		rm.saveRegister(Register.R9);
		rm.saveRegister(Register.R10);
		rm.saveRegister(Register.R11);
		System.out.print("\t#END: save_reg()\n");
	}
	void load_reg() {
		System.out.print("\t#BEGIN: load_reg()\n");
		rm.loadSaved();
		System.out.print("\tmovq 64(%rsp),%rdi\n"); 
		System.out.print("\tmovq 72(%rsp),%rsi\n"); 
		System.out.print("\tmovq 80(%rsp),%rdx\n"); 
		System.out.print("\tmovq 88(%rsp),%rcx\n"); 
		System.out.print("\tmovq 96(%rsp),%r8\n"); 
		System.out.print("\tmovq 104(%rsp),%r9\n"); 
		System.out.print("\tmovq 112(%rsp),%r10\n"); 
		System.out.print("\tmovq 120(%rsp),%r11\n");
		System.out.print("\t#END: load_reg()\n");
	}
	void outInt(Object r) {
		//System.out.print("\t#BEGIN: out_int(_)\n");
		System.out.printf("\tmovq %s, %%rsi\n", ((Register)r).toString());
		System.out.print("\tmovq $.LC0, %rdi\n");
		System.out.print("\tcall printf\n");
		//System.out.print("\t#END: out_int(_)\n");
		//rm.freeRegister((Register)r); //nobueno
	}
	void outString(Object s) {
		//System.out.print("\t#BEGIN: out_string(_)\n");
		//TODO: SS# should be incremented each time this is seen
		System.out.printf("\t.data\n.SS%d:\t.string %s\n\t.text\n", stringLabel,(String)s);
		System.out.printf("\tmovq $.SS%d, %%rsi\n", stringLabel);
		System.out.print("\tmovq $.LC1, %rdi\n");
		System.out.print("\tcall printf\n");
		//System.out.print("\t#END: out_string(_)\n");
		stringLabel++;
	}

	void outStringID(Object s) {
		System.out.print("\t#BEGIN: out_stringID(_)\n");
		System.out.printf("\tmovq $%s, %%rsi\n", (String)s);
		System.out.print("\tmovq $.LC1, %rdi\n");
		System.out.print("\tcall printf\n");
		System.out.print("\t#END: out_stringID(_)\n");
		stringLabel++; //not sure if this is necessary
	}
	Register addition(Object l, Object r){
		System.out.printf("\taddq %s, %s\n", ((Register)r).toString() , ((Register)l).toString());
		rm.freeRegister((Register)r);
		return (Register)l;
	}
	Register subtraction(Object l, Object r){
		System.out.printf("\tsubq %s, %s\n", ((Register)r).toString() , ((Register)l).toString());
		rm.freeRegister((Register)r);
		return (Register)l;
	}
	Register multiplication(Object l, Object r){
		System.out.printf("\timulq %s, %s\n", ((Register)r).toString() , ((Register)l).toString());
		rm.freeRegister((Register)r);
		return (Register)l;
	}
	Register not_equal_to(Object l, Object r){
		System.out.printf("\tcmp %s, %s\n", ((Register)r).toString() , ((Register)l).toString());
		System.out.print("\tsetne %al\n");
		System.out.printf("\tmovzbq %%al, %s\n", ((Register)l).toString());
		rm.freeRegister((Register)r);
		return (Register)l;
	}
	Register equal_to(Object l, Object r){
		System.out.printf("\tcmp %s, %s\n", ((Register)r).toString() , ((Register)l).toString());
		System.out.print("\tsete %al\n");
		System.out.printf("\tmovzbq %%al, %s\n", ((Register)l).toString());
		rm.freeRegister((Register)r);
		return (Register)l;
	}
	Register greater_than(Object l, Object r){
		System.out.printf("\tcmp %s, %s\n", ((Register)r).toString() , ((Register)l).toString());
		System.out.print("\tsetg %al\n");
		System.out.printf("\tmovzbq %%al, %s\n", ((Register)l).toString());
		rm.freeRegister((Register)r);
		return (Register)l;
	}
	Register greater_than_eq(Object l, Object r){
		System.out.printf("\tcmp %s, %s\n", ((Register)r).toString() , ((Register)l).toString());
		System.out.print("\tsetge %al\n");
		System.out.printf("\tmovzbq %%al, %s\n", ((Register)l).toString());
		rm.freeRegister((Register)r);
		return (Register)l;
	}
	Register less_than(Object l, Object r){
		System.out.printf("\tcmp %s, %s\n", ((Register)r).toString() , ((Register)l).toString());
		System.out.print("\tsetl %al\n");
		System.out.printf("\tmovzbq %%al, %s\n", ((Register)l).toString());
		rm.freeRegister((Register)r);
		return (Register)l;
	}
	Register less_than_eq(Object l, Object r){
		System.out.printf("\tcmp %s, %s\n", ((Register)r).toString() , ((Register)l).toString());
		System.out.print("\tsetle %al\n");
		System.out.printf("\tmovzbq %%al, %s\n", ((Register)l).toString());
		rm.freeRegister((Register)r);
		return (Register)l;
	}
	void assign_array(String id, Object index, Object exp){
		System.out.printf( "\tmovq %s, %s(,%s,8)\n" , ((Register)exp).toString(), id, ((Register)index).toString() );
		//rm.freeRegister((Register)exp);
		//this was causing issues with return values
	}
	void while_top(){
		List<Integer> labels = labelstack.fetch();
		Integer l1 = labels.get(0);
		Integer l2 =  labels.get(1);
		//System.out.print("#WHILE_TOP--------------\n");
		System.out.printf("L%d:\n", l1);  //L0
	}
	void while_check(Object b){
		List<Integer> labels = labelstack.fetch();
		Integer l1 = labels.get(0);
		Integer l2 =  labels.get(1);
		//System.out.print("#WHILE_CHECK--------------\n");
		System.out.printf("\tcmp $0, %s\n", ((Register)b).toString());
		System.out.printf("\tje L%d\n", l2); //L0
		//rm.freeRegister((Register)b);
	}
	void while_body(Object branch1){
		List<Integer> labels = labelstack.fetch();
		Integer l1 = labels.get(0);
		Integer l2 =  labels.get(1);
		//System.out.print("#WHILE_BODY--------------\n");
		Object r = sym.lookup( ((Register)branch1).toString() );
		if(r != null) { //this handles a reload of a _(%rsp)
			Object fetch = ((List<String>)r).get(0);
			String s = null;
			s = (String)fetch;
			System.out.printf("\tmovq %s, %s\n", ((Register)branch1).toString(), s);
		} else {
			//System.out.printf("\tmovq %s, %s\n", ((Register)branch1).toString(), ((Register)store).toString());
		}
		System.out.printf("\tjmp L%d\n", l1); //L1
		//System.out.print("#WHILE_END--------------\n");
		System.out.printf("L%d:\n", l2);  //L0
	}
	void if_top(Object b){
		List<Integer> labels = labelstack.fetch();
		Integer l1 = labels.get(0);
		Integer l2 =  labels.get(1);
		//System.out.print("#IF_TOP--------------\n");
		System.out.printf("\tcmp $0, %s\n", ((Register)b).toString());
		System.out.printf("\tje L%d\n", l1); //L0
		//rm.freeRegister((Register)b);
	}
	void if_middle(Object branch1, Object store){
		List<Integer> labels = labelstack.fetch();
		Integer l1 = labels.get(0);
		Integer l2 =  labels.get(1);
		//System.out.print("#IF_MIDDLE--------------\n");
		System.out.printf("\tmovq %s, %s\n", ((Register)branch1).toString(), ((Register)store).toString());
		System.out.printf("\tjmp L%d\n", l2); //L1
		System.out.printf("L%d:\n", l1);  //L0
		//rm.freeRegister((Register)branch1);
	}
	void if_bottom(Object branch2, Object store){
		//System.out.print("#IF_BOTTOM--------------\n");
		System.out.printf("\tmovq %s, %s\n", ((Register)branch2).toString(), ((Register)store).toString());
		//rm.freeRegister((Register)branch2);
	}
	Register if_end(Object store){
		List<Integer> labels = labelstack.fetch();
		Integer l1 = labels.get(0);
		Integer l2 =  labels.get(1);
		//System.out.print("#IF_END--------------\n");
		System.out.printf("L%d:\n", l2); //L1
		//end of statement put store into RAX
		System.out.printf("\tmovq %s, %s\n", ((Register)store).toString(), Register.RAX.toString());
		//done with temp reg
		rm.freeRegister((Register)store);
		return Register.RAX;
	}
	Register collect_return(Object reg){
		System.out.print("\t#collect_return\n");
		System.out.printf("\tmovq %%rax, %s\n", ((Register)reg).toString());
		//rm.freeRegister((Register)reg);
		return (Register)reg;
	}
	Register negate(Object r){
		System.out.printf("\tnegq %s\n", ((Register)r).toString() );
		return (Register)r;
	}
	void call_func_no_params(String id){
		save_reg();
		System.out.printf("\tcall %s\n",id);
		load_reg();
	}
	void call_func_with_params(String id){
		System.out.printf("\tcall %s\n",id);
	}
	void reload_params(String pID, Object regx){
		Integer pid = Integer.parseInt(pID);
		Integer offset = (pid-1)*8;
		if(pid > 0){
			//System.out.print("\t#reload_params\n");
			System.out.printf("\tmovq %d%s, %s\n", offset, "(%rsp)", regx.toString());
			sym.insert(regx.toString(), Integer.toString(offset)+"(%rsp)");  //here we store a register with its associated rsp
		}
	}
	void global_int(String id) {
		System.out.print("\t.data\n");
		System.out.print("\t.align 8\n");
		System.out.printf("\t.type	%s, @object\n", id);
		System.out.printf("\t.size	%s, 8\n", id);
		System.out.printf("%s:\t.quad	0\n", id);
	}
	void global_int_assigned(String id, String value) {
		System.out.print("\t.data\n");
		System.out.print("\t.align 8\n");
		System.out.printf("\t.type	%s, @object\n", id);
		System.out.printf("\t.size	%s, 8\n", id);
		System.out.printf("%s:\t.quad	%s\n", id, value);
	}
	void global_array(String id, String size){
		System.out.print("\t.data\n");
		System.out.print("\t.align 8\n");
		System.out.printf("\t.type	%s, @object\n", id);
		Integer sizeInt = Integer.parseInt(size);
		Integer sizeofarray = sizeInt * 8;
		System.out.printf("\t.size	%s, %d\n", id, sizeofarray);
		System.out.printf("%s:\n", id);
		for(int i = 0; i < sizeInt; i++){
			System.out.print("\t.quad	0\n");
		}
	}
	void global_string_assigned(String id, String value){
		System.out.print("\t.data\n");
		System.out.printf("%s:\t.string %s\n",id, value);
		System.out.print("\t.text\n");
	}
	Register in_int_updated(){
		save_reg();
		System.out.print("\tmovq $.LC2, %rdi\n");
		System.out.print("\tmovq $.INPUT, %rsi\n");
		System.out.print("\tcall  __isoc99_scanf\n");
		load_reg();
		Register reg1 = rm.getRegister();
		System.out.printf("\tmovq .INPUT(%%rip), %s\n", reg1.toString() );
		return reg1;
	}

	class LabelStack {
		private Stack<List<Integer>> stk;
		public LabelStack(){
			stk = new Stack<List<Integer>>();
		}
		public void insert(Integer L1, Integer L2){
			List<Integer> tup = Arrays.asList(L1, L2);
			stk.push(tup);
			Label = Label + 2;
	 		Label2 = Label2 + 2;
		}
		public void removeLabels(){
			stk.pop();
		}
		public List<Integer> fetch(){
			return stk.peek();
		}
	}

	class SymbolTable {
		private Stack stk;
		public SymbolTable() {
			stk = new Stack();
		}
		public void enterScope() {
			stk.push(new Hashtable());
			//System.out.println("Entered scope");
		}
		public void exitScope() {
			if( stk.empty() ) {
				throw new java.lang.RuntimeException("exitscope: empty table");
			}
			Enumeration e = ((Hashtable)stk.peek()).elements();
			//System.out.printf("#Available Reg: %d\n", rm.availableRegisters());
			while(e.hasMoreElements()) {  
			//this was an attempt at freeing paramet registers, but is now being handled by reinitiation
				String rStr =  ((List<String>)(e.nextElement())).get(0);
				//rm.freeRegister(strToReg(rStr));
			}
			//System.out.printf("#Available Reg: %d\n", rm.availableRegisters());
			stk.pop();
			//System.out.println("Exited scope");
		}
		public void insert(String id, String reg) {
			List<String> tup = Arrays.asList(reg, "0", (String)CLASSNAME); 
			if( stk.empty() ) {
				throw new java.lang.RuntimeException("insert: can't insert without a scope");
			}
			//System.out.printf("#Inserting: %s:%s \n", id, reg);
			((Hashtable)stk.peek()).put(id, tup);
		}
		public void insert(String id, String reg, String paramId) {
			List<String> tup = Arrays.asList(reg, paramId, (String)CLASSNAME); 
			if( stk.empty() ) {
				throw new java.lang.RuntimeException("insert: can't insert without a scope");
			}
			//System.out.printf("#Inserting: %s:%s paramId: %s \n", id, reg, paramId);
			((Hashtable)stk.peek()).put(id, tup);
		}
		public void insertLabel(String id){
			String reg = id+"(%rip)";
			List<String> tup = Arrays.asList(reg, "0", (String)CLASSNAME); 
			if( stk.empty() ) {
				throw new java.lang.RuntimeException("insert: can't insert without a scope");
			}
			//System.out.printf("#Inserting: %s:%s \n", id, reg);
			((Hashtable)stk.peek()).put(id, tup);
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
	}

	public static class RegisterManager { //Consider name change
	    private List<Register> registers = new ArrayList<Register>();
	    private List<Register> registersInUse = new ArrayList<Register>();                                                                
	    public static final Register RLIST[] = new Register[]{
	    	Register.RBX, Register.RCX, Register.RDX, Register.R8 , Register.R9 , Register.R10, 
	    	Register.R11, Register.R12, Register.R13, Register.R14, Register.R15 
	    };	                                                        
	    public RegisterManager(){
	    	flushRegisters();
	    }
	    public int availableRegisters() {
	        return registers.size();
	    }
	    public void flushRegisters() {
	    	//System.out.printf("#----BEFORE CLEAR ---Available Reg: %d\n", this.availableRegisters());
	        registers.clear();
	        registers.addAll(Arrays.asList(RLIST));
	        //System.out.printf("#----AFTER CLEAR ---#Available Reg: %d\n", this.availableRegisters());
	    }
	    public Register getRegister() {
	        int available = this.availableRegisters() - 1;
	        if (available < 0)
	        	throw new java.lang.RuntimeException("Program requires too many registers");
	        return registers.remove(available);
	    }
	    public void freeRegister(Register reg) {
	        Boolean rInL = this.registerInUse(reg);
	        String r = reg.toString();
	        //System.out.printf("#ATTEMPTING TO FREE REGISTER: %s\n", r);
	        if(r.equals("%rdi") || r.equals("%rsi") || r.contains("rip") || r.contains("rsp") || r.contains(",8)") || rInL){
	        	//protect function w/ param storage
	        	if(rInL) {
	        		//System.out.printf("#REGISTER LIST ALREADY CONTAINS : %s\n", reg.toString());
	        	}
	        } else {
	        	//System.out.printf("#FREED REGISTER: %s\n", r);
	        	registers.add(reg);
	        }	        
	    }
	    public void saveRegister(Register reg){
	    	String r = reg.toString();
	    	if(!this.registerInUse(reg) && 
	    		!(r.equals("%rdi") || r.equals("%rsi") || r.contains("rip") || r.contains("rsp") || r.contains(",8)")) || r.equals("%rax")) {
	    		    //System.out.printf("#Adding to RegistersInUse: %s\n", r);
	    			registersInUse.add(reg);
	    			this.freeRegister(reg);
	    	}
	    }
	    public void loadSaved(){
	    	for (Register reg : registersInUse) {
	    		//System.out.printf("#Removing register: %s which was previously in use\n", reg.toString());
	    		registers.remove(reg);
	    	}
	    	registersInUse.clear();
	    }
	    public Boolean registerInUse(Register reg){
	    	return registers.contains(reg);
	    }
	}
	public enum Register {
	    RAX("%rax"), RBX("%rbx"), RCX("%rcx"), RDX("%rdx"),
	    RSI("%rsi"), RDI("%rdi"), RBP("%rbp"), RSP("%rsp"), 
	    R8("%r8"),   R9("%r9"),   R10("%r10"), R11("%r11"),
	    R12("%r12"), R13("%r13"), R14("%r14"), R15("%r15"),
	    R("");
	    public  String rString;
	    private Register(String rString) {
	        this.rString = rString;
	    }
	    @Override
	    public String toString() {
	       return rString;
	    }
	    public static Register toRegister(Register r, String s){ //might be unsafe
	    	//System.out.printf("##[[DEUBG]] toRegister: String: %s\n", s);
	    	r.rString = s;
	    	return r;
	    }
	}
	Register func_param_to_reg(Integer p) { //for use with parameter passing
		Register register;
		 switch (p) {
            case 0:  register = Register.RDI;
                     break;
            case 1:  register = Register.RSI;
                     break;
            case 2:  register = Register.RDX;
                     break;
            case 3:  register = Register.RCX;
                     break;
            case 4:  register = Register.R8;
                     break;
            default: register = Register.RAX;
                     break;
        }
        return register;
	}
	Register strToReg(String r) { //for use with parameter passing
		Register register;
		 switch (r) {
		 	case "%rax":  register = Register.RAX;
                     break;
            case "%rbx":  register = Register.RBX;
                     break;
            case "%r9":  register = Register.R9;
                     break;
            case "%r10":  register = Register.R10;
                     break;
            case "%r11":  register = Register.R11;
                     break;
            case "%r12":  register = Register.R12;
                     break;
            case "%r13":  register = Register.R13;
                     break;
            case "%r14":  register = Register.R14;
                     break;
            case "%r15":  register = Register.R15;
                     break;
            case "%rdi":  register = Register.RDI;
                     break;
            case "%rsi":  register = Register.RSI;
                     break;
            case "%rdx":  register = Register.RDX;
                     break;
            case "%rcx":  register = Register.RCX;
                     break;
            case "%r8":  register = Register.R8;
                     break;
            default: register = Register.toRegister(Register.R, r);
                     break;
        }
        return register;
	}