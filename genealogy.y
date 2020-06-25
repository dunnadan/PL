%{
#include <stdio.h>
#include <strings.h>

int yylex(void);
void yyerror(char *s);
%}

%union{  
    char* mae; 
    char* pai; 
    char* nome_individuo;  
    char* tem_mae; 
    char* tem_pai; 
    }

%token <nome_individuo> SUBJECT
%token PREDICATE
%token <mae> MAE
%token <pai> PAI
%token OWL
%token <tem_mae> TEMMAE
%token <tem_pai> TEMPAI
%%
Onthology : Onthology Individual
          | Individual
          ;

Individual : SUBJECT PREDICATE Object
           | Relation Object
           | Object
           ;

Relation : TEMMAE
         | TEMPAI
         ;

Object : MAE    { ; }
       | PAI
       | OWL
       ;
%%
#include "genealogy.c"

void yyerror(char* s){
    printf("Error: %s at line %d\n", s, yylineno);
}


int main(){
    yyparse();  
    return(0);
}
