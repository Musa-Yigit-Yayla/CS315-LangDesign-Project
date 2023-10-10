digit [0-9]
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
parantOpen (
parantClose )
curlyOpen {
curlyClose }
arrBrackOpen [
arrBrackClose ]
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
%%
((let)(mandBlank)(varName)(statementEnd))
(func([ ]+)main([ ]*)(parantOpen)(paramList)(parantClose))
%%
