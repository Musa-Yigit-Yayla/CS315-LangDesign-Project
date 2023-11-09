//Tokens
%token IF
%token FOR WHILE
%token LET
%token VAR_NAME CONST CONSTANT
%token FUNC RETURN
%token LIST
%token int? bnf 28
%token READ
%token STRING
%token LC RC //left and right curly braces
%token LP RP// left and right paranthesis
%token ASSIGN_EQ//ASSIGN_EQual sign
%token SC//semicolon
%token MAIN
%token COMMA
%token ARR_size // ~
%token INT
%token READ_OP
%token LESS LESS_EQ MORE MORE_EQ EQ NOT_EQ
%token INC DEC PLUS_EQ MIN_EQ DIV_EQ MUL_EQ
%token PLUS MINUS DIVIDE MULTIPLY POWER MODULO
%token NOT OR AND XOR
%token PRINT PRINT_LN
%token COMMENT

%nonassoc ELSE_IF ELSE
%nonassoc ELSE

%start program

%%
// programm beginning

main: MAIN LP RP LC program RC;
program: statements;
statements: statement| statements statement;
statement: cond_statement
		| loop
		| single_st
        | statement;

//conditionals
cond_statement: If_statement
        | Else_If_statement
        | Else_statement;

If_statement: IF LP expr RP LC statements RC;
Else_If_statement: If_statement ELSE_IF LP expr RP LC statements RC;
Else_statement: If_statement ELSE LC statements RC
        | If_statement Else_If_statement ELSE LC statements RC;

// loops
loop: for | while;
for: FOR LP LET VAR_NAME ASSIGN_EQ expr SC conditions SC Do_In_Loops LC statements RC;
while: WHILE LP conditions RP LC statements RC;

conditions: VAR_NAME bool_OPS expr;

single_statement: varDeclaration
        | return_statement
        | arr_Dec
        | var_Assign
        | const_Int_Dec_Assign
        | const_string_Dec_assign
        | var_dec_assign
        | print
        | print_line
        | func_call;

varDeclaration: LET VAR_NAME ASSIGN_EQ expr
        | LET VAR_NAME ASSIGN_EQ arithmetic_op;

var_Assign: VAR_NAME assing_ops EXPR;
var_dec_assign: LET var_Assign;
const_Int_Dec_Assign: CONST VAR_NAME ASSIGN_EQ expr;
const_string_Dec_assign: CONST VAR_NAME ASSIGN_EQ STRING;
return_statement: RETURN expr;

//arrays
arr_Dec: LIST VAR_NAME;
arr_INIT: VAR_NAME ASSIGN_EQ LC insideOFList RC;
insideOFList: VAR_NAME COMMA insideOFList
        | VAR_NAME
        | CONSTANT
        | CONST COMMA insideOFList;

arraySizeSpecifier : ARR_size;

// functions

func_call: FUNC VAR_NAME LP expr RP;
func: FUNC VAR_NAME LP parameters RP LC statements return_statement RC;

//expressions

exprs: expr | expr exprs
expr: arithmetic_op
        | bool_OPS
        | VAR_NAME
        | CONSTANT
        | expr compare expr;

parameters: LET VAR_NAME | COMMA parameters;

//scanner
read: READ READ_OP expr;

compare: LESS
        | LESS_EQ
        | MORE
        | MORE_EQ
        | EQ
        | NOT_EQ;

Do_In_Loops: increment 
        | decrement 
        | expr;

increment: VAR_NAME INC 
        | INC VAR_NAME;

decrement: VAR_NAME DEC
        | DEC VAR_NAME;

assing_ops: PLUS_EQ
        | MIN_EQ
        | DIV_EQ
        | MUL_EQ
        | ASSIGN_EQ;

arithmetic_op: sum_op
        | substract_op
        | multiply_op
        | divide_op
        | mod_op
        | pow_op;

sum_op: VAR_NAME PLUS VAR_NAME 
        | CONSTANT PLUS VAR_NAME 
        | CONSTANT PLUS CONSTANT;

substract_op: VAR_NAME MINUS VAR_NAME 
        | CONSTANT MINUS VAR_NAME 
        | CONSTANT MINUS CONSTANT;

multiply_op: VAR_NAME MULTIPLY VAR_NAME 
        | CONSTANT MULTIPLY VAR_NAME 
        | CONSTANT MULTIPLY CONSTANT;

divide_op: VAR_NAME DIVIDE VAR_NAME 
        | CONSTANT DIVIDE VAR_NAME 
        | CONSTANT DIVIDE CONSTANT;

mod_op: VAR_NAME MODULO VAR_NAME 
        | CONSTANT MODULO VAR_NAME 
        | CONSTANT MODULO CONSTANT;

pow_op: VAR_NAME POWER VAR_NAME 
        | CONSTANT POWER VAR_NAME 
        | CONSTANT POWER CONSTANT;

bool_OPS: not_op
        | or_op
        | and_op
        | xor_op;

not_op: NOT VAR_NAME 
        | NOT CONSTANT
        | NOT LP expr RP;

or_op: expr OR expr;
and_op: expr AND expr;
xor_op: expr XOR expr;

print: PRINT expr; 
print_line: PRINT_LN;

comment: COMMENT expr;

%%
#include "lex.yy.c"

// report errors
void yyerror(char *s) 
{
  fprintf(stderr, "syntax error at line: %d %s\n", yylineno, s);
}

int main(void){
	//#if YYDEBUG
	//	yydebug = 1;
	//#endif
	yyparse();
	if(yynerrs < 1) printf("there are no syntax errors!!\n");
}



