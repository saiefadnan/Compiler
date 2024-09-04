%option noyywrap
%{
#include "parser.tab.h"
#include<stdlib.h>
#include "SymbolTable.h"
FILE *logout;
SymbolTable *table = new SymbolTable();
int line=1;
int error=0;
%}


%%


[ \t]+				    {}


[\n]					{
                            printf("NEWLINE\n");
                            line++;
                            return NEWLINE;
                        }

"if" 		{
				//fprintf(yyout,"<IF>");
				// fprintf(logout,"Line No: %d Token <IF> Lexeme %s found\n",line,yytext);
             //fprintf(yyout,"Line Number: %d\n",line);
                return IF;
			}
"else" 		{
				// fprintf(yyout,"<ELSE>");
				// fprintf(logout,"Line No: %d Token <ELSE> Lexeme %s found\n",line,yytext);
             //fprintf(yyout,"Line Number: %d\n",line);
                return ELSE;
			}
"for" 		{
				// fprintf(yyout,"<FOR>");
				// fprintf(logout,"Line No: %d Token <FOR> Lexeme %s found\n",line,yytext);
             //fprintf(yyout,"Line Number: %d\n",line);
                return FOR;
			}
"while" 	{
				// fprintf(yyout,"<WHILE>");
				// fprintf(logout,"Line No: %d Token <WHILE> Lexeme %s found\n",line,yytext);
             //fprintf(yyout,"Line Number: %d\n",line);
                return WHILE;
			}
"do" 		{
				// fprintf(yyout,"<DO>");
				// fprintf(logout,"Line No: %d Token <DO> Lexeme %s found\n",line,yytext);
             //fprintf(yyout,"Line Number: %d\n",line);
                return DO;
			}
"break" 	{
				// fprintf(yyout,"<BREAK>");
				// fprintf(logout,"Line No: %d Token <BREAK> Lexeme %s found\n",line,yytext);
             //fprintf(yyout,"Line Number: %d\n",line);
                return BREAK;
			}
"int" 		{
				// fprintf(yyout,"<INT>");
				// fprintf(logout,"Line No: %d Token <INT> Lexeme %s found\n",line,yytext);
             //fprintf(yyout,"Line Number: %d\n",line);
                return INT;
			}
"char" 		{
				// fprintf(yyout,"<CHAR>");
				// fprintf(logout,"Line No: %d Token <CHAR> Lexeme %s found\n",line,yytext);
             //fprintf(yyout,"Line Number: %d\n",line);
                return CHAR;
			}
"float" 	{
				// fprintf(yyout,"<FLOAT>");
				// fprintf(logout,"Line No: %d Token <FLOAT> Lexeme %s found\n",line,yytext);
             //fprintf(yyout,"Line Number: %d\n",line);
                return FLOAT;
			}
"double" 	{
				// fprintf(yyout,"<DOUBLE>");
				// fprintf(logout,"Line No: %d Token <DOUBLE> Lexeme %s found\n",line,yytext);
             //fprintf(yyout,"Line Number: %d\n",line);
                return DOUBLE;
			}
"void" 		{
				// fprintf(yyout,"<VOID>");
				// fprintf(logout,"Line No: %d Token <VOID> Lexeme %s found\n",line,yytext);
             //fprintf(yyout,"Line Number: %d\n",line);
                return VOID;
			}
"return" 	{
				// fprintf(yyout,"<RETURN>");
				// fprintf(logout,"Line No: %d Token <RETURN> Lexeme %s found\n",line,yytext);
             //fprintf(yyout,"Line Number: %d\n",line);
                return RETURN;
			}
"switch" 	{
				// fprintf(yyout,"<SWITCH>");
				// fprintf(logout,"Line No: %d Token <SWITCH> Lexeme %s found\n",line,yytext);
             //fprintf(yyout,"Line Number: %d\n",line);
                return SWITCH;
			}
"default" 	{
				// fprintf(yyout,"<DEFAULT>");
				// fprintf(logout,"Line No: %d Token <DEFAULT> Lexeme %s found\n",line,yytext);
             //fprintf(yyout,"Line Number: %d\n",line);
                return DEFAULT;
			}
"case"		{
				// fprintf(yyout,"<CASE>");
				// fprintf(logout,"Line No: %d Token <CASE> Lexeme %s found\n",line,yytext);
             //fprintf(yyout,"Line Number: %d\n",line);
                return CASE;
			}
"continue"	{
				// fprintf(yyout,"<CONTINUE>");
				// fprintf(logout,"Line No: %d Token <CONTINUE> Lexeme %s found\n",line,yytext);
             //fprintf(yyout,"Line Number: %d\n",line);
                return CONTINUE;
			}


[0-9]*\.[0-9]+(E[+-]?[0-9]+)?	{
									// fprintf(yyout,"<CONST_FLOAT, %s>",yytext);
									// fprintf(logout,"Line No: %d Token <CONST_FLOAT> Lexeme %s found\n",line,yytext);
                                 //fprintf(yyout,"Line Number: %d\n",line);
									SymbolInfo* sym=new SymbolInfo(yytext,"CONST_FLOAT");
                                    table->Insert(sym);
                                    return CONST_FLOAT;
									//if(table->Insert(sym))table->Print(logout);
									// else {
									// 	fprintf(logout,"%s variable already exists\n",yytext);
									// 	error++;
									// }
								}
[0-9]+E[+-]?[0-9]+				{
									// fprintf(yyout,"<CONST_FLOAT, %s>",yytext);
									// fprintf(logout,"Line No: %d Token <CONST_FLOAT> Lexeme %s found\n",line,yytext);
                                 //fprintf(yyout,"Line Number: %d\n",line);
									SymbolInfo* sym=new SymbolInfo(yytext,"CONST_FLOAT");
                                    table->Insert(sym);
                                    return CONST_FLOAT;
									//if(table->Insert(sym))table->Print(logout);
									// else {
									// 	fprintf(logout,"%s variable already exists\n",yytext);
									// 	error++;
									// }
								}
[0-9]+							{
									// fprintf(yyout,"<CONST_INT, %s>",yytext);
									// fprintf(logout,"Line No: %d Token <CONST_INT> Lexeme %s found\n",line,yytext);
                                 //fprintf(yyout,"Line Number: %d\n",line);
									SymbolInfo* sym=new SymbolInfo(yytext,"CONST_INT");
                                    table->Insert(sym);
                                    return CONST_INT;
									//if(table->Insert(sym))table->Print(logout);
									// else {
									// 	fprintf(logout,"%s variable already exists\n",yytext);
									// 	error++;
									// }
								}
'[a-zA-Z]'						{
									// fprintf(yyout,"<CONST_CHAR, %c>",yytext[1]);
									// fprintf(logout,"Line No: %d Token <CONST_CHAR> Lexeme %c found\n",line,yytext[1]);
                                 //fprintf(yyout,"Line Number: %d\n",line);
									SymbolInfo* sym=new SymbolInfo(yytext,"CONST_CHAR");
                                    table->Insert(sym);
                                    return CONST_CHAR;
									//if(table->Insert(sym))table->Print(logout);
									// else {
									// 	fprintf(logout,"%s variable already exists\n",yytext);
									// 	error++;
									// }
								}


[+-]							{
									// fprintf(yyout,"<ADDOP, %s>",yytext);
									// fprintf(logout,"Line No: %d Token <ADDOP> Lexeme %s found\n",line,yytext);
                                 //fprintf(yyout,"Line Number: %d\n",line);
                                    printf("%s\n",yytext);
                                    return ADDOP;
								}
[*/%]							{
									// fprintf(yyout,"<MULOP, %s>",yytext);
									// fprintf(logout,"Line No: %d Token <MULOP> Lexeme %s found\n",line,yytext);
                                 //fprintf(yyout,"Line Number: %d\n",line);
                                    return MULOP;
								}
"++"|"--"						{
									// fprintf(yyout,"<INCOP, %s>",yytext);
									// fprintf(logout,"Line No: %d Token <INCOP> Lexeme %s found\n",line,yytext);
                                 //fprintf(yyout,"Line Number: %d\n",line);
                                    return INCOP;
								}
"<"|"<="|">"|">="|"=="|"!="		{
									// fprintf(yyout,"<RELOP, %s>",yytext);
									// fprintf(logout,"Line No: %d Token <RELOP> Lexeme %s found\n",line,yytext);
                                 //fprintf(yyout,"Line Number: %d\n",line);
                                    return RELOP;
								}
"="			{
					// fprintf(yyout,"<ASSIGNOP, %s>",yytext);
					// fprintf(logout,"Line No: %d Token <ASSIGNOP> Lexeme %s found\n",line,yytext);
                 //fprintf(yyout,"Line Number: %d\n",line);
                    printf("%s\n",yytext);
                    return ASSIGNOP;
			}								
"&&"|"||"	{
					// fprintf(yyout,"<LOGICOP, %s>",yytext);
					// fprintf(logout,"Line No: %d Token <LOGICOP> Lexeme %s found\n",line,yytext);
                 //fprintf(yyout,"Line Number: %d\n",line);
                    return LOGICOP;
			}
"!"			{
				// fprintf(yyout,"<NOT, %s>",yytext);
				// fprintf(logout,"Line No: %d Token <NOT> Lexeme %s found\n",line,yytext);
             //fprintf(yyout,"Line Number: %d\n",line);
                return NOT;
			}
"("			{
				// fprintf(yyout,"<LPAREN, %s>",yytext);
				// fprintf(logout,"Line No: %d Token <LPAREN> Lexeme %s found\n",line,yytext);
             //fprintf(yyout,"Line Number: %d\n",line);
             printf("%s\n",yytext);
                return LPAREN;
			}
")"			{
				// fprintf(yyout,"<RPAREN, %s>",yytext);
				// fprintf(logout,"Line No: %d Token <RPAREN> Lexeme %s found\n",line,yytext);
             //fprintf(yyout,"Line Number: %d\n",line);
             printf("%s\n",yytext);
                return RPAREN;
			}
"{"			{
				// fprintf(yyout,"<LCURL, %s>",yytext);
				// fprintf(logout,"Line No: %d Token <LCURL> Lexeme %s found\n",line,yytext);
             //fprintf(yyout,"Line Number: %d\n",line);
             printf("%s\n",yytext);
                return LCURL;
			}
"}"			{
				// fprintf(yyout,"<RCURL, %s>",yytext);
				// fprintf(logout,"Line No: %d Token <RCURL> Lexeme %s found\n",line,yytext);
             //fprintf(yyout,"Line Number: %d\n",line);
             printf("%s\n",yytext);
                return RCURL;
			}
"["			{
				// fprintf(yyout,"<LTHIRD, %s>",yytext);
				// fprintf(logout,"Line No: %d Token <LTHIRD> Lexeme %s found\n",line,yytext);
             //fprintf(yyout,"Line Number: %d\n",line);
                return LTHIRD;
			}
"]"			{
				// fprintf(yyout,"<RTHIRD, %s>",yytext);
				// fprintf(logout,"Line No: %d Token <RTHIRD> Lexeme %s found\n",line,yytext);
             //fprintf(yyout,"Line Number: %d\n",line);
                return RTHIRD;
			}
","			{
				// fprintf(yyout,"<COMMA, %s>",yytext);
				// fprintf(logout,"Line No: %d Token <COMMA> Lexeme %s found\n",line,yytext);
             //fprintf(yyout,"Line Number: %d\n",line);
                return COMMA;
			}
";"			{
				// fprintf(yyout,"<SEMICOLON, %s>",yytext);
				// fprintf(logout,"Line No: %d Token <SEMICOLON> Lexeme %s found\n",line,yytext);
             //fprintf(yyout,"Line Number: %d\n",line);
             printf("%s\n",yytext);
                return SEMICOLON;
			}


[a-zA-Z_][a-zA-Z0-9_]*	{
							// fprintf(yyout,"<ID, %s>",yytext);
							// fprintf(logout,"Line No: %d Token <ID> Lexeme %s found\n",line,yytext);
							SymbolInfo* sym=new SymbolInfo(yytext,"identifier");
							if(table->Insert(sym)){
                            
                            }
							else {
								fprintf(yyout,"%s  is already declared.\n",yytext);
								error++;
							}
                            printf("Id matched %s\n",yytext);
                            return ID;
						}			


"//"(.*)?				{   
                         //fprintf(yyout,"Line Number: %d\n",line);
                            //fprintf(logout,"Line No: %d Token COMMENT Lexeme %s found\n",line,yytext);
                        }
"/*"[^*/]*("*/")?		{
							//fprintf(logout,"Line No: %d Token COMMENT Lexeme %s found\n",line,yytext);
                         //fprintf(yyout,"Line Number: %d\n",line);
							char res[yyleng-1]={'\0'};
							for(int i=0;i<yyleng;++i){
								if(yytext[i]=='\n')line++;
							}
						}


.                       {}

%%


// int main(){
//     yyin=fopen("input.txt","r");
//     yyout=fopen("log_error.txt","w");
//     logout=fopen("log.txt","w");
//     if(!logout)printf("Bye");
//     yylex();
//     table->Print(logout);
//     printf("done");
//     fclose(yyin);
//     fclose(yyout);
//     fclose(logout);
//     return 0;
// }















// ''									{
// 										//fprintf(logout,"Error at Line No: %d Empty character constant %s\n",line,yytext);
//                                      //fprintf(yyout,"Line Number: %d\n",line);
// 										error++;
// 									}
// [0-9]+[a-zA-Z0-9_]+					{
// 										//fprintf(logout,"Error at line No: %d Invalid prefix on ID or invalid suffix on Number %s\n",line,yytext);
//                                      //fprintf(yyout,"Line Number: %d\n",line);
// 										error++;
// 									}
// [0-9]*(\.[0-9]*)?E[0-9]*\.[0-9]*	{
// 										//fprintf(logout,"Error at line No: %d Ill formed number %s\n",line,yytext);
//                                      //fprintf(yyout,"Line Number: %d\n",line);
// 										error++;
// 									}
// ([0-9]*\.[0-9]*)+					{
// 										//fprintf(logout,"Error at line No: %d Ill formed number %s\n",line,yytext);
//                                      //fprintf(yyout,"Line Number: %d\n",line);
// 										error++;
// 									}
// .									{
// 										//fprintf(logout,"Error at Line No: %d Unrecognized character %s\n",line,yytext);
//                                      //fprintf(yyout,"Line Number: %d\n",line);
// 										error++;
// 									}