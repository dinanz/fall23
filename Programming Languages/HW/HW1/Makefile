all: csshtml-parser

dz1371.csshtml.tab.c dz1371.csshtml.tab.h: dz1371.csshtml.y
	bison -d -v dz1371.csshtml.y

lex.yy.c: dz1371.csshtml.l dz1371.csshtml.tab.h
	flex dz1371.csshtml.l

csshtml-parser: lex.yy.c dz1371.csshtml.tab.c dz1371.csshtml.tab.h
	g++ dz1371.csshtml.tab.c lex.yy.c -o csshtml-parser