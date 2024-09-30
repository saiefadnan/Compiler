%{
#include<bits/stdc++.h>
#include<stdio.h>
#include<stdlib.h>
#include "SymbolTable.h"
#define YYSTYPE SymbolInfo

extern FILE *yyout, *logout, *codeout, *yyin;
extern SymbolTable *table;
extern int line;
int tempCounter = 1;
SymbolInfo a1;

set<string>vars;

int yylex();
void yyerror(const char* s){
    fprintf(yyout,"%s \nLine Number: %d \n",s,line);
}

char* newTemp(){
    char* temp = (char*)(malloc(15*sizeof(char)));
    sprintf(temp,"t%d",tempCounter);
    vars.insert("t"+to_string(tempCounter));
    cout<<vars.size();;
    tempCounter++;
    return temp;
}

%}


%token ID 
%token MAIN IF ELSE FOR WHILE DO BREAK VOID RETURN SWITCH DEFAULT CASE CONTINUE 
%token INT CHAR FLOAT DOUBLE
%token NUM CONST_CHAR
%token NEWLINE
%token LPAREN RPAREN LCURL RCURL LTHIRD RTHIRD COMMA SEMICOLON

%left ADDOP
%left MULOP
%left LOGICOP
%left RELOP
%right NOT ASSIGNOP
%nonassoc INCOP

%%

prog: MAIN LPAREN RPAREN LCURL stmt RCURL   {/*printf("prog: MAIN LPAREN RPAREN LCURL stmt RCURL\n");*/}
;
stmt: stmt unit                             {/* printf("stmt: stmt unit\n"); */}
| unit                                      {/* printf("stmt: unit\n"); */}
;
unit: var_decl                              {/* printf("unit: var_decl\n"); */}
| expr_decl                                 {/* printf("unit: expr_decl\n"); */}
;
var_decl: type_spec decl_list SEMICOLON     {/* printf("var_decl: type_spec decl_list SEMICOLON\n"); */}
;
type_spec: INT                              {/* printf("type_spec: INT\n"); */}
|CHAR                                       {/* printf("type_spec: CHAR\n"); */}
|FLOAT                                      {/* printf("type_spec: FLOAT\n"); */}
;
decl_list: term                             {/* printf("decl_list: term\n"); */}
;
expr: NUM                                   {/* printf("expr: NUM\n"); */}
| expr ADDOP expr           {
                                char *str = newTemp();
                                SymbolInfo sym(str,"tempID");
                                $$=sym;
                                fprintf(codeout,"%s = %s %s %s\n", $$.getSymbol().c_str(), $1.getSymbol().c_str(), $2.getSymbol().c_str(),$3.getSymbol().c_str());
                                //ASM
                                // fprintf(yyout,"MOV ax, %s\n",$1.getSymbol().c_str());
                                // fprintf(yyout,"MOV bx, %s\n",$3.getSymbol().c_str());
                                a1.storeASM("MOV ax, "+$1.getSymbol());
                                a1.storeASM("MOV bx, "+$3.getSymbol());
                                if($2.getSymbol()=="+"){
                                    a1.storeASM("ADD ax, bx");
                                }else{
                                    a1.storeASM("SUB ax, bx");
                                }
                                a1.storeASM("MOV "+ $$.getSymbol() +", ax\n");
                            }
| expr MULOP expr           {
                                char *str = newTemp();
                                SymbolInfo sym(str,"tempID");
                                $$=sym;
                                fprintf(codeout,"%s = %s %s %s\n", $$.getSymbol().c_str(), $1.getSymbol().c_str(), $2.getSymbol().c_str(),$3.getSymbol().c_str());
                                //ASM
                                a1.storeASM("MOV ax, "+$1.getSymbol());
                                a1.storeASM("MOV bx, "+$3.getSymbol());
                                if($2.getSymbol()=="*"){
                                    a1.storeASM("MUL bx");
                                }else{
                                    a1.storeASM("DIV bx");
                                }
                                a1.storeASM("MOV "+ $$.getSymbol() +", ax\n");
                            }
| expr INCOP                {
                                char *str = newTemp();
                                SymbolInfo sym(str,"tempID");
                                $$=sym;
                                fprintf(codeout,"%s = %s %s\n", $$.getSymbol().c_str(), $1.getSymbol().c_str(), $2.getSymbol().c_str());
                            }
| expr RELOP expr           {
                                char *str = newTemp();
                                SymbolInfo sym(str,"tempID");
                                $$=sym;
                                fprintf(codeout,"%s = %s %s %s\n", $$.getSymbol().c_str(), $1.getSymbol().c_str(), $2.getSymbol().c_str(),$3.getSymbol().c_str());
                            }
| expr LOGICOP expr         {
                                char *str = newTemp();
                                SymbolInfo sym(str,"tempID");
                                $$=sym;
                                fprintf(codeout,"%s = %s %s %s\n", $$.getSymbol().c_str(), $1.getSymbol().c_str(), $2.getSymbol().c_str(),$3.getSymbol().c_str());
                            }
| NOT expr                  {
                                char *str = newTemp();
                                SymbolInfo sym(str,"tempID");
                                $$=sym;
                                fprintf(codeout,"%s = %s %s \n", $$.getSymbol().c_str(), $1.getSymbol().c_str(), $2.getSymbol().c_str());
                            }


| LPAREN expr RPAREN        {
                                char *str = newTemp();
                                SymbolInfo sym(str,"tempID");
                                $$=sym;
                                fprintf(codeout,"%s = %s \n", $$.getSymbol().c_str(), $2.getSymbol().c_str());
                                //ASM
                                a1.storeASM("MOV ax, " + $2.getSymbol());
                            }
|term                       {}
;
term: ID                    {}
;
expr_decl: term ASSIGNOP expr SEMICOLON     {
                                                fprintf(codeout,"%s = %s\n\n", $1.getSymbol().c_str(), $3.getSymbol().c_str());
                                                //ASM                            
                                                a1.storeASM("MOV ax, " + $3.getSymbol());
                                                a1.storeASM("MOV " + $1.getSymbol() + ", ax\n");
                                                vars.insert($1.getSymbol());
                                                tempCounter=1;
                                            }
| expr SEMICOLON                            {
                                                fprintf(codeout,"\n");
                                                //ASM
                                                tempCounter=1;
                                            }
;

%%

int main(){
    yyin=fopen("input.txt","r");
    logout=fopen("table.txt","w");
    yyout=fopen("code.asm","w");
    codeout=fopen("code.ir","w");
    yyparse();

    fprintf(yyout,".model small\n");
    fprintf(yyout,".stack 100h\n");
    fprintf(yyout,".data\n");
    for(auto i:vars){
        fprintf(yyout,"%s dw ?\n",i.c_str());
    }
    fprintf(yyout,".code\n");
    fprintf(yyout,"MAIN PROC\n");

    fprintf(yyout, "    MOV ax, @data\n");
    fprintf(yyout, "    MOV ds, ax\n\n");

    fprintf(yyout,a1.getASM().c_str());

    fprintf(yyout,"MAIN ENDP\n");
    fprintf(yyout,"END MAIN\n");
    table->Print(logout);
    fclose(yyout);
    fclose(yyin);
    fclose(logout);
    fclose(codeout);
    return 0;
}
