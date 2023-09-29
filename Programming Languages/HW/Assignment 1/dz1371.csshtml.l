%{
  #include <iostream>
  #include "dz1371.csshtml.tab.h"
  using namespace std;
  extern int yylex();
%}
%option noyywrap
%%
[ \t]               ;

,                       { yylval.sval = strdup(yytext); return COMMA;}
:                       { yylval.sval = strdup(yytext); return COLON;}
;                       { yylval.sval = strdup(yytext); return SEMICOLON;}
\{                      { yylval.sval = strdup(yytext); return OPEN_CURLY;}
\}                      { yylval.sval = strdup(yytext); return CLOSE_CURLY;}

@media[ ][^\{]+            { yylval.sval = strdup(yytext); return AT_MEDIA;}

[a-zA-Z0-9!@#$%-+=_]+:([ ]([a-zA-Z0-9!@#$%-+=_]+))+; { yylval.sval = strdup(yytext); return ATTRIBUTE;}


(\.|#|:|::)[a-zA-Z0-9\-_*>]+    { yylval.sval = strdup(yytext); return SELECTOR1;}
[a-zA-Z0-9\-_*>]+::[a-zA-Z0-9\-_*>]+    { yylval.sval = strdup(yytext); return SELECTOR2;}
[.#(::)(:)][a-zA-Z0-9\-_*>]+\[.*\]      { yylval.sval = strdup(yytext); return SELECTOR3;}
[a-zA-Z0-9\-_*>]+\[.*\]         { yylval.sval = strdup(yytext); return SELECTOR4;}
[a-zA-Z0-9\-_*>]+:[a-zA-Z0-9\-_*>()[]]+    { yylval.sval = strdup(yytext); return SELECTOR5;}

(<\!DOCTYPE[^>]*>)        { yylval.sval = strdup(yytext); return DOCTYPE;}
(<[a-zA-Z]+[^>]*\/>)        { yylval.sval = strdup(yytext); return INDEPENDENT_TAG;}
(<html>)                    { yylval.sval = strdup(yytext);  return START_HTML;}
(<\/html>)                  { yylval.sval = strdup(yytext); return END_HTML;}
(<body>)                  { yylval.sval = strdup(yytext); return START_BODY;}
(<\/body>)                { yylval.sval = strdup(yytext); return END_BODY;}
(<script)                { yylval.sval = strdup(yytext); return START_SCRIPT;}
(<\/script)                { yylval.sval = strdup(yytext); return END_SCRIPT;}
(<[a-zA-Z]+[^>]*>)        { yylval.sval = strdup(yytext); return START_TAG;}
(<\/[a-zA-Z]+>)           { yylval.sval = strdup(yytext); return END_TAG;}


[/][*].*[*][/]          { yylval.sval = strdup(yytext); return COMMENT;}

[a-zA-Z0-9!@#$%-+=_]+   { yylval.sval = strdup(yytext); return STRING;}
[ \n\t]                      ;
.                       ;
%%
