%{
	#include <stdio.h>
	#include "y.tab.h"
    void yyerror(char *);   
%}
MAIN start
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
{number} {printf(" NUMBER ");}
{ifKeyword} {printf(" IF ");}
{elseIfKeyword} {printf(" ELSE_IF ");}
{elseKeyword} {printf(" ELSE ");}
{FOR} {printf(" FOR ");}
{WHILE} {printf(" WHILE ");}
{functionKeyword} {printf(" FUNC ");}
{returnKeyword} {printf(" RETURN ");}
{printCall} {printf(" PRINT ");}
{printLineCall} {printf(" PRINT_LINE ");}
{readCall} {printf(" READ ");}
{printOperator} {printf(" PRINT_OP ");}
{readOperator} {printf(" READ_OP ");}
{statementEnd} {printf(" SEMICOL ");}
{assignment} {printf(" ASSIGNMENT ");}
{equals} {printf(" EQUALS ");}
{notEquals} {printf(" NOT_EQUALS ");}
{not} {printf(" NOT ");}
{or} {printf(" OR ");}
{and} {printf(" AND ");}
{xor} {printf(" XOR ");}
{larger} {printf(" LARGER ");}
{smaller} {printf(" SMALLER ");}
{largerEqual} {printf(" LARGER_EQUAL ");}
{smallerEqual} {printf(" SMALLER_EQUAL ");}
{increment} {printf(" INCREMENT ");}
{decrement} {printf(" DECREMENT ");}
{plusEqual} {printf(" PLUS_ASSIGN");}
{minusEqual} {printf(" SUBTRACT_ASSIGN ");}
{timesEqual} {printf(" MULTIPLY_ASSIGN ");}
{divideEqual} {printf(" DIVIDE_ASSIGN ");}
{modEqual} {printf(" REMAINDER_ASSIGN ");}
{sum} {printf(" PLUS ");}
{subtract} {printf(" SUBTRACT ");}
{multiply} {printf(" MULTIPLY ");}
{divide} {printf(" DIVIDE ");}
{mod} {printf(" REMAINDER ");}
{pow} {printf(" POW ");}
{parantOpen} {printf(" PARANT_OPEN ");}
{parantClose} {printf(" PARANT_CLOSE ");}
{curlyOpen} {printf(" CURLY_OPEN ");}
{curlyClose} {printf(" CURLY_CLOSE ");}
{arrBrackOpen} {printf(" ARR_BRACK_OPEN ");}
{arrBrackClose} {printf(" ARR_BRACK_CLOSE ");}
{stringOpenOrClose} {printf(" STRING_OPEN_OR_CLOSE ");}
{stringConst} {printf(" STRING_CONST ");}
{comment} {printf(" COMMENT ");}
{newLine} {printf(" NEWLINE ");}
{comma} {printf(" COMMA ");}
{intKeyword} {printf(" LET_INT ");}
{stringKeyword} {printf(" LET_STRING ");}
{arrKeyword} {printf(" LET_LIST ");}
{arraySizeSpecifier} {printf(" LIST_SIZE_SPECIFIER ");}
{varName} {printf(" VAR_NAME ");}
%%

int yywrap(void) {
	return 1;
}