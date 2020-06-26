#include <stdio.h>
#include <stdlib.h>

struct pessoa{
    char* mae;
    char* pai;
    char* nome;
};

typedef struct pessoa* Pessoa_t;
