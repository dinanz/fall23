%{
  #include <iostream>
  using namespace std;
  extern int yylex();
%}
%option noyywrap
%%
[ \t]               ;

,                       { cout << "Found a COMMA: " << yytext << endl; return COMMA;}
:                       { cout << "Found a COLON: " << yytext << endl; return COLON;}
;                       { cout << "Found a SEMICOLON: " << yytext << endl; return SEMICOLON;}
\{                      { cout << "Found a OPEN_CURLY: " << yytext << endl; return OPEN_CURLY;}
\}                      { cout << "Found a CLOSE_CURLY: " << yytext << endl; return CLOSE_CURLY;}

@media[ ][^\{]+                        { cout << "Found a AT_MEDIA: " << yytext << endl; return AT_MEDIA;}

(\.|#|:|::)[a-zA-Z0-9\-_*>]+    { cout << "Found a SELECTOR1: " << yytext << endl; return SELECTOR1;}
[a-zA-Z0-9\-_*>]+::[a-zA-Z0-9\-_*>]+    { cout << "Found a SELECTOR2: " << yytext << endl; return SELECTOR2;}
[.#(::)(:)][a-zA-Z0-9\-_*>]+\[.*\]      { cout << "Found a SELECTOR3: " << yytext << endl; return SELECTOR3;}
[a-zA-Z0-9\-_*>]+\[.*\]         { cout << "Found a SELECTOR4: " << yytext << endl; return SELECTOR4;}
[a-zA-Z0-9\-_*>]+:[a-zA-Z0-9\-_*>()[]]+    { cout << "Found a SELECTOR5: " << yytext << endl; return SELECTOR5;}

(<\!DOCTYPE.*>)        { cout << "Found a DOCTYPE: " << yytext << endl; return DOCTYPE;}
(<html>)                    { cout << "Found a START_HTML: " << yytext << endl;  return START_HTML;}
(<\/html>)                  { cout << "Found a END_HTML: " << yytext << endl; return END_HTML;}
(<body>)                  { cout << "Found a START_BODY: " << yytext << endl; return START_BODY;}
(<\/body>)                { cout << "Found a END_BODY: " << yytext << endl; return END_BODY;}
(<script)                { cout << "Found a START_SCRIPT: " << yytext << endl; return START_SCRIPT;}
(<\/script)                { cout << "Found a END_SCRIPT: " << yytext << endl; return END_SCRIPT;}
(<[a-zA-Z]+[^>]*\/>)        { cout << "Found an INDEPENDENT_TAG: " << yytext << endl; return INDEPENDENT_TAG;}
(<[a-zA-Z]+[^>]*>)        { cout << "Found a START_TAG: " << yytext << endl; return START_TAG;}
(<\/[a-zA-Z]+>)           { cout << "Found a END_TAG: " << yytext << endl; return END_TAG;}


[/][*].*[*][/]          { cout << "Found a COMMENT: " << yytext << endl; return COMMENT;}

[a-zA-Z0-9!@#$%-+=_]+   { cout << "Found a STRING: " << yytext << endl; return STRING;}
\n                      { cout << "Found a ENDL: " << yytext << endl; return ENDL;};
.                       ;
%%
int main(int, char**) {
  
  // open a file handle to a particular file:
  FILE *myfile = fopen("sample-css-input.css", "r");
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