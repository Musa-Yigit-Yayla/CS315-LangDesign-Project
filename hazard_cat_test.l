digit [0-9]
let [a-z]
letCap [A-Z]
blankNewLine ([ \n]+)
statement (([^ \n]+);)
comment [#][^\n]
optionalBlank ([ ]*)
innerParam (([^ \n]+),)
endParam (([^ \n]+))
paramList ((optionalBlank)((innerParam)(optionalBlank))*,(endParam)+(optionalBlank))
%%
(func([ ])main([ ])[(])
%%
