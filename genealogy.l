%option noyywrap

%{
#include <stdio.h>
#include <string.h>
char* comp = " ;";
%}

%s DP PRED IND
%%
[a-zA-Z0-9_]*\ [;.,]                                               {if(strcmp(comp,yytext) != 0){      //objects
                                                                        yytext[yyleng-2] = '\0';
                                                                        printf("Object:%s\n", yytext);
                                                                        }
                                                                    }
(^:[ a-zA-Z]*rdf:|\t*rdf:|\t*rdfs:|\t+owl:)                         {BEGIN PRED;}
<PRED>[a-zA-Z]+                                                     {BEGIN INITIAL; printf("%s\n",yytext); //preds (nao apanha os owls) 
                                                                    }  
.|\n                                                                { ; }
%%

int main(int argc, char** argv){
    yyin = fopen(argv[1], "r");
    yylex();
    fclose(yyin);
    return 0;
}

