%{
#include <stdio.h>
#include <strings.h>
/* Declaracoes C diversas */
%}

%union{ char* str; int num; }

%token SUBJECT PREDICATE ID STR NUM
%type <str> SUBJECT
%type <str> PREDICATE
%type <num> NUM
%%
Onthology : ListTriplos
          ;

ListTriplos : ListTriplos Triplo
            | Triplo
            ;

Triplo : ':' SUBJECT PREDICATE Object Symbol
       | ':' PREDICATE Object Symbol
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

int yyerror(char *s)
{
  fprintf(stderr, "ERRO: %s \n", s);
}

int main()
{
  /*prologo*/
    yyparse();
  /*epilogo*/
  return(0);
}
