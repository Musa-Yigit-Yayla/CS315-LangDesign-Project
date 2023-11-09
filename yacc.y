%{
#include <stdio.h>
#include <stdlib.h>
#define YYDEBUG 1
%}



//Tokens
%token ifKeyword
%token for while
%token let
%token varName constIntKeyword number
%token func return
%token list
// %token int? bnf 28
%token readCall
%token string
%token curlyOpen curlyClose //left and right curly braces
%token parantOpen parantClose// left and right paranthesis
%token assignment//ASSIGN_EQual sign
%token statementEnd//semicolon
%token MAIN
%token comma
%token arraySizeSpecifier // ~
//%token INT
%token readCallOperator printOperator
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

if_statement: ifKeyword parantOpen expr parantClose statementEnd curlyOpen statements curlyClose;
Else_if_statement: if_statement elseIfKeyword parantOpen expr parantClose statementEnd curlyOpen statements curlyClose;
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
        | constIntKeyword_Int_Dec_Assign
        | constIntKeyword_string_Dec_assign
        | var_dec_assign
        | print_st
        | readCall_sc
        | print_line_st
        | func_call
	|func_def
        | comment;

varDeclaration: let varName assignment expr
        | let varName assignment arithmetic_op;

var_Assign: varName assing_ops expr;
var_dec_assign: let var_Assign;
constIntKeyword_Int_Dec_Assign: constIntKeyword varName assignment expr;
constIntKeyword_string_Dec_assign: constIntKeyword varName assignment string;
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
readCall_sc: readCall readCallOperator expr;

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
int lineNo;
int state = 0;

int main() {
        yyparse();
        if(state == 0){
                printf("Parsing is successfully completed.\n");
        }
        return 0;
}
void yyerror( char *s ) { state = -1; fprintf( stderr, "%d: %s\n",lineNo+1,s); }
