%{
#include <stdio.h>
#include <stdlib.h>
#define YYDEBUG 1
%}



//Tokens
%token IF
%token FOR WHILE
%token LET_INT LET_STRING
%token VAR_NAME CONST NUMBER NEWLINE
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
%token STRING_INNER_STATEMENT
%token MAIN
%nonassoc ELSE_IF ELSE

%start program

%%
// programm beginning

program: MAIN PARANT_OPEN PARANT_CLOSE CURLY_OPEN statements CURLY_CLOSE {printf("program\n");};

statements: statement| statements statement {printf("statements\n");};

statement: cond_statement
		| loop
		| single_statement
        	| func_call
		| func_def
		| comment_st {printf("statement");};

//conditionals
cond_statement: if_statement
        | Else_if_statement
        | Else_statement {printf("cond_statement");};

if_statement: IF PARANT_OPEN conditions PARANT_CLOSE SEMICOL CURLY_OPEN statements CURLY_CLOSE {printf("if_statement");};
Else_if_statement: if_statement ELSE_IF PARANT_OPEN conditions PARANT_CLOSE SEMICOL CURLY_OPEN statements CURLY_CLOSE{printf("Else_if_statement");};
Else_statement: if_statement ELSE CURLY_OPEN statements CURLY_CLOSE
        |Else_if_statement ELSE CURLY_OPEN statements CURLY_CLOSE {printf("if_statement");};

// loops
loop: for_loop | while_loop {printf("loop");};

for_loop: FOR PARANT_OPEN LET_INT VAR_NAME ASSIGNMENT NUMBER SEMICOL conditions SEMICOL Do_In_Loops CURLY_OPEN statements CURLY_CLOSE 
| FOR PARANT_OPEN LET_INT VAR_NAME ASSIGNMENT VAR_NAME SEMICOL conditions SEMICOL Do_In_Loops CURLY_OPEN statements CURLY_CLOSE {printf("for_loop");};
while_loop: WHILE PARANT_OPEN conditions PARANT_CLOSE CURLY_OPEN statements CURLY_CLOSE {printf("while_loop");};

conditions: VAR_NAME expr VAR_NAME | VAR_NAME expr NUMBER | NUMBER expr NUMBER {printf("conditions");};

single_statement: varDeclaration
        | var_Assign
        | CONST_Int_Dec_Assign
	| arr_Dec_init
	| arr_Dec
	| arr_INIT
        | print_st
        | readCall_sc
        | print_line_st {printf("single_statement");};

varDeclaration: LET_INT VAR_NAME ASSIGNMENT NUMBER
	|  LET_INT VAR_NAME ASSIGNMENT VAR_NAME
        | LET_STRING VAR_NAME ASSIGNMENT STRING_CONST {printf("var_declaration");};

var_Assign: VAR_NAME assing_ops VAR_NAME
		|VAR_NAME assing_ops NUMBER
		|VAR_NAME assing_ops STRING_CONST {printf("var_Assign");};

CONST_Int_Dec_Assign: CONST VAR_NAME ASSIGNMENT VAR_NAME|
		CONST VAR_NAME ASSIGNMENT NUMBER {printf("CONST");};


print_st: PRINT PRINT_OP VAR_NAME | PRINT PRINT_OP NUMBER | PRINT PRINT_OP STRING_CONST {printf("print_st");}; 
print_line_st: PRINT_LINE {printf("print_line_st");};

//scanner
readCall_sc: READ READ_OP NUMBER
	|READ READ_OP STRING_INNER_STATEMENT {printf("readCall_sc");};


// functions
func_call: VAR_NAME PARANT_OPEN parameters PARANT_CLOSE {printf("func_call");};

func_def: FUNC VAR_NAME PARANT_OPEN parameters PARANT_CLOSE CURLY_OPEN statements RETURN VAR_NAME CURLY_CLOSE
	|FUNC VAR_NAME PARANT_OPEN parameters PARANT_CLOSE CURLY_OPEN statements RETURN NUMBER CURLY_CLOSE {printf("func_def");};


parameters: LET_INT VAR_NAME COMMA parameters
		| LET_STRING VAR_NAME COMMA parameters {printf("parameters");};

expr: arithmetic_ops
        | bool_OPS
        | comparison {printf("expr");};

arithmetic_ops: VAR_NAME arithmetic_op VAR_NAME
                  | VAR_NAME arithmetic_op NUMBER
		|NUMBER arithmetic_op NUMBER {printf("arithmetic_ops");};

arithmetic_op: PLUS
        | SUBTRACT
        | MULTIPLY
        | DIVIDE
        | REMAINDER
        | POW {printf("arithmetic_op");};

comparison: VAR_NAME compare VAR_NAME
                  | VAR_NAME compare NUMBER
		|NUMBER compare NUMBER {printf("comparison");};

compare: SMALLER
        | SMALLER_EQUAL
        | LARGER
        | LARGER_EQUAL
        | EQUALS
        | NOT_EQUALS {printf("compare");};

bool_OPS:  VAR_NAME bool_OP VAR_NAME
                | VAR_NAME bool_OP NUMBER;
		| NUMBER bool_OP NUMBER {printf("bool_OPS");};

bool_OP: NOT
        | OR
        | AND
        | XOR {printf("bool_OP");};

comment_st: COMMENT STRING_INNER_STATEMENT COMMENT {printf("comment_st");};

//arrays
arr_Dec_init: LET_LIST VAR_NAME ASSIGNMENT CURLY_OPEN insideOFList CURLY_CLOSE {printf("arr_Dec_init");};
arr_Dec: LET_LIST VAR_NAME {printf("arr_Dec");};
arr_INIT: VAR_NAME ASSIGNMENT CURLY_OPEN insideOFList CURLY_CLOSE {printf("arr_INIT");};
insideOFList: VAR_NAME COMMA insideOFList
        | VAR_NAME
	| NUMBER
        | NUMBER COMMA insideOFList {printf("insideOFList");};

//arraySizeSpecifier_op : LIST_SIZE_SPECIFIER;

Do_In_Loops: incremention
        | decremention 
        | expr {printf("Do_In_Loops");};

incremention: VAR_NAME INCREMENT 
        | INCREMENT VAR_NAME {printf("incremention");};

decremention: VAR_NAME DECREMENT
        | DECREMENT VAR_NAME {printf("decremention");};

assing_ops: PLUS_ASSIGN
        | SUBTRACT_ASSIGN
        | DIVIDE_ASSIGN
        | REMAINDER_ASSIGN
        | MULTIPLY_ASSIGN
        |ASSIGNMENT {printf("assing_ops");};


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