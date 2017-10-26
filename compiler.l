%{
  #include <stdio.h>
  #include "y.tab.h"
%}

alpha [a-zA-Z]
digit [0-9]

%%

[\t] {return TAB;}
[\n] {return NL;}
" "  ;
"+" {return *yytext;}
"-" {return *yytext;}
"*" {return *yytext;}
"/" {return *yytext;}
"print" {return PRINT;}
"int" {return INT;}
"float" {return FLOAT;}
"else" {return ELSE;}
"endif" {return ENDIF;}
"if" {return IF;}
"endfor" {return ENDFOR;}
"end" {return END;}
"for" {return FOR;}
"in" {return IN;}
"range" {return RANGE;}
"start" {return START;}
{digit}+"."{digit}+ {return FLOAT_DIGIT;}
{digit}+ {return DIGIT;}
{alpha}({alpha}|{digit})* {yylval.str=strdup(yytext);
						   return ID;}

\/\/.* ;
\/\*(.*\n)*.*\*\/ ;
. {return *yytext;}

%%

yywrap()
{
	return 1;
}

