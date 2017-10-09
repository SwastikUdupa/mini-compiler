%{
	#include <stdio.h>
%}
lower [a-z]
CAPS [A-Z]
space [ \t\n]
%%
{lower} {printf("%c",yytext[0]- 32);}
{CAPS} {printf("%c",yytext[0]+ 32);}
{space} ECHO;
. ECHO;
%%
int main()
{
    yylex();
    return 0;
}