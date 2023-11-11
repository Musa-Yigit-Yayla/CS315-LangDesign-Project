//Maryam Azimli
//Musa Yiğit Yayla

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

%debug //remove this debug option later on
%start program

%%
// programm beginning

program: MAIN PARANT_OPEN PARANT_CLOSE CURLY_OPEN statements CURLY_CLOSE {lineNo = 1; printf("program\n");};

statements: statement | statement statements {lineNo = 2; printf("statements\n");};

statement: cond_statement
		| loop
		| single_statement
        	| func_call
		| func_def
		| comment_st 
                | NEWLINE {lineNo = 3; printf("statement");};

//conditionals
cond_statement: if_statement
        | Else_if_statement
        | Else_statement {lineNo = 4; printf("cond_statement");};

if_statement: IF PARANT_OPEN single_statement_without_semicol PARANT_CLOSE CURLY_OPEN statements CURLY_CLOSE {lineNo = 5; printf("if_statement");};
Else_if_statement: if_statement ELSE_IF PARANT_OPEN single_statement_without_semicol PARANT_CLOSE CURLY_OPEN statements CURLY_CLOSE{lineNo = 6; printf("Else_if_statement");};
Else_statement: if_statement ELSE CURLY_OPEN statements CURLY_CLOSE
        |Else_if_statement ELSE CURLY_OPEN statements CURLY_CLOSE {lineNo = 7; printf("if_statement");};

// loops
loop: for_loop | while_loop {lineNo = 8; printf("loop");};

for_loop: FOR PARANT_OPEN single_statement single_statement_without_semicol SEMICOL Do_In_Loops PARANT_CLOSE CURLY_OPEN statements CURLY_CLOSE  {lineNo = 9; printf("for_loop");};
while_loop: WHILE PARANT_OPEN single_statement_without_semicol PARANT_CLOSE CURLY_OPEN statements CURLY_CLOSE {lineNo = 10; printf("while_loop");};

//conditions: VAR_NAME expr VAR_NAME | VAR_NAME expr NUMBER | NUMBER expr NUMBER {lineNo = 11; printf("conditions");};

single_statement: varDeclaration SEMICOL  {printf("var_declaration_single_statement");}
        | var_Assign SEMICOL { printf("var_Assign");}
        | CONST_Int_Dec_Assign SEMICOL
	| arr_Dec_init SEMICOL
	| arr_Dec SEMICOL
	| arr_INIT SEMICOL
        | print_st SEMICOL
        | readCall_sc SEMICOL
        | print_line_st SEMICOL {lineNo = 12; printf("print_line_st");};

single_statement_without_semicol:  varDeclaration
        | var_Assign { printf("var_Assign");}
        | CONST_Int_Dec_Assign
        | VAR_NAME expr VAR_NAME
        | VAR_NAME expr NUMBER 
        | NUMBER expr NUMBER
        | NUMBER expr VAR_NAME;


varDeclaration: LET_INT VAR_NAME ASSIGNMENT NUMBER  {printf("var_declaration");}
	|  LET_INT VAR_NAME ASSIGNMENT VAR_NAME
        | LET_STRING VAR_NAME ASSIGNMENT STRING_CONST {lineNo = 13; printf("var_declaration");};

var_Assign: VAR_NAME assing_ops VAR_NAME
		| VAR_NAME assing_ops NUMBER
		| VAR_NAME assing_ops STRING_CONST {lineNo = 14; printf("string_Assign");};

CONST_Int_Dec_Assign: CONST VAR_NAME ASSIGNMENT VAR_NAME|
		CONST VAR_NAME ASSIGNMENT NUMBER {lineNo = 15; printf("CONST");};


print_st: PRINT PRINT_OP VAR_NAME | PRINT PRINT_OP NUMBER | PRINT PRINT_OP STRING_CONST {lineNo = 16; printf("print_st");}; 
print_line_st: PRINT_LINE {lineNo = 17; printf("print_line_st");};

//scanner
readCall_sc: READ READ_OP NUMBER
	|READ READ_OP STRING_INNER_STATEMENT {lineNo = 18; printf("readCall_sc");};


// functions
func_call: VAR_NAME PARANT_OPEN parameters PARANT_CLOSE {lineNo = 19; printf("func_call");};

func_def: FUNC VAR_NAME PARANT_OPEN parameters PARANT_CLOSE CURLY_OPEN statements RETURN VAR_NAME CURLY_CLOSE
	|FUNC VAR_NAME PARANT_OPEN parameters PARANT_CLOSE CURLY_OPEN statements RETURN NUMBER CURLY_CLOSE {lineNo = 20; printf("func_def");};


parameters: LET_INT VAR_NAME COMMA parameters
		| LET_STRING VAR_NAME COMMA parameters
                | /* empty parameter token*/ {} {lineNo = 21; printf("parameters");};

expr:    NOT
        | OR
        | AND
        | XOR
        | SMALLER
        | SMALLER_EQUAL
        | LARGER
        | LARGER_EQUAL
        | EQUALS
        | NOT_EQUALS
        | PLUS
        | SUBTRACT
        | MULTIPLY
        | DIVIDE
        | REMAINDER
        | POW {lineNo = 22; printf("expr");};

//arithmetic_ops: VAR_NAME arithmetic_op VAR_NAME
//                  | VAR_NAME arithmetic_op NUMBER
//		|NUMBER arithmetic_op NUMBER {lineNo = 23; printf("arithmetic_ops");};

//arithmetic_op: PLUS
//        | SUBTRACT
//        | MULTIPLY
//        | DIVIDE
//        | REMAINDER
//        | POW {lineNo = 24; printf("arithmetic_op");};

//comparison: VAR_NAME compare VAR_NAME
//                | VAR_NAME compare NUMBER
//		| NUMBER compare NUMBER 
//                | NUMBER compare VAR_NAME {lineNo = 25; printf("comparison");};

//compare: //SMALLER
//        | SMALLER_EQUAL
//        | LARGER
//        | LARGER_EQUAL
//        | EQUALS
//        | NOT_EQUALS {lineNo = 26; printf("compare");};

//bool_OPS:  VAR_NAME bool_OP VAR_NAME
//                | VAR_NAME bool_OP NUMBER
//		| NUMBER bool_OP NUMBER
//                | NUMBER bool_OP VAR_NAME {lineNo = 27; printf("bool_OPS");};

//bool_OP: NOT
//        | OR
//        | AND
//        | XOR {lineNo = 27; printf("bool_OP");};

comment_st: COMMENT STRING_INNER_STATEMENT COMMENT {lineNo = 28; printf("comment_st");};

//arrays
arr_Dec_init: LET_LIST VAR_NAME ASSIGNMENT CURLY_OPEN insideOFList CURLY_CLOSE {lineNo = 29; printf("arr_Dec_init");};
arr_Dec: LET_LIST VAR_NAME {lineNo = 30; printf("arr_Dec");};
arr_INIT: VAR_NAME ASSIGNMENT CURLY_OPEN insideOFList CURLY_CLOSE {lineNo = 31; printf("arr_INIT");};
insideOFList: VAR_NAME COMMA insideOFList
        | VAR_NAME
	| NUMBER
        | NUMBER COMMA insideOFList {lineNo = 32; printf("insideOFList");};

//arraySizeSpecifier_op : LIST_SIZE_SPECIFIER;

Do_In_Loops: incremention
        | decremention 
        | var_Assign {lineNo =33; printf("Do_In_Loops");};

incremention: VAR_NAME INCREMENT 
        | INCREMENT VAR_NAME {lineNo = 34; printf("incremention");};

decremention: VAR_NAME DECREMENT
        | DECREMENT VAR_NAME {lineNo = 35; printf("decremention");};

assing_ops: PLUS_ASSIGN
        | SUBTRACT_ASSIGN
        | DIVIDE_ASSIGN
        | REMAINDER_ASSIGN
        | MULTIPLY_ASSIGN
        | ASSIGNMENT {lineNo = 36; printf("assing_ops");};


%%
#include "lex.yy.c"
int lineNo;
int state = 0;

int main() {
        yyparse();
        if(state == 0){
                printf("Parsing is successfully completed.\n");
        }
        else{
                printf("Parsing is unsuccessful\n" + state);
        }
        return 0;
}
void yyerror( char *s ) { state = -1; fprintf( stderr, "%d: %s\n",lineNo,s); }
