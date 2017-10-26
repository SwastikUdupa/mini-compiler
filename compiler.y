%{
  #include <stdio.h>
  #include <string.h>
  #include <stdlib.h>
  int yyerror();

  int table[100],i,count=0;
  int overall_level = 0;
  char symbol[100][100], temp[100];
  char* test;
  struct
  {
  	int t[100];
  	int s[100];
  }levels[1000];

%}

%union { char* str; }

%type<str> ID


%token DIGIT PRINT ID IF ENDIF ELSE START END TAB IN RANGE FOR ENDFOR FLOAT_DIGIT NL FLOAT INT


%left '+' '-'
%left '*'

%%

start:	START ID '(' ')' newline '{' newline stmt newline '}' END 	{
																			printf("Compiled successfully\n");
																			exit(0);
																	}
		|START newline stmt END			{
											printf("Compiled successfully\n");
											exit(0);
										}

	;

stmt:	assignment newline
		|PRINT '(' expr ')' newline
		|PRINT '(' expr ')' newline stmt
		|PRINT '(' ID ')' newline
		|PRINT '(' ID ')' newline stmt
		|IF '(' COND ')' newline stmt newline else ENDIF newline
    	|IF '(' COND ')' newline stmt newline else ENDIF newline stmt
		|assignment newline stmt
	;

else: 	ELSE stmt
		|newline stmt
	;

newline: NL newline
		|NL

COND: DIGIT
      | var '<' var
      | var '>' var
      | var '<''=' var
      | var '>''=' var
      | var '=''=' var

var :DIGIT
	|FLOAT_DIGIT
	|ID
	;

expr: expr '+' expr
	| expr '-' expr
	| expr '*' expr
	| '(' expr ')'
	| DIGIT
	| FLOAT_DIGIT
	;

assignment:INT int_assign
		  |FLOAT float_assign
		  |FLOAT ID '=' arr
		  |INT ID '=' arr
		  |ID '=' dict
	;

int_assign:ID '=' DIGIT 							{strcpy(temp, (char*)$1);insert(0);}
		  |int_assign ',' ID '=' DIGIT 				{strcpy(temp, (char*)$3);insert(0);}
		  |int_assign ',' ID 						{strcpy(temp, (char*)$3);insert(0);}
		  |ID 										{strcpy(temp, (char*)$1);insert(0);}
	;

float_assign:float_assign ',' ID '=' FLOAT_DIGIT	{strcpy(temp, (char*)$3);insert(1);}
		|float_assign ',' ID '=' DIGIT				{strcpy(temp, (char*)$3);insert(1);}
		| ID '=' FLOAT_DIGIT 						{strcpy(temp, (char*)$1);insert(1);}
		| ID '=' DIGIT 								{strcpy(temp, (char*)$1);insert(1);}
		| float_assign ',' ID 						{strcpy(temp, (char*)$3);insert(1);}
		| ID 										{strcpy(temp, (char*)$1);insert(1);}
	;

arr_ele1: ID
		|ID ',' arr_ele1


arr_ele2:DIGIT
		|DIGIT ',' arr_ele2
	;

arr: '[' arr_ele1 ']'
	|'[' arr_ele2 ']'
	;

dict_ele1:DIGIT ':' ID dict_ele1
		|DIGIT ':' ID

dict_ele2:DIGIT ':' DIGIT dict_ele2
		|DIGIT ':' DIGIT

dict_ele3:ID ':' ID dict_ele3
		|ID ':' ID

dict_ele4:ID ':' DIGIT dict_ele4
		|ID ':' DIGIT


dict:'{' dict_ele1 '}'
	| '{' dict_ele2 '}'
	| '{' dict_ele3 '}'
	| '{' dict_ele4 '}'
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
int insert(int x)
{
  printf("variable name: %s\n",temp);
	int i=0, flag = 0, eq_flag = 0;
	char temp2[100];
	while(temp[i]!='\0')
	{
		if(temp[i]=='=')
			break;
		temp2[i] = temp[i];
		i++;
	}
	for(i=0;i<count;i++)
	{
		if(strcmp(temp2, symbol[i])==0)
		{
			if(table[i]==x)
				printf("Redecleration of variable\n");
			else
				printf("Multiple decleration of variable\n");
			flag = 1;
		}
	}
	if(flag == 0)
	{
		strcpy(symbol[count], temp2);
		table[count] = x;
		count++;
	}
}

