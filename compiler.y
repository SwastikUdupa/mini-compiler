%{
  #include <stdio.h>
  #include<stdlib.h>
  int yyerror();
%}

%token DIGIT PRINT ID

%left '+' '-'
%left '*'

%%

start:	ID '(' ')' '{' stmt '}' {
									printf("Compiled successfully\n");
									exit(0);
								}
		|stmt	{
					printf("Compiled successfully\n");
					exit(0);
				}
	;


stmt:	/*empty*/
		|PRINT '(' expr ')' stmt
		|PRINT '(' ID ')'
		|assignment stmt

	;


expr: expr '+' expr 
	| expr '-' expr 
	| expr '*' expr	 
	| '(' expr ')' 	 
	| DIGIT		
	;

assignment:ID '=' DIGIT 
	;
%%

int yyerror()
{
	printf("Error\n");
	return 0;
}

int main()
{
  yyparse();
  return 1;
}