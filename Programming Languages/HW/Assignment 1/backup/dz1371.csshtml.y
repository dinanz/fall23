%{
  #include <cstdio>
  #include <iostream>
  using namespace std;

  // Declare stuff from Flex that Bison needs to know about:
  extern int yylex();
  extern int yyparse();
  extern FILE *yyin;

 
  void yyerror(const char *s);
%}


%union {
  char *sval;
}

%start s
%option yylineno

%token <sval> START_TAG
%token <sval> END_TAG
%token <sval> INDEPENDENT_TAG
%token <sval> START_HTML
%token <sval> END_HTML
%token <sval> START_BODY
%token <sval> END_BODY
%token <sval> START_SCRIPT
%token <sval> END_SCRIPT
%token <sval> OPEN_CURLY
%token <sval> CLOSE_CURLY
%token <sval> COMMA
%token <sval> COLON
%token <sval> SEMICOLON
%token <sval> STRING
%token <sval> COMMENT
%token <sval> SELECTOR1
%token <sval> SELECTOR2
%token <sval> SELECTOR3
%token <sval> SELECTOR4
%token <sval> SELECTOR5
%token <sval> AT_MEDIA
%token <sval> DOCTYPE


%%

s : 
    html        { cout << "This is an HTML file." << endl; }
    | css       { cout << "This is a CSS file." << endl; }
    ;

html : 
    DOCTYPE START_HTML html_blocks START_BODY html_blocks END_BODY html_blocks END_HTML
    ;

html_blocks : 
    html_block html_blocks 
    | html_block 
    ;

html_block:
    INDEPENDENT_TAG 
    | script 
    | START_TAG html_blocks END_TAG 
    | START_TAG END_TAG 
    ;


script :
    START_SCRIPT ignore END_SCRIPT 
    | START_SCRIPT END_SCRIPT 
    ;


ignore :
    string_terminal ignore 
    | string_terminal 
    ;


string_terminal :
    STRING 
    | COMMA
    | COLON
    | SEMICOLON
    | OPEN_CURLY
    | CLOSE_CURLY
    | COMMENT
    ;





css : 
    css_blocks  { cout << "css" << endl; }
    ;

css_blocks : 
    css_block css_blocks    { cout << "css_block css_blocks" << endl; }
    | css_block           { cout << "css_block" << endl; }
    ;

css_block: 
    media_query           { cout << "media_query" << endl; }
    | selector_block      { cout << "selector block" << endl; }
    | COMMENT             { cout << "comment" << endl; }
    ;

selector_block:
    selectors OPEN_CURLY attributes CLOSE_CURLY       { cout << "selector block" << endl; }
    ;

selectors : 
    selector COMMA selectors    { cout << "selectors," << endl; }
    | selector selectors          { cout << "selectors" << endl; }
    | selector                  { cout << "selector" << endl; }
    ;

selector :
    SELECTOR1               { cout << "selector1" << endl; }
    | SELECTOR2             { cout << "selector2" << endl; }
    | SELECTOR3             { cout << "selector3" << endl; }
    | SELECTOR4             { cout << "selector4" << endl; }
    | SELECTOR5             { cout << "selector5" << endl; }
    ;

attributes :
    attribute attributes    { cout << "attribute attributes" << endl; }
    | attribute             { cout << "attribute" << endl; }
    ;

attribute :
    property COLON values SEMICOLON     { cout << "attribute" << endl; }
    | COMMENT       { cout << "comment." << endl; }
    ;

property :
    STRING          { cout << "property" << endl; }
    ;

values :
    values STRING   { cout << "list of values." << endl; }
    | STRING        { cout << "value" << endl; }
    ;
  
media_query:
    AT_MEDIA OPEN_CURLY css_blocks CLOSE_CURLY  { cout << "media query." << endl; }
    ;







%%




int main (int, char**){
  FILE *myfile = fopen("sample-css-input.css", "r");
  if (!myfile) {
    cout << "Error reading file" << endl;
    return -1;
  }

  yyin = myfile;
  yyparse();
  cout << "Parse successful." << endl;
  
}


void yyerror(const char *s){
  cout << "Parse failed." << s << endl;
  exit(-1);
}