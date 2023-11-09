//Tokens
%token if
%token for while
%token let
%token varName const CONSTANT
%token func return
%token list
// %token int? bnf 28
%token read
%token string
%token curlyOpen curlyClose //left and right curly braces
%token parantOpen parantClose// left and right paranthesis
%token assignment//ASSIGN_EQual sign
%token statementEnd//semicolon
%token MAIN
%token comma
%token arraySizeSpecifier // ~
//%token INT
%token readOperator printOperator
%token smaller smallerEqual larger largerEqual equals notEquals
%token increment decrement plusEqual minusEqual divideEqual timesEqual modEqual
%token PLUS MINUS DIVIDE MULTIPLY POWER MODULO
%token not or and xor
%token print PRINT_LN
%token comment

%nonassoc ELSE_if ELSE
%nonassoc ELSE

%start program

%%
// programm beginning

main: MAIN parantOpen parantClose curlyOpen program curlyClose;
program: statements;
statements: statement| statements statement;
statement: cond_statement
		| loop
		| single_st
        | statement;

//conditionals
cond_statement: if_statement
        | Else_if_statement
        | Else_statement;

if_statement: if parantOpen expr parantClose curlyOpen statements curlyClose;
Else_if_statement: if_statement ELSE_if parantOpen expr parantClose curlyOpen statements curlyClose;
Else_statement: if_statement ELSE curlyOpen statements curlyClose
        | if_statement Else_if_statement ELSE curlyOpen statements curlyClose;

// loops
loop: for_loop | while_loop;
for_loop: for parantOpen let varName assignment expr statementEnd conditions statementEnd Do_In_Loops curlyOpen statements curlyClose;
while_loop: while parantOpen conditions parantClose curlyOpen statements curlyClose;

conditions: varName bool_OPS expr;

single_statement: varDeclaration
        | return_statement
        | arr_Dec
        | var_Assign
        | const_Int_Dec_Assign
        | const_string_Dec_assign
        | var_dec_assign
        | print_st
        | read_sc
        | print_line_st
        | func_call
        | comment;

varDeclaration: let varName assignment expr
        | let varName assignment arithmetic_op;

var_Assign: varName assing_ops EXPR;
var_dec_assign: let var_Assign;
const_Int_Dec_Assign: const varName assignment expr;
const_string_Dec_assign: const varName assignment string;
return_statement: return expr;

//arrays
arr_Dec: list varName;
arr_INIT: varName assignment curlyOpen insideOFList curlyClose;
insideOFList: varName comma insideOFList
        | varName
        | CONSTANT
        | const comma insideOFList;

arraySizeSpecifier_op : arraySizeSpecifier;

// functions

func_call: func varName parantOpen expr parantClose;
func: func varName parantOpen parameters parantClose curlyOpen statements return_statement curlyClose;

//expressions

exprs: expr | expr exprs
expr: arithmetic_op
        | bool_OPS
        | varName
        | CONSTANT
        | expr compare expr;

parameters: let varName | comma parameters;

//scanner
read_sc: read readOperator expr;

compare: smaller
        | smallerEqual
        | larger
        | largerEqual
        | equals
        | notEquals;

Do_In_Loops: incremention
        | decremention 
        | expr;

incremention: varName increment 
        | increment varName;

decremention: varName decrement
        | decrement varName;

assing_ops: plusEqual
        | minusEqual
        | divideEqual
        | modEqual
        | timesEqual
        |assignment;

arithmetic_op: sum_op
        | substract_op
        | multiply_op
        | divide_op
        | mod_op
        | pow_op;

sum_op: varName PLUS varName 
        | CONSTANT PLUS varName 
        | CONSTANT PLUS CONSTANT;

substract_op: varName MINUS varName 
        | CONSTANT MINUS varName 
        | CONSTANT MINUS CONSTANT;

multiply_op: varName MULTIPLY varName 
        | CONSTANT MULTIPLY varName 
        | CONSTANT MULTIPLY CONSTANT;

divide_op: varName DIVIDE varName 
        | CONSTANT DIVIDE varName 
        | CONSTANT DIVIDE CONSTANT;

mod_op: varName MODULO varName 
        | CONSTANT MODULO varName 
        | CONSTANT MODULO CONSTANT;

pow_op: varName POWER varName 
        | CONSTANT POWER varName 
        | CONSTANT POWER CONSTANT;

bool_OPS: not_op
        | or_op
        | and_op
        | xor_op;

not_op: not varName 
        | not CONSTANT
        | not parantOpen expr parantClose;

or_op: expr or expr;
and_op: expr and expr;
xor_op: expr xor expr;

print_st: print printOperator expr; 
print_line_st: printLineCall;

comment_st: comment expr;

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
