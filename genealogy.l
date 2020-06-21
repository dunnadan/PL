%option noyywrap

%{
#include <stdio.h>
#include <string.h>
%}

%s DP

%%

^:                                  {BEGIN DP;}
<DP>[a-zA-Z]*/.*:ObjectProperty     {BEGIN INITIAL; printf("%s\n", yytext);}
.|\n                                { ; }

%%

int main(int argc, char** argv){
    yyin = fopen(argv[1], "r");
    yylex();
    fclose(yyin);
    return 0;
}
