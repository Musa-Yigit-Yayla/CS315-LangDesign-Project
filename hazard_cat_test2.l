%{
	#include <stdio.h>
	#include "y.tab.h"
    void yyerror(char *);   
%}
main main
digit [0-9]
number ({digit}+)
negativeOptional ([-]?)
FOR for
WHILE while
ifKeyword if
elseIfKeyword (else_if)
elseKeyword else
arrKeyword list
returnKeyword return
stringKeyword string
intKeyword let
constIntKeyword const
printLineCall (print_line)
printCall (print)
readCall (read)
functionKeyword (func)
letter [a-z]
letterCap [A-Z]
printOperator (<<)
readOperator (>>)
blankNewLine ([ \n]+)
statement (([^ \n]+);)
statementEnd ;
assignment =
equals ==
notEquals !=
not !
or \|\|
and &&
xor \^\^
larger >
smaller <
largerEqual >=
smallerEqual <=
increment \+\+
decrement --
plusEqual \+=
minusEqual -=
timesEqual \*=
divideEqual \/=
modEqual %=
sum \+
subtract -
multiply \*
divide \/
mod %
pow \^
newLine (\n)
arithmeticOperator ({sum}|{subtract}|{multiply}|{divide}|{mod}|{pow})
boolOperator ({not}|{or}|{and}|{xor})
parantOpen [(]
parantClose [)]
curlyOpen [{]
curlyClose [}]
arrBrackOpen [[]
arrBrackClose []]
stringOpenOrClose ["]
stringInnerStatement (((([.]*)({newLine})*))*)
stringConst ("({stringInnerStatement})")
comment ([#](([^(\n)])*)(\n))
comma ,
arraySizeSpecifier ~ 
optionalBlank ([ ]*)
optionalNewLine([\n]*)
optionalNewOrBlank ([ ]*|[\n]*)
mandBlank([ ]+)
varName (({letter}|{letterCap})+({digit}*))
innerParam ({varName},)
endParam ({varName})
paramList (({optionalNewOrBlank}*)(({innerParam})*({optionalNewOrBlank})*)*({endParam})+({optionalNewOrBlank})*)
varDeclaration ((let)({mandBlank})({varName})({optionalNewOrBlank})({statementEnd}))
varAssign ({varName})({assignment})({optionalBlank})({digit})+({optionalNewOrBlank})({statementEnd})
varDecAssign ((let)({mandBlank})({varAssign}))
constIntDecAssign ((const)({mandBlank})({varName})({optionalBlank})({assignment})({negativeOptional})({digit}+)({optionalNewOrBlank})({statementEnd}))
constStringDecAssign (string)({mandBlank})({varName})({optionalBlank})({assignment})({optionalBlank})({stringConst})({optionalNewOrBlank})({statementEnd})
arrDec (({arrKeyword})({mandBlank})({arrName})({optionalNewOrBlank})({statementEnd}))
%%
{number} {return NUMBER;}
{ifKeyword} {return IF;}
{elseIfKeyword} {return ELSE_IF;}
{elseKeyword} {return ELSE;}
{FOR} {return FOR;}
{WHILE} {return WHILE;}
{functionKeyword} {return FUNC;}
{returnKeyword} {return RETURN;}
{printCall} {return PRINT;}
{printLineCall} {return PRINT_LINE;}
{readCall} {return READ;}
{printOperator} {return PRINT_OP;}
{readOperator} {return READ_OP;}
{statementEnd} {return SEMICOL;}
{assignment} {return ASSIGNMENT;}
{equals} {return EQUALS;}
{notEquals} {return NOT_EQUALS;}
{not} {return NOT;}
{or} {return OR;}
{and} {return AND;}
{xor} {return XOR;}
{larger} {return LARGER;}
{smaller} {return SMALLER;}
{largerEqual} {return LARGER_EQUAL;}
{smallerEqual} {return SMALLER_EQUAL;}
{increment} {return INCREMENT;}
{decrement} {return DECREMENT;}
{plusEqual} {return PLUS_ASSIGN;}
{minusEqual} {return SUBTRACT_ASSIGN;}
{timesEqual} {return MULTIPLY_ASSIGN;}
{divideEqual} {return DIVIDE_ASSIGN;}
{modEqual} {return REMAINDER_ASSIGN;}
{sum} {return PLUS;}
{subtract} {return SUBTRACT;}
{multiply} {return MULTIPLY;}
{divide} {return DIVIDE;}
{mod} {return REMAINDER;}
{pow} {return POW;}
{parantOpen} {return PARANT_OPEN;}
{parantClose} {return PARANT_CLOSE;}
{curlyOpen} {return CURLY_OPEN;}
{curlyClose} {return CURLY_CLOSE;}
{arrBrackOpen} {return ARR_BRACK_OPEN;}
{arrBrackClose} {return ARR_BRACK_CLOSE;}
{stringOpenOrClose} {return STRING_OPEN_OR_CLOSE;}
{stringConst} {return STRING_CONST;}
{comment} {return COMMENT;}
{newLine} {return NEWLINE;}
{comma} {return COMMA;}
{intKeyword} {return LET_INT;}
{stringKeyword} {return LET_STRING;}
{arrKeyword} {return LET_LIST;}
{arraySizeSpecifier} {return LIST_SIZE_SPECIFIER;}
{varName} {return VAR_NAME;}
{main} {return MAIN;}
%%

int yywrap(void) {
	return 1;
}
