%{
#include<stdio.h>
#include<stdlib.h>
#include "SymbolTable.h"
#define YYSTYPE SymbolInfo

extern FILE *yyout, *logout, *codeout, *yyin;
extern SymbolTable *table;
extern int line;
int tempCounter = 1;
int yylex();
void yyerror(const char* s){
    fprintf(yyout,"%s \nLine Number: %d \n",s,line);
}

char* newTemp(){
    char* temp = (char*)(malloc(15*sizeof(char)));
    sprintf(temp,"t%d",tempCounter);
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
                                fprintf(yyout,"MOV ax, %s\n",$1.getSymbol().c_str());
                                fprintf(yyout,"MOV bx, %s\n",$3.getSymbol().c_str());
                                if($2.getSymbol()=="+"){
                                    fprintf(yyout,"ADD ax, bx\n");
                                }else{
                                    fprintf(yyout,"SUB ax, bx\n");
                                }
                                fprintf(yyout,"MOV %s, ax\n\n",$$.getSymbol().c_str());
                            }
| expr MULOP expr           {
                                char *str = newTemp();
                                SymbolInfo sym(str,"tempID");
                                $$=sym;
                                fprintf(codeout,"%s = %s %s %s\n", $$.getSymbol().c_str(), $1.getSymbol().c_str(), $2.getSymbol().c_str(),$3.getSymbol().c_str());
                                //ASM
                                fprintf(yyout,"MOV ax, %s\n",$1.getSymbol().c_str());
                                fprintf(yyout,"MOV bx, %s\n",$3.getSymbol().c_str());
                                if($2.getSymbol()=="*"){
                                    fprintf(yyout,"MUL bx\n");
                                }else{
                                    fprintf(yyout,"DIV bx\n");
                                }
                                fprintf(yyout,"MOV %s, ax\n\n",$$.getSymbol().c_str());
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
                                fprintf(yyout,"MOV ax, %s\n",$2.getSymbol().c_str());
                            }
|term                       {}
;
term: ID                    {}
;
expr_decl: term ASSIGNOP expr SEMICOLON     {
                                                fprintf(codeout,"%s = %s\n\n", $1.getSymbol().c_str(), $3.getSymbol().c_str());
                                                //ASM
                                                fprintf(yyout,"MOV %s, %s\n\n",$1.getSymbol().c_str(), $3.getSymbol().c_str());
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
    table->Print(logout);
    fclose(yyout);
    fclose(yyin);
    fclose(logout);
    fclose(codeout);
    return 0;
}
