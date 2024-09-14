%option noyywrap
%{
#include<stdio.h>
#include <string.h>
#include "SymbolTable.h"
#define YYSTYPE SymbolInfo
#include "generator.tab.h"

void yyerror(const char* str);
FILE *logout, *codeout;
SymbolTable *table = new SymbolTable();

int line=1;
%}


%%

"main"		{ return MAIN;    }
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

[+-]							{ SymbolInfo sym(yytext,"ADDOP");yylval= sym;return ADDOP; 			}
[*/%]							{ SymbolInfo sym(yytext,"MULOP");yylval= sym;return MULOP; 			}
"++"|"--"						{ SymbolInfo sym(yytext,"INCOP");yylval= sym;return INCOP;			}
"<"|"<="|">"|">="|"=="|"!="		{ SymbolInfo sym(yytext,"RELOP");yylval= sym;return RELOP; 			}
"="								{ SymbolInfo sym(yytext,"ASSIGNOP");yylval= sym;return ASSIGNOP;	}								
"&&"|"||"						{ SymbolInfo sym(yytext,"LOGICOP");yylval= sym;return LOGICOP;  	}
"!"								{ SymbolInfo sym(yytext,"NOT");yylval= sym;return NOT;				}
"("								{ SymbolInfo sym(yytext,"LPAREN");yylval= sym;return LPAREN;		}
")"								{ SymbolInfo sym(yytext,"RPAREN");yylval= sym;return RPAREN;		}
"{"								{ SymbolInfo sym(yytext,"LCURL");yylval= sym;return LCURL;			}
"}"								{ SymbolInfo sym(yytext,"RCURL");yylval= sym;return RCURL;			}
"["								{ SymbolInfo sym(yytext,"LTHIRD");yylval= sym;return LTHIRD;		}
"]"								{ SymbolInfo sym(yytext,"RTHIRD");yylval= sym;return RTHIRD;		}
","								{ SymbolInfo sym(yytext,"COMMA");yylval= sym;return COMMA;			}
";"								{ SymbolInfo sym(yytext,"SEMICOLON");yylval= sym;return SEMICOLON;	}

[0-9]+
| [0-9]*\.[0-9]+(E[+-]?[0-9]+)?
| [0-9]+E[+-]?[0-9]+			{
									SymbolInfo sym(yytext,"NUM");
                                    table->Insert(&sym);
									yylval = sym;
                                    return NUM;
								}
'[a-zA-Z]'						{			
									SymbolInfo sym(yytext,"CONST_CHAR");
                                    table->Insert(&sym);
									yylval = sym;
                                    return CONST_CHAR;
								}
[a-zA-Z_][a-zA-Z0-9_]*			{
									SymbolInfo sym(yytext,"ID");
									table->Insert(&sym);
									printf("%s\n",yytext);
									yylval = sym;
									return ID;
								}	
										
[ \t]+				    		{}	
[\n]							{/*line++;*/}
.                       		{ yyerror("error\n");}

%%

