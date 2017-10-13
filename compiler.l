%{
  #include <stdio.h>
  #include "y.tab.h"
%}

alpha [a-zA-Z]
digit [0-9]

%%

[\t] {return TAB;}
[\n] ;
" "  ;
"+" {return *yytext;}
"-" {return *yytext;}
"*" {return *yytext;}
"/" {return *yytext;}
"print" {return PRINT;}
"else" {return ELSE;}
"endif" {return ENDIF;}
"if" {return IF;}
"endfor" {return ENDFOR;}
"end" {return END;}
"for" {return FOR;}
"in" {return IN;}
"range" {return RANGE;}
"start" {return START;}
{digit}+ {return DIGIT;}
{alpha}({alpha}|{digit})* {return ID;}

\/\/.* ;
\/\*(.*\n)*.*\*\/ ;
. {return *yytext;}

%%

yywrap()
{
	return 1;
}
