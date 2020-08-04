%option noyywrap
%option yylineno


%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"
char* comp = " ;";
%}


%s ZINDIVIDUO ZPAI ZMAE
%%
^:                                                              {BEGIN ZINDIVIDUO;}
<ZINDIVIDUO>[a-zA-Z]*_[a-zA-Z_]+([0-9]{4})?                     {BEGIN INITIAL;
                                                                 yylval.nome_individuo = strdup(yytext); 
                                                                 return SUBJECT;
                                                                }
[ \t]*":temMae :"                                               {BEGIN ZMAE;
                                                                 return TEMMAE; 
                                                                }
<ZMAE>[a-zA-Z]*_[a-zA-Z_]+([0-9]{4})?\ [;.,]                    {BEGIN INITIAL;
                                                                 if(strcmp(comp,yytext) != 0){ 
                                                                     yytext[yyleng-2] = '\0';
                                                                     yylval.mae = strdup(yytext);
                                                                     return MAE;
                                                                     }
                                                                }
[ \t]*":temPai :"                                               {BEGIN ZPAI;
                                                                 return TEMPAI; 
                                                                }
<ZPAI>[a-zA-Z]*_[a-zA-Z_]+([0-9]{4})?\ [;.,]                    {BEGIN INITIAL;
                                                                 if(strcmp(comp,yytext) != 0){ 
                                                                     yytext[yyleng-2] = '\0';
                                                                     yylval.pai = strdup(yytext);
                                                                     return PAI;
                                                                     }
                                                                }
^#.*                                                            { ; }
.|\n                                                            { ; }
%%

