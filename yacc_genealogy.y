%{
#include <stdio.h>
#include <strings.h>
/* Declaracoes C diversas */
%}

%union{ char* str; }

%token SUBJECT PREDICATE ID STR NUM
%type <str> SUBJECT
%type <str> PREDICATE
%%
//start token?
Onthology : START Content
          ;

Content : Content Individual
        |
        ;

Individual : ':' SUBJECT ':' PREDICATE ':' Object Symbol
           | ':' PREDICATE ':' Object Symbol
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
