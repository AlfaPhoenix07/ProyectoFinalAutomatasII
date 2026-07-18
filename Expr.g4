grammar Expr;

// ==========================================================
// ZONA SINTÁCTICA (MINÚSCULAS) -> TU PARTE CRIS
// ==========================================================
program : EOF ;

//=====================================================
// PALABRAS RESERVADAS
//=====================================================

ABSTRACT   : 'abstract';
ASSERT     : 'assert';
BOOLEAN    : 'boolean';
BREAK      : 'break';
BYTE       : 'byte';
CASE       : 'case';
CATCH      : 'catch';
CHAR       : 'char';
CLASS      : 'class';
CONST      : 'const';
CONTINUE   : 'continue';
DEFAULT    : 'default';
DO         : 'do';
DOUBLE     : 'double';
ELSE       : 'else';
ENUM       : 'enum';
EXTENDS    : 'extends';
FINAL      : 'final';
FINALLY    : 'finally';
FLOAT      : 'float';
FOR        : 'for';
IF         : 'if';
GOTO       : 'goto';
IMPLEMENTS : 'implements';
IMPORT     : 'import';
INSTANCEOF : 'instanceof';
INT        : 'int';
INTERFACE  : 'interface';
LONG       : 'long';
NATIVE     : 'native';
NEW        : 'new';
PACKAGE    : 'package';
PRIVATE    : 'private';
PROTECTED  : 'protected';
PUBLIC     : 'public';
RETURN     : 'return';
SHORT      : 'short';
STATIC     : 'static';
STRICTFP   : 'strictfp';
SUPER      : 'super';
SWITCH     : 'switch';
SYNCHRONIZED : 'synchronized';
THIS       : 'this';
THROW      : 'throw';
THROWS     : 'throws';
TRANSIENT  : 'transient';
TRY        : 'try';
VOID       : 'void';
VOLATILE   : 'volatile';
WHILE      : 'while';
RECORD     : 'record';
SEALED     : 'sealed';
PERMITS    : 'permits';
NON_SEALED : 'non-sealed';

//=====================================================
// LITERALES
//=====================================================

TRUE        : 'true';
FALSE       : 'false';
NULL        : 'null';

INTEGER_LITERAL
    : [0-9]+
    ;

FLOAT_LITERAL
    : [0-9]+ '.' [0-9]+
    ;

CHAR_LITERAL
    : '\'' ( ~['\\] | '\\' . ) '\''
    ;

STRING_LITERAL
    : '"' ( ~["\\] | '\\' . )* '"'
    ;

//=====================================================
// IDENTIFICADORES
//=====================================================

IDENTIFIER
    : [a-zA-Z_$] [a-zA-Z0-9_$]*
    ;

//=====================================================
// OPERADORES ARITMÉTICOS
//=====================================================

PLUS        : '+';
MINUS       : '-';
MULT        : '*';
DIV         : '/';
MOD         : '%';

INC         : '++';
DEC         : '--';

//=====================================================
// OPERADORES DE ASIGNACIÓN
//=====================================================

ASSIGN      : '=';
ADD_ASSIGN  : '+=';
SUB_ASSIGN  : '-=';
MUL_ASSIGN  : '*=';
DIV_ASSIGN  : '/=';
MOD_ASSIGN  : '%=';

//=====================================================
// OPERADORES RELACIONALES
//=====================================================

EQUAL       : '==';
NOTEQUAL    : '!=';
GT          : '>';
LT          : '<';
GE          : '>=';
LE          : '<=';

//=====================================================
// OPERADORES LÓGICOS
//=====================================================

AND         : '&&';
OR          : '||';
NOT         : '!';

//=====================================================
// OPERADORES BIT A BIT
//=====================================================

BIT_AND     : '&';
BIT_OR      : '|';
BIT_XOR     : '^';
BIT_NOT     : '~';

LSHIFT      : '<<';
RSHIFT      : '>>';
URSHIFT     : '>>>';

//=====================================================
// OPERADOR TERNARIO
//=====================================================

QUESTION    : '?';
COLON       : ':';

//=====================================================
// DELIMITADORES
//=====================================================

LPAREN      : '(';
RPAREN      : ')';

LBRACE      : '{';
RBRACE      : '}';

LBRACK      : '[';
RBRACK      : ']';

SEMICOLON   : ';';
COMMA       : ',';
DOT         : '.';

AT          : '@';

ELLIPSIS    : '...';

//=====================================================
// COMENTARIOS
//=====================================================

LINE_COMMENT
    : '//' ~[\r\n]* -> skip
    ;

BLOCK_COMMENT
    : '/*' .*? '*/' -> skip
    ;

//=====================================================
// ESPACIOS
//=====================================================

WS
    : [ \t\r\n\f]+ -> skip
    ;