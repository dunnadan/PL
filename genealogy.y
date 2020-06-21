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

Property : PSUBJECT PPREDICATE Object
         | PPREDICATE Object
         | Object
         ;

Class : CSUBJECT CPREDICATE Object
      | CPREDICATE Object
      | Object
      ;

Individual : ISUBJECT IPREDICATE Object
           | IPREDICATE Object
           | Object
           ;

Object : ID
       | STR
       | NUM

%%

int yyerror(char *s){
    fprintf(stderr, "ERRO: %s \n", s);
}


int main(){
    yyparse();  
    return(0);
}
