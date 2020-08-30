%{
    class Obj{
      constructor( tmp, c3d){
          this.tmp=tmp;
          this.c3d=c3d;
      }
    }
    let cont=0;
    function new_temp(){
      return "t"+cont++;
    }

%}

%lex
%options case-insensitive
number [0-9]+
decimal {entero}"."{entero}
%%
\s+                   /* skip whitespace */

{number}              return 'NUMBER'
{decimal}             return 'DECIMAL'
"*"                   return '*'
"/"                   return '/'
";"                   return ';'
"-"                   return '-'
"+"                   return '+'
"("                   return '('
")"                   return ')' 
([a-zA-Z_])[a-zA-Z0-9_ñÑ]*	return 'ID'
<<EOF>>		          return 'EOF'

/lex

%start Init

%%

Init    
    : E EOF 
    {
        return $1;
    }
;

E
    : E '+' T
    {
        tmp=new_temp();
        $$= new Obj(tmp,$1.c3d+$3.c3d+tmp+"="+$1.tmp+"+"+$3.tmp+"\n");
    }       
    | E '-' T
    {
        tmp=new_temp();
        $$= new Obj(tmp,$1.c3d+$3.c3d+tmp+"="+$1.tmp+"-"+$3.tmp+"\n");
    } 
    | T
    {
        $$ = $1;
    }
;

T   
    : T '*' F
    { 
        tmp=new_temp();
        $$= new Obj(tmp,$1.c3d+$3.c3d+tmp+"="+$1.tmp+"*"+$3.tmp+"\n");
    }       
    | T '/' F
    {
        tmp=new_temp();
        $$= new Obj(tmp,$1.c3d+$3.c3d+tmp+"="+$1.tmp+"/"+$3.tmp+"\n");
    }
    | F
    { 
        $$ = $1;
    }
;

F   
    : '(' E ')'
    { 
        $$ = $2;
    }
    | ID
    {   
        $$=new Obj(String($1),"");
    }
;