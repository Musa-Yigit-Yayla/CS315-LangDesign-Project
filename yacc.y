%{
#include <stdio.h>
#include <stdlib.h>
#define YYDEBUG 1
%}



//Tokens
%token IF
%token FOR WHILE
%token LET_INT LET_STRING
%token VAR_NAME constIntKeyword NUMBER NEWLINE
%token FUNC RETURN
%token LET_LIST
// %token int? bnf 28
%token READ
%token LET_LIST
%token CURLY_OPEN CURLY_CLOSE //left AND right curly braces
%token PARANT_OPEN PARANT_CLOSE// left AND right paranthesis
%token ASSIGNMENT//ASSIGN_EQual sign
%token SEMICOL//semicolon
%token MAIN
%token COMMA
%token LIST_SIZE_SPECIFIER // ~
//%token INT
%token READ_OP PRINT_OP
%token SMALLER SMALLER_EQUAL LARGER LARGER_EQUAL EQUALS NOT_EQUALS
%token INCREMENT DECREMENT PLUS_ASSIGN SUBTRACT_ASSIGN DIVIDE_ASSIGN MULTIPLY_ASSIGN REMAINDER_ASSIGN
%token PLUS SUBTRACT MULTIPLY DIVIDE REMAINDER POW
%token NOT OR AND XOR
%token PRINT PRINT_LINE
%token COMMENT
%token ARR_BRACK_OPEN ARR_BRACK_CLOSE STRING_OPEN_OR_CLOSE STRING_CONST
%token MAIN
%nonassoc ELSE_IF ELSE

%start program

%%
// programm beginning

program: MAIN PARANT_OPEN PARANT_CLOSE CURLY_OPEN statements CURLY_CLOSE;

statements: statement| statements statement;

statement: cond_statement
		| loop
		| single_statement
        	| func_call
		| func_def
		| comment_st;

//conditionals
cond_statement: if_statement
        | Else_if_statement
        | Else_statement;

if_statement: IF PARANT_OPEN expr PARANT_CLOSE SEMICOL CURLY_OPEN statements CURLY_CLOSE;
Else_if_statement: if_statement ELSE_IF PARANT_OPEN expr PARANT_CLOSE SEMICOL CURLY_OPEN statements CURLY_CLOSE;
Else_statement: if_statement ELSE CURLY_OPEN statements CURLY_CLOSE
        | if_statement Else_if_statement ELSE CURLY_OPEN statements CURLY_CLOSE;

// loops
loop: for_loop | while_loop;

for_loop: FOR PARANT_OPEN LET_INT VAR_NAME ASSIGNMENT expr SEMICOL conditions SEMICOL Do_In_Loops CURLY_OPEN statements CURLY_CLOSE;
while_loop: WHILE PARANT_OPEN conditions PARANT_CLOSE CURLY_OPEN statements CURLY_CLOSE;

conditions: VAR_NAME bool_OPS expr;

single_statement: varDeclaration
        | var_Assign
        | constIntKeyword_Int_Dec_Assign
        | constIntKeyword_string_Dec_assign
	| arr_Dec
	| arr_INIT
        | print_st
        | readCall_sc
        | print_line_st;

varDeclaration: LET_INT VAR_NAME ASSIGNMENT expr
        | LET_STRING VAR_NAME ASSIGNMENT STRING_CONST;

var_Assign: VAR_NAME assing_ops expr;

constIntKeyword_Int_Dec_Assign: constIntKeyword VAR_NAME ASSIGNMENT expr;
constIntKeyword_string_Dec_assign: constIntKeyword VAR_NAME ASSIGNMENT LET_LIST;


print_st: PRINT PRINT_OP expr; 
print_line_st: PRINT_LINE;

//scanner
readCall_sc: READ READ_OP expr;


// functions
func_call: VAR_NAME PARANT_OPEN parameters PARANT_CLOSE;
func_def: FUNC VAR_NAME PARANT_OPEN parameters PARANT_CLOSE CURLY_OPEN statements RETURN expr CURLY_CLOSE;


parameters: LET_INT VAR_NAME COMMA parameters
		| LET_STRING VAR_NAME COMMA parameters
		|/* empty */;

expr: arithmetic_ops
        | bool_OPS
        | VAR_NAME compare expr;

arithmetic_ops: VAR_NAME arithmetic_op expr
                  | expr arithmetic_op expr;

arithmetic_op: PLUS
        | SUBTRACT
        | MULTIPLY
        | DIVIDE
        | REMAINDER
        | POW;

compare: SMALLER
        | SMALLER_EQUAL
        | LARGER
        | LARGER_EQUAL
        | EQUALS
        | NOT_EQUALS;

bool_OPS:  VAR_NAME bool_OP expr
                | VAR_NAME bool_OP VAR_NAME;

bool_OP: NOT
        | OR
        | AND
        | XOR;

comment_st: COMMENT;

//arrays
arr_Dec: LET_LIST VAR_NAME;
arr_INIT: VAR_NAME ASSIGNMENT CURLY_OPEN insideOFList CURLY_CLOSE;
insideOFList: VAR_NAME COMMA insideOFList
        | VAR_NAME
	| expr
        | expr COMMA insideOFList;

arraySizeSpecifier_op : LIST_SIZE_SPECIFIER;

Do_In_Loops: incremention
        | decremention 
        | expr;

incremention: VAR_NAME INCREMENT 
        | INCREMENT VAR_NAME;

decremention: VAR_NAME DECREMENT
        | DECREMENT VAR_NAME;

assing_ops: PLUS_ASSIGN
        | SUBTRACT_ASSIGN
        | DIVIDE_ASSIGN
        | REMAINDER_ASSIGN
        | MULTIPLY_ASSIGN
        |ASSIGNMENT;


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
