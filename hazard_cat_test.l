digit [0-9]
negativeOptional ([-]?)
letter [a-z]
letterCap [A-Z]
varName (({letter}|{letterCap})+({digit}*))
arrName (({letter}|{letterCap})+({digit}*))
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
timesEqual *=
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
comment [#][^\n]*
optionalBlank ([ ]*)
optionalNewLine([\n]*)
optionalNewOrBlank ([ ]*|[\n]*)
mandBlank([ ]+)
innerParam (([^ \n]+),)
endParam (([^ \n]+))
paramList (({optionalNewOrBlank}*)(({innerParam})*({optionalNewOrBlank})*)*({endParam})+({optionalNewOrBlank})*)
varDeclaration ((let)({mandBlank})({varName})({optionalNewOrBlank})({statementEnd}))
varAssign ({varName})({assignment})({optionalBlank})({digit})+({optionalNewOrBlank})({statementEnd})
varDecAssign ((let)({mandBlank})({varAssign}))
constIntDecAssign ((const)({mandBlank})({varName})({optionalBlank})({assignment})({negativeOptional})({digit}+)({optionalNewOrBlank})({statementEnd}))
constStringDecAssign (string)({mandBlank})({varName})({optionalBlank})({assignment})({optionalBlank})({stringConst})({optionalNewOrBlank})({statementEnd})
arrKeyword list
arrDeclaration (({arrKeyWord})({mandBlank})({arrName})({optionalNewOrBlank})({statementEnd})) 
%%
main() {yylex();}
varDeclaration {int yytext;} 
(func([ ]+)main([ ]*)(parantOpen)(paramList)(parantClose))
%%
