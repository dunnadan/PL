%option noyywrap

%{
#include <stdio.h>
#include <string.h>
char* comp = " ;";
%}

%s INDIVIDUO PAI MAE
%%
^:                                                              {BEGIN INDIVIDUO;}
<INDIVIDUO>[a-zA-Z]*_([a-zA-Z*_?])+([0-9]{4})?/[  ]rdf:         {BEGIN INITIAL; 
                                                                 return SUBJECT;}
[ \t]*":temMae :"                                               {BEGIN MAE;}
<MAE>([a-zA-Z]*_)+([0-9]{4})?\ [;.,]                            {BEGIN INITIAL;
                                                                 if(strcmp(comp,yytext) != 0){ //match all mother names
                                                                     yytext[yyleng-2] = '\0';
                                                                     return MAE;
                                                                     }
                                                                }
[ \t]*":temPai :"                                               {BEGIN PAI;}
<PAI>([a-zA-Z]*_)+([0-9]{4})?\ [;.,]                            {BEGIN INITIAL;
                                                                 if(strcmp(comp,yytext) != 0){ //match all father names
                                                                     yytext[yyleng-2] = '\0';
                                                                     return PAI;
                                                                     }
                                                                }

.|\n                                                            { ; }
%%

int main(int argc, char** argv){
    yyin = fopen(argv[1], "r");
    yylex();
    fclose(yyin);
    return 0;
}

