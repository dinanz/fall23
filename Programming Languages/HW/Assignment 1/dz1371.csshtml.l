%{
  #include <iostream>
  using namespace std;
  extern int yylex();
%}
%option noyywrap
%%
[ \t\n]           ;
[0-9]+\.[0-9]+    { cout << "Found a float: " << yytext << endl; }
[0-9]+            { cout << "Found an int: " << yytext << endl; }
[a-zA-Z0-9]+      { cout << "Found a string: " << yytext << endl; }
:                   { cout << "Found a symbol: " << yytext << endl; }
;                   { cout << "Found a symbol: " << yytext << endl; }
[                   { cout << "Found a symbol: " << yytext << endl; }
]                   { cout << "Found a symbol: " << yytext << endl; }
\{                   { cout << "Found a symbol: " << yytext << endl; }
\}                   { cout << "Found a symbol: " << yytext << endl; }
=                   { cout << "Found a symbol: " << yytext << endl; }
'                   { cout << "Found a symbol: " << yytext << endl; }
-                   { cout << "Found a symbol: " << yytext << endl; }
#                   { cout << "Found a symbol: " << yytext << endl; }
>                   { cout << "Found a symbol: " << yytext << endl; }
<                   { cout << "Found a symbol: " << yytext << endl; }
!                   { cout << "Found a symbol: " << yytext << endl; }
@                   { cout << "Found a symbol: " << yytext << endl; }
_                   { cout << "Found a symbol: " << yytext << endl; }
\*                   { cout << "Found a symbol: " << yytext << endl; }
/\*.*\*/                   { cout << "Found a comment: " << yytext << endl; }
%%
int main(int, char**) {
  
  // open a file handle to a particular file:
  FILE *myfile = fopen("shortTest.css", "r");
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