%{
  #include <stdio.h>
  #include "y.tab.h"
  int lvl = 0;
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
"while" {
      lvl++;
      FILE *fptr = fopen("if_lvl.txt", "w");
      fprintf(fptr,"%d", lvl);
      fclose(fptr);
      return WHILE;}
"endwhile"  {
      lvl--;
      FILE *fptr = fopen("if_lvl.txt", "w");
      fprintf(fptr,"%d", lvl);
      fclose(fptr);
      return ENDWHILE;}
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
"end" {return END;}
"for" {
      lvl++;
      FILE *fptr = fopen("if_lvl.txt", "w");
      fprintf(fptr,"%d", lvl);
      fclose(fptr);
      return FOR;
}
"in" {return IN;}
"range" {return RANGE;}
"endfor"  {
        lvl--;
        FILE *fptr = fopen("if_lvl.txt", "w");
        fprintf(fptr,"%d", lvl);
        fclose(fptr);
        return ENDFOR;}

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
