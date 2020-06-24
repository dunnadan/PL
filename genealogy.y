%{
#include <stdio.h>
#include <strings.h>
%}

%union{ char* extra_info; char* mae; char* pai; char* nome_individuo; }
%token SUBJECT PREDICATE OBJECT MAE PAI
%type <str> SUBJECT PREDICATE OBJECT MAE PAI

%%
Onthology : ListIndividuals Individual
          | Individual
          ;

Individual : SUBJECT PREDICATE OBJECT
           | Parent OBJECT
           | OBJECT
           ;

Parent : MAE
       | PAI
       ;
%%

int yyerror(char *s){
    fprintf(stderr, "ERRO: %s \n", s);
}


int main(){
    yyparse();  
    return(0);
}
