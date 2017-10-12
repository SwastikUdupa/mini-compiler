%{
  #include <stdio.h>
  #include<stdlib.h>
  int yyerror();
%}

%token DIGIT PRINT ID IF CASE BREAK SWITCH DEFAULT
%token ELSE


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
    |IF '(' COND ')' '{' stmt '}' el
    | SWITCH '(' ID ')' '{' Case '}' stmt
		|assignment stmt
	;

el:
      stmt
      |ELSE '{' stmt '}' stmt ;

Case :
      | CASE ':' var stmt BREAK ';' Case
      | default
      ;

default:
      DEFAULT ':' stmt BREAK ';' ;

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
	| var
	;

assignment:ID '=' expr
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
