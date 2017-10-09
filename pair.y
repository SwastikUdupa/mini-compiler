%{
	#include <stdio.h>	
	#include <stdlib.h>
	int yyerror();
%}

%token DIGIT NEWLINE

%left '+'
%left '*'

%%

start:expr NEWLINE {printf("Expression after completion is %d\n", $$);
					exit(1);}
;

expr:expr '+' expr {$$=$1+$3;}
	|expr '*' expr {$$=$1*$3;}
	|'(' expr ')' {$$=$3;}
	|DIGIT {$$=$1;}
;

%%

int yyerror()
{
	printf("Error");	
	return 0;
}
int main()
{
	yyparse();
	return 1;
}