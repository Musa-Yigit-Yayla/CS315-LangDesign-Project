%{
	//#define YYDEBUG 1
	#include "stdio.h"
    void yyerror(char *);
    extern int yylineno;
    #include "y.tab.h"
	int yylex(void);
%}



//Tokens
%token if
%token for while
%token let
%token varName const number
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
%token sum substract multiply divide mod pow
%token not or and xor
%token print printLineCall
%token comment

%nonassoc elseIfKeyword elseKeyword
%nonassoc elseKeyword

%start program

%%
// programm beginning

main: MAIN parantOpen parantClose curlyOpen program curlyClose;
program: statements;
statements: statement| statements statement;
statement: cond_statement
		| loop
		| single_statement
        | statement;

//conditionals
cond_statement: if_statement
        | Else_if_statement
        | Else_statement;

if_statement: if parantOpen expr parantClose curlyOpen statements curlyClose;
Else_if_statement: if_statement elseIfKeyword parantOpen expr parantClose curlyOpen statements curlyClose;
Else_statement: if_statement elseKeyword curlyOpen statements curlyClose
        | if_statement Else_if_statement elseKeyword curlyOpen statements curlyClose;

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
	|func_def
        | comment;

varDeclaration: let varName assignment expr
        | let varName assignment arithmetic_op;

var_Assign: varName assing_ops expr;
var_dec_assign: let var_Assign;
const_Int_Dec_Assign: const varName assignment expr;
const_string_Dec_assign: const varName assignment string;
return_statement: return expr;


//arrays
arr_Dec: list varName;
arr_INIT: varName assignment curlyOpen insideOFList curlyClose;
insideOFList: varName comma insideOFList
        | varName
	| expr
        | expr comma insideOFList;

arraySizeSpecifier_op : arraySizeSpecifier;

// functions

func_call: func varName parantOpen expr parantClose;
func_def: func varName parantOpen parameters parantClose curlyOpen statements return_statement curlyClose;

//expressions

exprs: expr | expr exprs
expr: arithmetic_op
        | bool_OPS
        | varName
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

arithmetic_op: sum
        | substract
        | multiply
        | divide
        | mod
        | pow;


bool_OPS: not_op
        | or_op
        | and_op
        | xor_op;

not_op: not varName 
        | not expr
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
