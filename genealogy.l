%option noyywrap

%{
#include <stdio.h>
#include <string.h>
char* comp = " ;";
%}

%s DP PRED IND PPRED
%%
[a-zA-Z0-9_]*\ [;.,]                                                {if(strcmp(comp,yytext) != 0){      //all objects
                                                                        yytext[yyleng-2] = '\0';
                                                                        }
                                                                    }
(^:eMaeDe.*\n{1,2}.*)                                               {BEGIN PPRED;}
<PPRED>(\n[ \t]+:|^:[ a-zA-Z]*rdf:|\t*rdf:|\t*rdfs:|\n[  ]*owl:)    {BEGIN PRED;}
<PRED>[a-zA-Z]+                                                     {BEGIN INITIAL; printf("%s\n",yytext);} /*all predicates*/  
.|\n                                                                { ; }
%%

int main(int argc, char** argv){
    yyin = fopen(argv[1], "r");
    yylex();
    fclose(yyin);
    return 0;
}

