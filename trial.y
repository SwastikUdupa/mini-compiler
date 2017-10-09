%{
	#include <stdio.h>	
%}

%token NEWLINE DIGIT

%%

start: expr NEWLINE {
					printf("\nComplete\n");
					exit(1);
					}
;

expr: expr '+' expr {printf("+ ");}
	| expr '-' expr {printf("- ");}
	| '(' expr ')'
	| DIGIT {printf("%d ", $1);}
;

%%

void yyerror(char const *c)
{
	printf("yerror %s\n", c);
	return ;
}

int main()
{
	yyparse();
	return 1;
}