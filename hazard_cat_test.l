digit [0-9]
negativeOptional ([-]+)
letter [a-z]
letterCap [A-Z]
varName ((letter|letterCap)+(digit*))
blankNewLine ([ \n]+)
statement (([^ \n]+);)
statementEnd ;
assignment =
equals ==
larger >
smaller <
largerEqual >=
smallerEqual <=
increment ++
decrement --
plusEqual +=
minusEqual -=
timesEqual *=
divideEqual /=
modEqual %=
parantOpen [(]
parantClose [)]
curlyOpen [{]
curlyClose [}]
arrBrackOpen [[]
arrBrackClose []]
stringOpen "
stringClose "
comment [#][^\n]*
optionalBlank ([ ]*)
optionalNewLine([\n]*)
optionalNewOrBlank ([ ]*|[\n]*)
mandBlank([ ]+)
innerParam (([^ \n]+),)
endParam (([^ \n]+))
paramList ((optionalNewOrBlank*)((innerParam)*(optionalNewOrBlank)*)*(endParam)+(optionalNewOrBlank)*)
varDeclaration ((let)(mandBlank)({varName})(optionalNewOrBlank)(statementEnd))
constDeclaration
%%
main() {yylex();}
varDeclaration {int yytext;} 
(func([ ]+)main([ ]*)(parantOpen)(paramList)(parantClose))
%%
