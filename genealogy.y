%{
#include <stdio.h>
#include <strings.h>
#include "pessoa.h"
#include <glib-2.0/glib.h>
#include <glib-2.0/gmodule.h>

int yylex(void);
void yyerror(char *s);
int temPais = 0;
int new_pessoa = 1; //1 quando se deve criar uma nova pessoa
//GPtrArray* pessoas;


%}

%union{  
    char* mae; 
    char* pai; 
    char* nome_individuo;
    }

%token <nome_individuo> SUBJECT
%token PREDICATE
%token <mae> MAE
%token <pai> PAI
%token TEMMAE
%token TEMPAI
%%
Onthology : Onthology Individual
          | Individual
          ;

Individual : SUBJECT            {printf("%s\n",$1);}
           | Relation Object    
           | Object             
           ;

Relation : TEMMAE               {printf("temmae:nice\n");}
         | TEMPAI               {printf("tempai:nice\n");}
         ;

Object : MAE                    {printf("mae: %s\n", $1);}
       | PAI                    {printf("pai: %s\n", $1);}
       ;
%%

#include "genealogy.c"

void yyerror(char* s){
    printf("Error: %s at line %d\n", s, yylineno);
}


int main(){
    //pessoas = g_ptr_array_new();
    yyparse();  
    return(0);
}
