
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     CONST_INT = 258,
     CONST_FLOAT = 259,
     CONST_CHAR = 260,
     ID = 261,
     IF = 262,
     ELSE = 263,
     FOR = 264,
     WHILE = 265,
     DO = 266,
     BREAK = 267,
     VOID = 268,
     RETURN = 269,
     SWITCH = 270,
     DEFAULT = 271,
     CASE = 272,
     CONTINUE = 273,
     CHAR = 274,
     INT = 275,
     FLOAT = 276,
     DOUBLE = 277,
     INCOP = 278,
     RELOP = 279,
     LOGICOP = 280,
     NOT = 281,
     ASSIGNOP = 282,
     ADDOP = 283,
     MULOP = 284,
     LPAREN = 285,
     RPAREN = 286,
     LCURL = 287,
     RCURL = 288,
     LTHIRD = 289,
     RTHIRD = 290,
     COMMA = 291,
     SEMICOLON = 292
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 13 "parser.y"

    int ivar;
    float fvar;
    double dvar;
    char cvar;
    char *svar;



/* Line 1676 of yacc.c  */
#line 99 "parser.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


