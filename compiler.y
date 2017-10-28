 %{
  #include <stdio.h>
  #include <string.h>
  #include <stdlib.h>
  int yyerror();

  int table[100],i,count[100] = {0};
  char symbol[100][100], temp[100];
  char* test;
  struct
  {
  	int t[100];
  	char s[100][100];
  }levels[1000];

%}

%union { char* str;}

%type<str> ID



%token DIGIT PRINT ID IF ENDIF ELSE START END TAB IN RANGE FOR ENDFOR FLOAT_DIGIT NL FLOAT INT


%left '+' '-'
%left '*'

%%

start:	START ID '(' ')' newline '{' newline stmt newline '}' END 	{
																			FILE *fptr = fopen("if_lvl.txt", "w");
																			fprintf(fptr, "0");
																			fclose(fptr);
																			printf("Compiled successfully\n");
																			exit(0);
																	}
		|START newline stmt END			{
											FILE *fptr = fopen("if_lvl.txt", "w");
											fprintf(fptr, "0");
											fclose(fptr);
											printf("Compiled successfully\n");
											exit(0);
										}

	;

stmt:	assignment newline
		|PRINT '(' expr ')' newline
		|PRINT '(' expr ')' newline stmt
		|PRINT '(' ID ')' newline
		|PRINT '(' ID ')' newline stmt
		|IF '(' COND ')' newline stmt else ENDIF newline stmt{}
		|IF '(' COND ')' newline stmt else ENDIF newline
    	|IF '(' COND ')' newline stmt ENDIF newline stmt{}
    	|IF '(' COND ')' newline stmt ENDIF newline
		|assignment newline stmt
	;

else: 	ELSE newline stmt
	

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
	FILE *fptr = fopen("if_lvl.txt", "w");
	fprintf(fptr, "0");
	fclose(fptr);
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
	int flag = 0;
	int lvl = lvl_check();
	for(i=0;i<count[lvl];i++)
	{
		if(strcmp(temp, levels[lvl].s[i])==0)
		{
			if(levels[lvl].t[i]==x)
				printf("Redecleration of variable\n");
			else
				printf("Multiple decleration of variable\n");
			flag = 1;
		}
	}
	if(flag == 0)
	{
		strcpy(levels[lvl].s[count[lvl]], temp);
		levels[lvl].t[count[lvl]] = x;
		count[lvl]++;
	}
}
int lvl_check()
{
	int lvl;
	FILE *fptr = fopen("if_lvl.txt", "r");
	char ch = fgetc(fptr);
	lvl = ch-'0';
	fclose(fptr);
	return lvl;
}

