%{
  #include <cstdio>
  #include <iostream>
  #define YYDEBUG 1
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

%token <sval> DOCTYPE
%token <sval> INDEPENDENT_TAG
%token <sval> ATTRIBUTE
%token <sval> OPEN_CURLY
%token <sval> CLOSE_CURLY
%token <sval> COMMA
%token <sval> COLON
%token <sval> SEMICOLON
%token <sval> COMMENT
%token <sval> START_HTML
%token <sval> END_HTML
%token <sval> START_BODY
%token <sval> END_BODY
%token <sval> START_SCRIPT
%token <sval> END_SCRIPT
%token <sval> START_TAG
%token <sval> END_TAG
%token <sval> SELECTOR1
%token <sval> SELECTOR2
%token <sval> SELECTOR3
%token <sval> SELECTOR4
%token <sval> SELECTOR5
%token <sval> AT_MEDIA
%token <sval> STRING


%%

s : 
    html        { cout << "This is an HTML file." << endl; }
    | css       { cout << "This is a CSS file." << endl; }
    ;

html : 
    DOCTYPE START_HTML html_blocks START_BODY html_blocks END_BODY html_blocks END_HTML
    | DOCTYPE START_HTML START_BODY html_blocks END_BODY html_blocks END_HTML
    | DOCTYPE START_HTML START_BODY html_blocks END_BODY END_HTML
    | DOCTYPE START_HTML html_blocks START_BODY html_blocks END_BODY END_HTML
    ;

html_blocks : 
    html_block html_blocks 
    | html_block 
    ;

html_block:
    START_TAG inner_html END_TAG
    | START_TAG END_TAG 
    | INDEPENDENT_TAG 
    | script 
    ;
  
inner_html:
    html_blocks
    | html_blocks ignore
    | ignore html_blocks
    | ignore html_blocks ignore
    | ignore
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
    | SELECTOR1
    | SELECTOR2
    | SELECTOR3
    | SELECTOR4
    | SELECTOR5
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
    | STRING                { cout << "STRING" << endl; }
    ;

attributes :
    ATTRIBUTE attributes    { cout << "attribute attributes" << endl; }
    | ATTRIBUTE             { cout << "attribute" << endl; }
    ;


  
media_query:
    AT_MEDIA OPEN_CURLY css_blocks CLOSE_CURLY  { cout << "media query." << endl; }
    ;







%%




int main (int, char**){

  #ifdef YYDEBUG
    yydebug = 1;
  #endif

  FILE *myfile = fopen("shortTest.css", "r");
  if (!myfile) {
    cout << "Error reading file" << endl;
    return -1;
  }

  yyin = myfile;
  yyparse();
  cout << "Parse successful." << endl;
  
  

}


void yyerror(const char *s){
  cout << "Parse failed: " << s << endl;
  exit(-1);
}