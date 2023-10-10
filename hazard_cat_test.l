digit [0-9]
letter [a-z]
letterCap [A-Z]
varName ((letter|letterCap)+(digit*))
blankNewLine ([ \n]+)
statement (([^ \n]+);)
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
innerParam (([^ \n]+),)
endParam (([^ \n]+))
paramList ((optionalNewLine)(optionalBlank)((innerParam)*(optionalBlank))*(endParam)+(optionalBlank)*)
%%
(func([ ]+)main([ ]*)(parantOpen)(paramList)(parantClose))
%%
