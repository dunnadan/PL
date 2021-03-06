%{
#include <stdio.h>
#include <strings.h>
#include "pessoa.h"
#include <glib-2.0/glib.h>
#include <glib-2.0/gmodule.h>

int yylex(void);
void yyerror(char *s);
int increment_current_index = 0; 
int current_index = 0;
GPtrArray* pessoas;

Pessoa_t init_pessoa(){
    Pessoa_t p = malloc(sizeof(Pessoa_t));
    p->nome = NULL;
    p->mae = NULL;
    p->pai = NULL;
    return p;
}

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

Individual : SUBJECT            {Pessoa_t p = init_pessoa();
                                 p->nome = strdup($1);
                                 if(increment_current_index == 1)
                                    current_index++;
                                 g_ptr_array_insert(pessoas, current_index, p);
                                 increment_current_index = 1;}
           | Relation Object                 
           ;

Relation : TEMMAE               { ; }
         | TEMPAI               { ; }
         ;

Object : MAE                    {Pessoa_t p2 = g_ptr_array_index(pessoas, current_index);
                                 p2->mae = strdup($1);}
       | PAI                    {Pessoa_t p3 = g_ptr_array_index(pessoas, current_index);
                                 p3->pai = strdup($1);
                                 current_index++;
                                 increment_current_index = 0;} 
       ;
%%

#include "genealogy.c"

void yyerror(char* s){
    printf("Error: %s at line %d\n", s, yylineno);
}


void print_dot_file(GPtrArray* array){

    FILE* fp = fopen("genealogy.dot", "w");
    Pessoa_t p = NULL;
    
    fprintf(fp, "digraph G{\n");

    for(int i = 0; i < pessoas->len; i++){
        p = g_ptr_array_index (pessoas, i);
        
        if(p->mae != NULL && p->pai != NULL){
            fprintf(fp, "\"%s\" -> \"%s\";\n\n", p->mae, p->nome);
            fprintf(fp, "\"%s\" -> \"%s\";\n\n", p->pai, p->nome);
        }else
            fprintf(fp,"\"%s\";\n\n", p->nome);
    }
    
    fprintf(fp, "}");
    fclose(fp);
}



int main(){
    pessoas = g_ptr_array_new();
    yyparse();
    print_dot_file(pessoas);
    return(0);
}
