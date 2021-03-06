/*
    Auteurs:
        | Damien PICARD
        | Benjamin ZIGH
*/
%{
  open Types ;;
  open Tools ;;
%}

%token Leol
%token Lcomm
%token Llambda
%token Lleftp
%token Lrightp
%token Ldot
%token Lequal
%token Llet
%token Lsemcol
%token <string> Ltype
%token Ltrue
%token Lfalse
%token <string> Lident
%token Lif
%token Lthen
%token Lelse
%token Lzero
%token Lsucc
%token Lpred
%token LisZero
%token Lbool
%token Lnat
%token Larrow



%start line                       /* axiome */
%type <Types.term> line    /* type de l'attribut de l'axiome */  

%%

line :
    | term Leol            {$1}
    | declare Leol         {$1}

term :
    | functerm                 {$1} 
    | appterm functerm         {App ($1, $2)}
    | Lif term Lthen term Lelse term {Cond ($2, $4, $6)}

appterm :
    | elemterm                 {$1}
    | appterm elemterm         {App ($1,$2)}
   
functerm :
    | Llambda Lident Lsemcol typage Ldot term  {Lambda ($4,$2,$6)}
    | Lsucc term         {Succ $2}
    | Lpred term         {Pred $2}
    | LisZero term       {IsZero $2}
    | elemterm                 {$1} 

elemterm :
    | Lident                   {Var ($1)}
    | Ltrue                    {True}
    | Lfalse                   {False}
    | Lzero                    {Zero}
    | Lleftp term Lrightp      {$2}
    
elemtype :
    | Lbool {Bool}
    | Lnat  {Nat}
    | Lleftp typage Lrightp {$2}
    
    
typage:
    | elemtype {$1}
    | elemtype Larrow typage {AppType($1,$3)}
    
/* Ajout des déclarations */

declare :
    | Llet Lident Lequal term    {(Tools.declare $2 $4)}


%%
 
