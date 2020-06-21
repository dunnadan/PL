%{
#include <stdio.h>
#include <strings.h>
%}

%union{ char* str; int num; }
%token SUBJECT PREDICATE ID STR NUM
%type <str> PSUBJECT PPREDICATE CSUBJECT CPREDICATE ISUBJECT IPREDICATE
%type <str> PREDICATE
%type <num> NUM

%%
Onthology : ListProperties ListClasses ListIndividuals
          ;

ListProperties : ListProperties Property
               | Property
               ;

ListClasses : ListClasses Class
            | Class
            ;

ListIndividuals : ListIndividuals Individual
                | Individual
                ;

Property : ':' PSUBJECT PPREDICATE Object Symbol
         | ':' PPREDICATE Object Symbol
         | ':' Object Symbol
         ;

Class : ':' CSUBJECT CPREDICATE Object Symbol
      | ':' CPREDICATE Object Symbol
      | ':' Object Symbol
      ;

Individual : ':' ISUBJECT IPREDICATE Object Symbol
           | ':' IPREDICATE Object Symbol
           | ':' Object Symbol
           ;

Object : ID
       | STR
       | NUM

Symbol : '.'
       | ','
       | ';'
       ;
%%

int yyerror(char *s){
    fprintf(stderr, "ERRO: %s \n", s);
}


int main(){
    yyparse();  
    return(0);
}
