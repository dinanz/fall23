%{
  #include <iostream>
  #include "dz1371.csshtml.tab.h"
  using namespace std;
  extern int yylex();
%}
%option noyywrap
%%
[ \t]               ;

,                       { return COMMA;}
:                       { return COLON;}
;                       { return SEMICOLON;}
\{                      { return OPEN_CURLY;}
\}                      { return CLOSE_CURLY;}

@media[ ][^\{]+            {return AT_MEDIA;}

(\.|#|:|::)[a-zA-Z0-9\-_*>]+    { return SELECTOR1;}
[a-zA-Z0-9\-_*>]+::[a-zA-Z0-9\-_*>]+    { return SELECTOR2;}
[.#(::)(:)][a-zA-Z0-9\-_*>]+\[.*\]      { return SELECTOR3;}
[a-zA-Z0-9\-_*>]+\[.*\]         { return SELECTOR4;}
[a-zA-Z0-9\-_*>]+:[a-zA-Z0-9\-_*>()[]]+    { return SELECTOR5;}

(<\!DOCTYPE.*>)        { return DOCTYPE;}
(<html>)                    {  return START_HTML;}
(<\/html>)                  { return END_HTML;}
(<body>)                  { return START_BODY;}
(<\/body>)                { return END_BODY;}
(<script)                { return START_SCRIPT;}
(<\/script)                { return END_SCRIPT;}
(<[a-zA-Z]+[^>]*\/>)        { return INDEPENDENT_TAG;}
(<[a-zA-Z]+[^>]*>)        { return START_TAG;}
(<\/[a-zA-Z]+>)           { return END_TAG;}


[/][*].*[*][/]          { return COMMENT;}

[a-zA-Z0-9!@#$%-+=_]+   { return STRING;}
[ \n\t]                      ;
.                       ;
%%
