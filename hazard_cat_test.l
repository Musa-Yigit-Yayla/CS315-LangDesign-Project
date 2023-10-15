%option main

digit [0-9]
negativeOptional ([-]?)
for for
while while
if if
elseIf elif
else else
arrKeyword list
stringKeyword string
intKeyword let
constIntKeyword const
letter [a-z]
letterCap [A-Z]
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
divideEqual /=
modEqual %=
sum \+
subtract -
multiply \*
divide /
mod %
pow \^\^
arithmeticOperator ({sum}|{subtract}|{multiply}|{divide}|{mod}|{pow})
boolOperator ({not}|{or}|{and}|{xor})
parantOpen [(]
parantClose [)]
curlyOpen [{]
curlyClose [}]
arrBrackOpen [[]
arrBrackClose []]
stringOpen "
stringClose "
stringConst ("[.]+")
comment ([#]([^(\n)]*))|([#])
newLine (\n)
comma ,
optionalBlank ([ ]*)
optionalNewLine([\n]*)
optionalNewOrBlank ([ ]*|[\n]*)
mandBlank([ ]+)
varName (({letter}|{letterCap})+({digit}*))
arrName (({letter}|{letterCap})+({digit}*))
innerParam ({varName},)
endParam ({varName})
paramList (({optionalNewOrBlank}*)(({innerParam})*({optionalNewOrBlank})*)*({endParam})+({optionalNewOrBlank})*)
varDeclaration ((let)({mandBlank})({varName})({optionalNewOrBlank})({statementEnd}))
varAssign ({varName})({assignment})({optionalBlank})({digit})+({optionalNewOrBlank})({statementEnd})
varDecAssign ((let)({mandBlank})({varAssign}))
constIntDecAssign ((const)({mandBlank})({varName})({optionalBlank})({assignment})({negativeOptional})({digit}+)({optionalNewOrBlank})({statementEnd}))
constStringDecAssign (string)({mandBlank})({varName})({optionalBlank})({assignment})({optionalBlank})({stringConst})({optionalNewOrBlank})({statementEnd})
arrDec (({arrKeyword})({mandBlank})({arrName})({optionalNewOrBlank})({statementEnd}))
arraySizeSpecifier ~ 
%%
{digit} printf(" DIGIT ");
{if} printf(" IF ");
{elseIf} printf(" ELSE_IF ");
{else} printf(" ELSE ");
{for} printf(" FOR ");
{while} printf(" WHILE ");
{varName} printf(" VAR_NAME ");
{statementEnd} printf(" SEMICOL ");
{assignment} printf(" ASSIGNMENT ");
{equals} printf(" EQUALS ");
{notEquals} printf(" NOT_EQUALS ");
{not} printf(" NOT ");
{or} printf(" OR ");
{and} printf(" AND ");
{XOR} PRİNTF(" XOR ");
{larger} printf(" LARGER ");
{smaller} printf(" SMALLER ");
{largerEqual} printf(" LARGER_EQUAL ");
{smallerEqual} printf(" SMALLER_EQUAL ");
{increment} printf(" INCREMENT ");
{decrement} printf(" DECREMENT ");
{plusEqual} printf(" PLUS_ASSIGN");
{minusEqual} printf(" SUBTRACT_ASSIGN ");
{timesEqual} printf(" MULTIPLY_ASSIGN ");
{divideEqual} printf(" DIVIDE_ASSIGN");
{modEqual} printf(" REMAINDER_ASSIGN ");
{sum} printf(" PLUS ");
{subtract} printf(" SUBTRACT ");
{multiply} printf(" MULTIPLY ");
{divide} printf(" DIVIDE ");
{mod} printf(" REMAINDER ");
{pow} printf(" POW ");
{parantOpen} printf(" PARANT_OPEN ");
{parantClose} printf(" PARANT_CLOSE ");
{curlyOpen} printf(" CURLY_OPEN ");
{curlyClose} printf(" CURLY_CLOSE ");
{arrBrackOpen} printf(" ARR_BRACK_OPEN ");
{arrBrackClose} printf(" ARR_BRACK_CLOSE ");
{stringOpen} printf(" STRING_OPEN ");
{stringClose} printf(" STRING_CLOSE ");
{stringConst} printf(" STRING_CONST ");
{comment} printf(" COMMENT ");
{newLine} printf(" NEWLINE ");
{comma} printf(" COMMA ");
{intKeyword} printf(" LET_INT ");
{stringKeyword} printf(" LET_STRING ");
{arrKeyword} printf(" LET_LIST ");
{arraySizeSpecifier} printf(" LIST_SIZE_SPECIFIER ");
%%
