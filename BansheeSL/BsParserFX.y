%{
#include "BsParserFX.h"
#include "BsLexerFX.h"
#define inline

	void yyerror(ASTFXNode* root_node, yyscan_t scanner, const char *msg) 
	{ 
		fprintf (stderr, "%s\n", msg);
	}

%}

%code requires{
#include "BsASTFX.h"

#ifndef YY_TYPEDEF_YY_SCANNER_T
#define YY_TYPEDEF_YY_SCANNER_T
	typedef void* yyscan_t;
#endif

}

%output  "BsParserFX.c"
%defines "BsParserFX.h"

%define api.pure
%debug
%lex-param { yyscan_t scanner }
%parse-param { ASTFXNode* root_node }
%parse-param { yyscan_t scanner }
%glr-parser

%union {
	int intValue;
	float floatValue;
	int boolValue;
	const char* strValue;
	ASTFXNode* nodePtr;
	NodeOption nodeOption;
}

%token TOKEN_LBRACKET
%token TOKEN_RBRACKET
%token TOKEN_SEPARABLE
%token TOKEN_QUEUE
%token TOKEN_PRIORITY

%token <intValue>	TOKEN_INTEGER
%token <floatValue> TOKEN_FLOAT
%token <boolValue>	TOKEN_BOOLEAN
%token <strValue>	TOKEN_STRING

%token	TOKEN_FILLMODE TOKEN_CULLMODE TOKEN_DEPTHBIAS TOKEN_SDEPTHBIAS
%token	TOKEN_DEPTHCLIP TOKEN_SCISSOR TOKEN_MULTISAMPLE TOKEN_AALINE

%type <nodePtr>		shader;
%type <nodeOption>	shader_statement;
%type <nodeOption>	shader_option_decl;

%%

shader
	: /* empty */				{ }
	| shader_statement shader	{ nodeOptionsAdd(root_node->options, &$1); }
	;

shader_statement
	: shader_option_decl
	;

shader_option_decl
	: TOKEN_SEPARABLE '=' TOKEN_BOOLEAN ';'		{ $$.type = OT_Separable; $$.value.boolValue = $3; }
	| TOKEN_QUEUE '=' TOKEN_INTEGER ';'			{ $$.type = OT_Queue; $$.value.intValue = $3; }
	| TOKEN_PRIORITY '=' TOKEN_INTEGER ';'		{ $$.type = OT_Priority; $$.value.intValue = $3; }
	;

%%