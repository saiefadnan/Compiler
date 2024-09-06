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


[\n]					{ line++; }

"if" 		{ return IF;      }
"else" 		{ return ELSE;    }
"for" 		{ return FOR;     }
"while" 	{ return WHILE;   }
"do" 		{ return DO;      }
"break" 	{ return BREAK;   }
"int" 		{ return INT;     }
"char" 		{ return CHAR;    }
"float" 	{ return FLOAT;   }
"double" 	{ return DOUBLE;  }
"void" 		{ return VOID;    }
"return" 	{ return RETURN;  }
"switch" 	{ return SWITCH;  }
"default" 	{ return DEFAULT; }
"case"		{ return CASE;    }
"continue"	{ return CONTINUE;}


[0-9]*\.[0-9]+(E[+-]?[0-9]+)? 	{
									SymbolInfo* sym=new SymbolInfo(yytext,"CONST_FLOAT");
									table->Insert(sym);
									yylval.fvar = atof(yytext);
									return CONST_FLOAT;
								}
[0-9]+E[+-]?[0-9]+				{
									SymbolInfo* sym=new SymbolInfo(yytext,"CONST_FLOAT");
									table->Insert(sym);
									yylval.fvar = atof(yytext);
									return CONST_FLOAT;
								}													
													
[0-9]+							{
									SymbolInfo* sym=new SymbolInfo(yytext,"CONST_INT");
                                    table->Insert(sym);
									yylval.ivar = atoi(yytext);
                                    return CONST_INT;
								}
'[a-zA-Z]'						{
									SymbolInfo* sym=new SymbolInfo(yytext,"CONST_CHAR");
                                    table->Insert(sym);
									yylval.cvar = yytext[0];
                                    return CONST_CHAR;
								}


[+-]							{ return ADDOP; 	}
[*/%]							{ return MULOP; 	}
"++"|"--"						{ return INCOP;		}
"<"|"<="|">"|">="|"=="|"!="		{ return RELOP; 	}
"="								{ return ASSIGNOP; 	}								
"&&"|"||"						{ return LOGICOP;   }
"!"								{ return NOT;		}
"("								{ return LPAREN;	}
")"								{ return RPAREN;	}
"{"								{ return LCURL;		}
"}"								{ return RCURL;		}
"["								{ return LTHIRD;	}
"]"								{ return RTHIRD;	}
","								{ return COMMA;		}
";"								{ return SEMICOLON;	}


[a-zA-Z_][a-zA-Z0-9_]*	{
							SymbolInfo* sym=new SymbolInfo(yytext,"identifier");
							if(!table->Insert(sym)){
								fprintf(yyout,"%s is already declared.\n",yytext);
								error++;
                            }
							else {
								fprintf(yyout,"Line Number: %d\n",line);
                                fprintf(yyout,"term: ID\n");
								yylval.svar = yytext;
							}
							return ID;
						}			


"//"(.*)?				{}

"/*"[^*/]*("*/")?		{
							char res[yyleng-1]={'\0'};
							for(int i=0;i<yyleng;++i){
								if(yytext[i]=='\n')line++;
							}
						}


.                       {}

%%












