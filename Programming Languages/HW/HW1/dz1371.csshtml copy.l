%{
  #include <iostream>
  using namespace std;
  extern int yylex();
%}
%option noyywrap
%%
[ \t]               ;

,                       { cout << "Found a COMMA: " << yytext << endl; }
:                       { cout << "Found a COLON: " << yytext << endl; }
;                       { cout << "Found a SEMICOLON: " << yytext << endl; }
\{                      { cout << "Found a OPEN_CURLY: " << yytext << endl; }
\}                      { cout << "Found a CLOSE_CURLY: " << yytext << endl; }

@media[ ][^\{]+                        { cout << "Found a AT_MEDIA: " << yytext << endl; }

(\.|#|:|::)[a-zA-Z0-9\-_*>]+    { cout << "Found a SELECTOR1: " << yytext << endl; }
[a-zA-Z0-9\-_*>]+::[a-zA-Z0-9\-_*>]+    { cout << "Found a SELECTOR2: " << yytext << endl;}
[.#(::)(:)][a-zA-Z0-9\-_*>]+\[.*\]      { cout << "Found a SELECTOR3: " << yytext << endl; }
[a-zA-Z0-9\-_*>]+\[.*\]         { cout << "Found a SELECTOR4: " << yytext << endl; }
[a-zA-Z0-9\-_*>]+:[a-zA-Z0-9\-_*>()[]]+    { cout << "Found a SELECTOR5: " << yytext << endl; }

(<\!DOCTYPE[^>]*>)        { cout << "Found a DOCTYPE: " << yytext << endl; }
(<[a-zA-Z]+[^>]*\/>)        { cout << "Found an INDEPENDENT_TAG: " << yytext << endl; }
(<html>)                    { cout << "Found a START_HTML: " << yytext << endl; }
(<\/html>)                  { cout << "Found a END_HTML: " << yytext << endl; }
(<body>)                  { cout << "Found a START_BODY: " << yytext << endl; }
(<\/body>)                { cout << "Found a END_BODY: " << yytext << endl; }
(<script)                { cout << "Found a START_SCRIPT: " << yytext << endl; }
(<\/script)                { cout << "Found a END_SCRIPT: " << yytext << endl; }
(<[a-zA-Z]+[^>]*>)        { cout << "Found a START_TAG: " << yytext << endl; }
(<\/[a-zA-Z]+>)           { cout << "Found a END_TAG: " << yytext << endl;}


[/][*].*[*][/]          { cout << "Found a COMMENT: " << yytext << endl;}

[a-zA-Z0-9!@#$%-+=_]+   { cout << "Found a STRING: " << yytext << endl; }
\n                      { cout << "Found a ENDL: " << yytext << endl; };
.                       ;
%%
int main(int, char**) {
  
  // open a file handle to a particular file:
  FILE *myfile = fopen("shortTest.html", "r");
  // make sure it's valid:
  if (!myfile) {
    cout << "Error reading file" << endl;
    return -1;
  }
  // set lex to read from it instead of defaulting to STDIN:
  yyin = myfile;
  
  // lex through the input:
  while(yylex());
}