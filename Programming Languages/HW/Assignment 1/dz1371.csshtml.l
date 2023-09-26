%{
  #include <iostream>
  using namespace std;
  extern int yylex();
%}
%option noyywrap
%%
[ \t\n]           ;
[a-zA-Z0-9-]+:[ ].+;    { cout << "Found an ATTRIBUTE: " << yytext << endl; }
([#.]|::|:)?[a-zA-Z0-9\-_*>]+((::?.*)|(\[.*\]))?,?    { cout << "Found a SELECTOR: " << yytext << endl; }
@media            { cout << "Found a MEDIA: " << yytext << endl; }
\(.*\)              { cout << "Found a MEDIA_QUERY: " << yytext << endl; }
\{                 { cout << "Found a OPEN_CURLY: " << yytext << endl; }
\}                 { cout << "Found a CLOSE_CURLY: " << yytext << endl; }
[/][*].*[*][/]                 { cout << "Found a COMMENT: " << yytext << endl; }
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