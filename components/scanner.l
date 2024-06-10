%option noyywrap
%{
#include<stdio.h>
#include "SymbolTable.h"
int line=1;
int error=0;
FILE* logout;
SymbolTable *table;
%}

%%


"if" 		{
				fprintf(yyout,"<IF>");
				fprintf(logout,"Line No: %d Token <IF> Lexeme %s found\n",line,yytext);
			}
"else" 		{
				fprintf(yyout,"<ELSE>");
				fprintf(logout,"Line No: %d Token <ELSE> Lexeme %s found\n",line,yytext);
			}
"for" 		{
				fprintf(yyout,"<FOR>");
				fprintf(logout,"Line No: %d Token <FOR> Lexeme %s found\n",line,yytext);
			}
"while" 	{
				fprintf(yyout,"<WHILE>");
				fprintf(logout,"Line No: %d Token <WHILE> Lexeme %s found\n",line,yytext);
			}
"do" 		{
				fprintf(yyout,"<DO>");
				fprintf(logout,"Line No: %d Token <DO> Lexeme %s found\n",line,yytext);
			}
"break" 	{
				fprintf(yyout,"<BREAK>");
				fprintf(logout,"Line No: %d Token <BREAK> Lexeme %s found\n",line,yytext);
			}
"int" 		{
				fprintf(yyout,"<INT>");
				fprintf(logout,"Line No: %d Token <INT> Lexeme %s found\n",line,yytext);
			}
"char" 		{
				fprintf(yyout,"<CHAR>");
				fprintf(logout,"Line No: %d Token <CHAR> Lexeme %s found\n",line,yytext);
			}
"float" 	{
				fprintf(yyout,"<FLOAT>");
				fprintf(logout,"Line No: %d Token <FLOAT> Lexeme %s found\n",line,yytext);
			}
"double" 	{
				fprintf(yyout,"<DOUBLE>");
				fprintf(logout,"Line No: %d Token <DOUBLE> Lexeme %s found\n",line,yytext);
			}
"void" 		{
				fprintf(yyout,"<VOID>");
				fprintf(logout,"Line No: %d Token <VOID> Lexeme %s found\n",line,yytext);
			}
"return" 	{
				fprintf(yyout,"<RETURN>");
				fprintf(logout,"Line No: %d Token <RETURN> Lexeme %s found\n",line,yytext);
			}
"switch" 	{
				fprintf(yyout,"<SWITCH>");
				fprintf(logout,"Line No: %d Token <SWITCH> Lexeme %s found\n",line,yytext);
			}
"default" 	{
				fprintf(yyout,"<DEFAULT>");
				fprintf(logout,"Line No: %d Token <DEFAULT> Lexeme %s found\n",line,yytext);
			}
"case"		{
				fprintf(yyout,"<CASE>");
				fprintf(logout,"Line No: %d Token <CASE> Lexeme %s found\n",line,yytext);
			}
"continue"	{
				fprintf(yyout,"<CONTINUE>");
				fprintf(logout,"Line No: %d Token <CONTINUE> Lexeme %s found\n",line,yytext);
			}


[0-9]*\.[0-9]+(E[+-]?[0-9]+)?	{
									fprintf(yyout,"<CONST_FLOAT, %s>",yytext);
									fprintf(logout,"Line No: %d Token <CONST_FLOAT> Lexeme %s found\n",line,yytext);
									SymbolInfo* sym=new SymbolInfo(yytext,"CONST_FLOAT");
									if(table->Insert(sym))table->Print(logout);
									else {
										fprintf(logout,"%s variable already exists\n",yytext);
										error++;
									}
								}
[0-9]+E[+-]?[0-9]+				{
									fprintf(yyout,"<CONST_FLOAT, %s>",yytext);
									fprintf(logout,"Line No: %d Token <CONST_FLOAT> Lexeme %s found\n",line,yytext);
									SymbolInfo* sym=new SymbolInfo(yytext,"CONST_FLOAT");
									if(table->Insert(sym))table->Print(logout);
									else {
										fprintf(logout,"%s variable already exists\n",yytext);
										error++;
									}
								}
[0-9]+							{
									fprintf(yyout,"<CONST_INT, %s>",yytext);
									fprintf(logout,"Line No: %d Token <CONST_INT> Lexeme %s found\n",line,yytext);
									SymbolInfo* sym=new SymbolInfo(yytext,"CONST_INT");
									if(table->Insert(sym))table->Print(logout);
									else {
										fprintf(logout,"%s variable already exists\n",yytext);
										error++;
									}
								}
'[a-zA-Z]'						{
									fprintf(yyout,"<CONST_CHAR, %c>",yytext[1]);
									fprintf(logout,"Line No: %d Token <CONST_CHAR> Lexeme %c found\n",line,yytext[1]);
									SymbolInfo* sym=new SymbolInfo(yytext,"CONST_CHAR");
									if(table->Insert(sym))table->Print(logout);
									else {
										fprintf(logout,"%s variable already exists\n",yytext);
										error++;
									}
								}


[+-]							{
									fprintf(yyout,"<ADDOP, %s>",yytext);
									fprintf(logout,"Line No: %d Token <ADDOP> Lexeme %s found\n",line,yytext);
								}
[*/%]							{
									fprintf(yyout,"<MULOP, %s>",yytext);
									fprintf(logout,"Line No: %d Token <MULOP> Lexeme %s found\n",line,yytext);
								}
"++"|"--"						{
									fprintf(yyout,"<INCOP, %s>",yytext);
									fprintf(logout,"Line No: %d Token <INCOP> Lexeme %s found\n",line,yytext);
								}
"<"|"<="|">"|">="|"=="|"!="		{
									fprintf(yyout,"<RELOP, %s>",yytext);
									fprintf(logout,"Line No: %d Token <RELOP> Lexeme %s found\n",line,yytext);
								}
"="			{
					fprintf(yyout,"<ASSIGNOP, %s>",yytext);
					fprintf(logout,"Line No: %d Token <ASSIGNOP> Lexeme %s found\n",line,yytext);
			}								
"&&"|"||"	{
					fprintf(yyout,"<LOGICOP, %s>",yytext);
					fprintf(logout,"Line No: %d Token <LOGICOP> Lexeme %s found\n",line,yytext);
			}
"!"			{
				fprintf(yyout,"<NOT, %s>",yytext);
				fprintf(logout,"Line No: %d Token <NOT> Lexeme %s found\n",line,yytext);
			}
"("			{
				fprintf(yyout,"<LPAREN, %s>",yytext);
				fprintf(logout,"Line No: %d Token <LPAREN> Lexeme %s found\n",line,yytext);
			}
")"			{
				fprintf(yyout,"<RPAREN, %s>",yytext);
				fprintf(logout,"Line No: %d Token <RPAREN> Lexeme %s found\n",line,yytext);
			}
"{"			{
				fprintf(yyout,"<LCURL, %s>",yytext);
				fprintf(logout,"Line No: %d Token <LCURL> Lexeme %s found\n",line,yytext);
			}
"}"			{
				fprintf(yyout,"<RCURL, %s>",yytext);
				fprintf(logout,"Line No: %d Token <RCURL> Lexeme %s found\n",line,yytext);
			}
"["			{
				fprintf(yyout,"<LTHIRD, %s>",yytext);
				fprintf(logout,"Line No: %d Token <LTHIRD> Lexeme %s found\n",line,yytext);
			}
"]"			{
				fprintf(yyout,"<RTHIRD, %s>",yytext);
				fprintf(logout,"Line No: %d Token <RTHIRD> Lexeme %s found\n",line,yytext);
			}
","			{
				fprintf(yyout,"<COMMA, %s>",yytext);
				fprintf(logout,"Line No: %d Token <COMMA> Lexeme %s found\n",line,yytext);
			}
";"			{
				fprintf(yyout,"<SEMICOLON, %s>",yytext);
				fprintf(logout,"Line No: %d Token <SEMICOLON> Lexeme %s found\n",line,yytext);
			}


[a-zA-Z_][a-zA-Z0-9_]*	{
							fprintf(yyout,"<ID, %s>",yytext);
							fprintf(logout,"Line No: %d Token <ID> Lexeme %s found\n",line,yytext);
							SymbolInfo* sym=new SymbolInfo(yytext,"ID");
							if(table->Insert(sym))table->Print(logout);
							else {
								fprintf(logout,"%s variable already exists\n",yytext);
								error++;
							}
						}			


"//"(.*)?				{fprintf(logout,"Line No: %d Token COMMENT Lexeme %s found\n",line,yytext);}
"/*"[^*/]*("*/")?		{
							fprintf(logout,"Line No: %d Token COMMENT Lexeme %s found\n",line,yytext);
							char res[yyleng-1]={'\0'};
							for(int i=0;i<yyleng;++i){
								if(yytext[i]=='\n')line++;
							}
						}


[ \t\r]+				{}


\n						{line++;}


''									{
										fprintf(logout,"Error at Line No: %d Empty character constant %s\n",line,yytext);
										error++;
									}
[0-9]+[a-zA-Z0-9_]+					{
										fprintf(logout,"Error at line No: %d Invalid prefix on ID or invalid suffix on Number %s\n",line,yytext);
										error++;
									}
[0-9]*(\.[0-9]*)?E[0-9]*\.[0-9]*	{
										fprintf(logout,"Error at line No: %d Ill formed number %s\n",line,yytext);
										error++;
									}
([0-9]*\.[0-9]*)+					{
										fprintf(logout,"Error at line No: %d Ill formed number %s\n",line,yytext);
										error++;
									}
.									{
										fprintf(logout,"Error at Line No: %d Unrecognized character %s\n",line,yytext);
										error++;
									}

%%

int main(){
	table=new SymbolTable();
	yyin=fopen("in.txt","r");
	yyout=fopen("202214091_token.txt","w");
	logout=fopen("202214091_log.txt","w");
	yylex();
	fprintf(logout,"(Total errors found in the source code: %d)",error);
	fclose(yyin);
	fclose(yyout);
	fclose(logout);
	return 0;
}