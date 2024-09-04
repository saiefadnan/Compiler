%{
#include<stdio.h>
#include "SymbolTable.h"
extern FILE *yyin,*yyout,*logout;
extern SymbolTable *table;
extern int line,error;
int yylex();
void yyerror(const char* s){
    printf("Line no: %d %s\n",line,s);
}
%}

%token IF ELSE FOR WHILE DO BREAK VOID RETURN SWITCH DEFAULT CASE CONTINUE  
%token ID CONST_CHAR CONST_INT CONST_FLOAT CHAR INT FLOAT DOUBLE
%token INCOP RELOP LOGICOP NOT ASSIGNOP ADDOP MULOP
%token LPAREN RPAREN LCURL RCURL LTHIRD RTHIRD COMMA SEMICOLON NEWLINE

%left ADDOP
%left MULOP
%left LOGICOP
%left RELOP
%left INCOP
%right NOT


%%

mul_stmt: mul_stmt func_decl                                {   
                                                                fprintf(yyout,"Line Number: %d\n",line);
                                                                fprintf(yyout,"mul_stmt: mul_stmt func_decl\n");
                                                            }
|func_decl                                                  {
                                                                fprintf(yyout,"Line Number: %d\n",line);
                                                                fprintf(yyout,"mul_stmt: func_decl\n");
                                                            }                                                                                                                                                     
;

func_decl: type_spec term LPAREN RPAREN LCURL stmt RCURL            {   
                                                                        fprintf(yyout,"Line Number: %d\n",line);
                                                                        fprintf(yyout,"func_decl: type_spec term LPAREN RPAREN LCURL stmt RCURL\n");
                                                                    }

func_decl: type_spec term LPAREN RPAREN line LCURL stmt RCURL       {   
                                                                        fprintf(yyout,"Line Number: %d\n",line);
                                                                        fprintf(yyout,"func_decl: type_spec term LPAREN RPAREN LCURL stmt RCURL\n");
                                                                    }                                                  
|line
;                                                           

stmt: stmt unit                                             {
                                                                fprintf(yyout,"Line Number: %d\n",line);
                                                                fprintf(yyout,"stmt: stmt unit\n");
                                                            }
|unit                                                       {
                                                                fprintf(yyout,"Line Number: %d\n",line);
                                                                fprintf(yyout,"stmt: unit\n");
                                                            }
|error                                                      {yyerrok;}                                                                                                            
; 

unit: var_decl NEWLINE                                  {
                                                            fprintf(yyout,"Line Number: %d\n",line);
                                                            fprintf(yyout,"unit: var_decl NEWLINE\n");
                                                        }
|expr_decl NEWLINE                                      {
                                                            fprintf(yyout,"Line Number: %d\n",line);
                                                            fprintf(yyout,"unit: expr_decl NEWLINE\n");
                                                        }                                                                                                                                                                      
;

var_decl: type_spec decl_list SEMICOLON                 {
                                                            fprintf(yyout,"Line Number: %d\n",line);
                                                            fprintf(yyout,"var_decl: type_spec decl_list SEMICOLON\n");
                                                        }
|error                                                  {yyerrok;}                                                                                                                                 
;

type_spec: INT                                              {
                                                                fprintf(yyout,"Line Number: %d\n",line);
                                                                fprintf(yyout,"type_spec: INT\n");
                                                            }
|FLOAT                                                      {
                                                                fprintf(yyout,"Line Number: %d\n",line);
                                                                fprintf(yyout,"type_spec: FLOAT\n");
                                                            }
|DOUBLE                                                     {
                                                                fprintf(yyout,"Line Number: %d\n",line);
                                                                fprintf(yyout,"type_spec: DOUBLE\n");
                                                            }

decl_list: decl_list COMMA term                             {   
                                                                fprintf(yyout,"Line Number: %d\n",line);
                                                                fprintf(yyout,"decl_list: decl_list COMMA term\n");
                                                            }
|decl_list COMMA term LTHIRD CONST_INT RTHIRD               {
                                                                fprintf(yyout,"Line Number: %d\n",line);
                                                                fprintf(yyout,"decl_list: decl_list COMMA term LTHIRD CONST_INT RTHIRD\n");
                                                            }
|term                                                       {
                                                                fprintf(yyout,"Line Number: %d\n",line);
                                                                fprintf(yyout,"decl_list: term\n");
                                                            }
|term LTHIRD CONST_INT RTHIRD                               {
                                                                fprintf(yyout,"Line Number: %d\n",line);
                                                                fprintf(yyout,"decl_list: term LTHIRD CONST_INT RTHIRD\n");
                                                            }
|ass_list                                                   {
                                                                fprintf(yyout,"Line Number: %d\n",line);
                                                                fprintf(yyout,"ass_list\n");
                                                            }
;

ass_list: term ASSIGNOP expr                                {
                                                                fprintf(yyout,"Line Number: %d\n",line);
                                                                fprintf(yyout,"ass_list: term ASSIGNOP expr\n");
                                                            }
|line                                                                                                                
;

expr: CONST_INT                                 {
                                                    fprintf(yyout,"Line Number: %d\n",line);
                                                    fprintf(yyout,"expr: CONST_INT\n");
                                                }
|CONST_FLOAT                                    {
                                                    fprintf(yyout,"Line Number: %d\n",line);
                                                    fprintf(yyout,"expr: CONST_FLOAT\n");
                                                }
|expr ADDOP expr                                {
                                                    fprintf(yyout,"Line Number: %d\n",line);
                                                    fprintf(yyout,"expr: expr ADDOP expr\n");
                                                }
|expr MULOP expr                                {
                                                    fprintf(yyout,"Line Number: %d\n",line);
                                                    fprintf(yyout,"expr: expr MULOP expr\n");
                                                }
|expr INCOP                                     {   
                                                    fprintf(yyout,"Line Number: %d\n",line);
                                                    fprintf(yyout,"expr: expr INCOP\n");
                                                }
|expr RELOP expr                                {   
                                                    fprintf(yyout,"Line Number: %d\n",line);
                                                    fprintf(yyout,"expr: expr RELOP expr\n");
                                                }
|expr LOGICOP expr                              {   
                                                    fprintf(yyout,"Line Number: %d\n",line);
                                                    fprintf(yyout,"expr: expr LOGICOP expr\n");
                                                }
|NOT expr                                       {   
                                                    fprintf(yyout,"Line Number: %d\n",line);
                                                    fprintf(yyout,"expr: NOT expr\n");
                                                }
|LPAREN expr ADDOP expr RPAREN                           {
                                                    fprintf(yyout,"Line Number: %d\n",line);
                                                    fprintf(yyout,"expr: expr ADDOP expr\n");
                                                }
|LPAREN expr MULOP expr RPAREN                                {
                                                    fprintf(yyout,"Line Number: %d\n",line);
                                                    fprintf(yyout,"expr: expr MULOP expr\n");
                                                }
|LPAREN expr RELOP expr RPAREN                          {   
                                                    fprintf(yyout,"Line Number: %d\n",line);
                                                    fprintf(yyout,"expr: expr RELOP expr\n");
                                                }
|LPAREN expr LOGICOP expr RPAREN                            {   
                                                    fprintf(yyout,"Line Number: %d\n",line);
                                                    fprintf(yyout,"expr: expr LOGICOP expr\n");
                                                }
|LPAREN NOT expr RPAREN                                       {   
                                                    fprintf(yyout,"Line Number: %d\n",line);
                                                    fprintf(yyout,"expr: NOT expr\n");
                                                }  
|term                                           {
                                                    fprintf(yyout,"Line Number: %d\n",line);
                                                    fprintf(yyout,"expr: term\n");
                                                }
|line                                                                                 
;                           

term: ID                                        {
                                                    fprintf(yyout,"Line Number: %d\n",line);
                                                    fprintf(yyout,"term: ID\n");
                                                }                                                          
;

expr_decl: term ASSIGNOP expr SEMICOLON         {
                                                    fprintf(yyout,"Line Number: %d\n",line);
                                                    fprintf(yyout,"expr_decl: term ASSIGNOP expr SEMICOLON\n");
                                                }                                                                                                                
;
line: NEWLINE                                      {}                                

%%

main(){
    yyin=fopen("input.txt","r");
    yyout=fopen("log_error.txt","w");
    logout=fopen("log.txt","w");
    yyparse();
    table->Print(logout);
    fclose(yyin);
    fclose(yyout);
    fclose(logout);
    return 0;
}