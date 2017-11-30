%{
  #include <stdio.h>
  #include "y.tab.h"
  int lvl = 0;
  int line_num = -1;
%}

alpha [a-zA-Z]
digit [0-9]

%%


[\t] {return TAB;}
[\n] {
		line_num++;
		FILE *fptr = fopen("line_num.txt", "w");
		fprintf(fptr,"%d", line_num);
		fclose(fptr);
		return NL;}
" "  ;
"+" {return *yytext;}
"-" {return *yytext;}
"*" {return *yytext;}
"/" {return *yytext;}
"print" {return PRINT;}
"int" {return INT;}
"float" {return FLOAT;}
"else" {return ELSE;}
"endif" {
		lvl--;
		FILE *fptr = fopen("if_lvl.txt", "w");
		fprintf(fptr,"%d", lvl);
		fclose(fptr);
		return ENDIF;}
"if" {
	lvl++;
	FILE *fptr = fopen("if_lvl.txt", "w");
	fprintf(fptr,"%d", lvl);
	fclose(fptr);
	return IF;}
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
