%option noyywrap
%option yylineno


%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"
char* comp = " ;";
%}


%s ZINDIVIDUO ZPAI ZMAE ZPRED ZOWL
%%
^:                                                              {BEGIN ZINDIVIDUO;}
<ZINDIVIDUO>[a-zA-Z]*_[a-zA-Z_]+([0-9]{4})?                     {BEGIN INITIAL;
                                                                 yylval.nome_individuo = strdup(yytext); 
                                                                 return SUBJECT;
                                                                }
^:[a-zA-Z]*_[a-zA-Z_]+([0-9]{4})?[  ]rdf:                       {BEGIN ZPRED;}
<ZPRED>[a-zA-Z]+                                                {BEGIN INITIAL;
                                                                 printf("%s\n", yytext);
                                                                 return PREDICATE; //match predicates
                                                                }
^:[a-zA-Z]*_[a-zA-Z_]+([0-9]{4})?[a-zA-Z: ]+owl:                {BEGIN ZOWL;}
<ZOWL>[a-zA-Z]+/[  ][,.;]                                       {BEGIN INITIAL; 
                                                                 return OWL;}   
[ \t]*":temMae :"                                               {BEGIN ZMAE;
                                                                 return TEMMAE; //match temMae
                                                                }
<ZMAE>([a-zA-Z]*_)+([0-9]{4})?\ [;.,]                           {BEGIN INITIAL;
                                                                 if(strcmp(comp,yytext) != 0){ //match all mother names
                                                                     yytext[yyleng-2] = '\0';
                                                                     yylval.mae = strdup(yytext);
                                                                     return MAE;
                                                                     }
                                                                }
[ \t]*":temPai :"                                               {BEGIN ZPAI;
                                                                 return TEMPAI; //match temPai
                                                                }
<ZPAI>([a-zA-Z]*_)+([0-9]{4})?\ [;.,]                           {BEGIN INITIAL;
                                                                 if(strcmp(comp,yytext) != 0){ //match all father names
                                                                     yytext[yyleng-2] = '\0';
                                                                     yylval.pai = strdup(yytext);
                                                                     return PAI;
                                                                     }
                                                                }
^#.*                                                            { ; }
.|\n                                                            { ; }
%%

