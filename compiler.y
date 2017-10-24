%{
  #include <stdio.h>
  #include<stdlib.h>
  int yyerror();
%}

%token DIGIT PRINT ID IF ENDIF ELSE START END TAB IN RANGE FOR ENDFOR


%left '+' '-'
%left '*'

%%

start:	START ID '(' ')' '{' stmt '}' END {
									printf("Compiled successfully\n");
									exit(0);
								}
		|START stmt END	{
					printf("Compiled successfully\n");
					exit(0);
				}

	;

stmt:	/*empty*/
		|PRINT '(' expr ')' stmt
		|PRINT '(' ID ')' stmt
    	|IF '(' COND ')' stmt else ENDIF stmt
    	|FOR ID IN RANGE '(' DIGIT ',' DIGIT ')' stmt ENDFOR stmt
    	|FOR ID IN RANGE '(' DIGIT ')' stmt ENDFOR stmt
    	|FOR ID IN RANGE '(' DIGIT ',' DIGIT ',' DIGIT ')' stmt ENDFOR stmt
		|assignment stmt
	;

else: 	ELSE stmt
		|stmt
	;


COND: DIGIT
      | var '<' var
      | var '>' var
      | var '<''=' var
      | var '>''=' var
      | assignment ;

var : DIGIT 
	| ID 
	;

expr: expr '+' expr
	| expr '-' expr
	| expr '*' expr
	| '(' expr ')'
	| DIGIT
	;

assignment:ID '=' DIGIT
		|ID '=' arr
		|ID '=' dict
	;

arr_ele1:/*empty*/
		|',' DIGIT arr_ele1
	;

arr_ele2:/*empty*/
		|',' ID arr_ele2
	;

arr: '[' DIGIT arr_ele1 ']'
	|'[' ID arr_ele2 ']'
	;

dict_ele1:/*empty*/
		|',' DIGIT ':' ID dict_ele1

dict_ele2:/*empty*/
		|',' DIGIT ':' DIGIT dict_ele2

dict_ele3:/*empty*/
		|',' ID ':' ID dict_ele3

dict_ele4:/*empty*/
		|',' ID ':' DIGIT dict_ele4

dict:'[' DIGIT ':' ID dict_ele1 ']'
	| '[' DIGIT ':' DIGIT dict_ele2 ']'
	| '[' ID ':' ID dict_ele3 ']'
	| '[' ID ':' DIGIT dict_ele4 ']'
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
