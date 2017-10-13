%{
  #include <stdio.h>
  #include "y.tab.h"
%}

alpha [a-zA-Z]
digit [0-9]

%%

[\t] ;
[\n] ;
"+" {return *yytext;}
"-" {return *yytext;}
"*" {return *yytext;}
"/" {return *yytext;}
"print" {return PRINT;}
"else" {return ELSE;}
"if" {return IF;}
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
