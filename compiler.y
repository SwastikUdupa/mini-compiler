%{
  #include <stdio.h>
  #include<stdlib.h>
  int yyerror();
%}
<<<<<<< HEAD

%token DIGIT PRINT ID IF
||||||| merged common ancestors

%token DIGIT PRINT ID
=======
%token DIGIT PRINT ID IF
>>>>>>> 161a7a5e0a6c3e4e184899e3fb47034c0ef20ea5

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



stmt:
		|PRINT '(' expr ')' stmt
		|PRINT '(' ID ')'
    |IF '(' COND ')' '{' stmt '}' stmt
		|assignment stmt
	;

COND: DIGIT
      | var '<' var
      | var '>' var
      | var '<''=' var
      | var '>''=' var
      | assignment ;

var : DIGIT | ID ;

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
	printf("Syntax Error\n");
	return 0;
}

int main()
{
  yyparse();
  return 1;
}
