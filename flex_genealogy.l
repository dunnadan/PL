%{
/* Declaracoes C diversas */
%}

        /* Abreviaturas de ER */
digito    [0-9]
acentos   \xc3[\x80-\xbf]       
letra     [a-zA-Z]|{acentos}       
palavra   ﻿﻿﻿﻿﻿﻿﻿{letra}+         
     
%%
ER         { ECHO; /*imprime na saida ER (em geral a Expressao Regular encontrada na entrada*/}
{digito}+  { AccaoSemantica em C; /*encontrei um NUMERO*/}
{palavra}  { AccaoSemantica em C; /*encontrei uma PALAVRA*/}
.|\n       { ; /*suprime da saida qualquer outro carater incluindo o NewLine*/}
%%

int yywrap(){ 
    return(1);
}

int main(){ 
    yylex(); 
    return 0; 
}