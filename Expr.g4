grammar Expr;

//REGLAS SINTACTICAS

// Regla inicial: de un archivo Java
programa: declaracion* EOF;

// Declaraciones permitidas en el programa
declaracion: importacion| declaracionClase| declaracionInterfaz| declaracionEnum;

// import java.util.Scanner;
importacion: IMPORT nombreCalificado SEMICOLON;

// java.util.Scanner
nombreCalificado: IDENTIFIER (DOT IDENTIFIER)*;

// public class MiClase extends Padre implements Interfaz { ... }
declaracionClase: modificador* CLASS IDENTIFIER herencia? implementacion? bloqueClase;

// public interface MiInterfaz extends Otra { ... }
declaracionInterfaz: modificador* INTERFACE IDENTIFIER herencia? bloqueClase;

// public enum Dia { LUNES, MARTES, MIERCOLES }
declaracionEnum: modificador* ENUM IDENTIFIER LBRACE IDENTIFIER(COMMA IDENTIFIER)* COMMA? RBRACE;

// extends ClaseBase
herencia: EXTENDS nombreCalificado;

// implements Serializable, Cloneable
implementacion: IMPLEMENTS nombreCalificado (COMMA nombreCalificado)*;

// Contenido de una clase o interfaz
bloqueClase: LBRACE miembroClase* RBRACE;

// Atributos, métodos, constructores o bloques static
miembroClase: declaracionVariable| declaracionMetodo| constructor| bloqueEstatico;

// static { ... }
bloqueEstatico: STATIC bloque;

// public static void main(String[] args) { ... }
declaracionMetodo: modificador* tipo VOID? IDENTIFIER LPAREN parametros? RPAREN throwsDeclaracion? bloque;

// Constructor: public MiClase(int x) { ... }
constructor: modificador* IDENTIFIER LPAREN parametros? RPAREN bloque;

// throws IOException, Exception
throwsDeclaracion: THROWS nombreCalificado (COMMA nombreCalificado)*;

// Parámetros de un método
parametros: parametro (COMMA parametro)*;

parametro: tipo IDENTIFIER | FINAL tipo IDENTIFIER;

// Tipos de dato básicos o nombres de clase
tipo: BOOLEAN | BYTE | CHAR| DOUBLE| FLOAT| INT| LONG| SHORT| IDENTIFIER;

// public, private, static, final, etc.
modificador: PUBLIC| PRIVATE| PROTECTED| STATIC| FINAL| ABSTRACT| TRANSIENT| VOLATILE| SYNCHRONIZED| NATIVE| STRICTFP;

// int edad = 20;
// String nombre = "Ana";
declaracionVariable : modificador* tipo variableInicializada (COMMA variableInicializada)* SEMICOLON;

variableInicializada: IDENTIFIER (ASSIGN expresion)? ;

// Bloque de instrucciones { ... }
bloque: LBRACE sentencia* RBRACE ;

// Sentencias aceptadas
sentencia: declaracionVariable SEMICOLON
    | asignacion SEMICOLON
    | llamadaMetodo SEMICOLON
    | sentenciaIf
    | sentenciaWhile
    | sentenciaFor
    | sentenciaDoWhile
    | sentenciaSwitch
    | sentenciaTryCatch
    | sentenciaReturn
    | BREAK SEMICOLON
    | CONTINUE SEMICOLON
    | THROW expresion SEMICOLON
    | bloque;

// x = 10;  edad += 1;
asignacion: acceso asignador expresion;

asignador: ASSIGN
    | ADD_ASSIGN
    | SUB_ASSIGN
    | MUL_ASSIGN
    | DIV_ASSIGN
    | MOD_ASSIGN;

// if (edad >= 18) { ... } else { ... }
sentenciaIf
    : IF LPAREN expresion RPAREN sentencia
    (ELSE sentencia)?;

// while (x < 10) { ... }
sentenciaWhile
    : WHILE LPAREN expresion RPAREN sentencia;

// for (int i = 0; i < 10; i++) { ... }
sentenciaFor
    : FOR LPAREN inicializacionFor? SEMICOLON
    expresion? SEMICOLON
    actualizacionFor? RPAREN
    sentencia;

inicializacionFor: declaracionFor
    | asignacion;

declaracionFor: tipo variableInicializada;

actualizacionFor: asignacion
    | expresion;

// do { ... } while (condicion);
sentenciaDoWhile
    : DO sentencia WHILE LPAREN expresion RPAREN SEMICOLON;

// switch (opcion) { case 1: ... break; default: ... }
sentenciaSwitch
    : SWITCH LPAREN expresion RPAREN
    LBRACE casoSwitch* defectoSwitch? RBRACE ;

casoSwitch
    : CASE expresion COLON sentencia* ;

defectoSwitch
    : DEFAULT COLON sentencia* ;

// try { ... } catch (Exception e) { ... } finally { ... }
sentenciaTryCatch
    : TRY bloque catchBloque+ finallyBloque? ;

catchBloque
    : CATCH LPAREN tipo IDENTIFIER RPAREN bloque ;

finallyBloque
    : FINALLY bloque ;

// return;  return resultado;
sentenciaReturn
    : RETURN expresion? SEMICOLON ;

// Expresiones con prioridad de operadores
expresion
    : expresionOr ;

expresionOr
    : expresionAnd (OR expresionAnd)* ;

expresionAnd
    : expresionIgualdad (AND expresionIgualdad)* ;

expresionIgualdad
    : expresionRelacional ((EQUAL | NOTEQUAL) expresionRelacional)* ;

expresionRelacional
    : expresionAditiva ((GT | LT | GE | LE | INSTANCEOF) expresionAditiva)*;

expresionAditiva
    : expresionMultiplicativa ((PLUS | MINUS) expresionMultiplicativa)*;

expresionMultiplicativa
    : expresionUnaria ((MULT | DIV | MOD) expresionUnaria)* ;

expresionUnaria
    : (NOT | MINUS | PLUS | INC | DEC | BIT_NOT) expresionUnaria
    | expresionPostfija;

expresionPostfija: primario (INC | DEC)? ;

// Valores y accesos
primario
    : literal
    | acceso
    | llamadaMetodo
    | NEW IDENTIFIER LPAREN argumentos? RPAREN
    | THIS
    | SUPER
    | LPAREN expresion RPAREN ;
 
// objeto.metodo() o System.out.println()
llamadaMetodo
    : acceso LPAREN argumentos? RPAREN ;

argumentos
    : expresion (COMMA expresion)* ;

// variable, objeto.atributo o arreglo[indice]
acceso
    : IDENTIFIER (DOT IDENTIFIER | LBRACK expresion RBRACK)* ;

// Literales reconocidos por el léxico
literal: INTEGER_LITERAL
    | FLOAT_LITERAL
    | CHAR_LITERAL
    | STRING_LITERAL
    | TRUE
    | FALSE
    | NULL;


// PALABRAS RESERVADAS

ABSTRACT: 'abstract';
ASSERT: 'assert';
BOOLEAN: 'boolean';
BREAK: 'break';
BYTE: 'byte';
CASE: 'case';
CATCH: 'catch';
CHAR: 'char';
CLASS: 'class';
CONST: 'const';
CONTINUE: 'continue';
DEFAULT: 'default';
DO: 'do';
DOUBLE: 'double';
ELSE: 'else';
ENUM: 'enum';
EXTENDS: 'extends';
FINAL: 'final';
FINALLY: 'finally';
FLOAT: 'float';
FOR: 'for';
IF: 'if';
GOTO: 'goto';
IMPLEMENTS: 'implements';
IMPORT: 'import';
INSTANCEOF : 'instanceof';
INT: 'int';
INTERFACE: 'interface';
LONG: 'long';
NATIVE: 'native';
NEW: 'new';
PACKAGE: 'package';
PRIVATE: 'private';
PROTECTED: 'protected';
PUBLIC: 'public';
RETURN: 'return';
SHORT: 'short';
STATIC: 'static';
STRICTFP: 'strictfp';
SUPER: 'super';
SWITCH: 'switch';
SYNCHRONIZED: 'synchronized';
THIS: 'this';
THROW: 'throw';
THROWS: 'throws';
TRANSIENT: 'transient';
TRY: 'try';
VOID: 'void';
VOLATILE: 'volatile';
WHILE: 'while';
RECORD: 'record';
SEALED: 'sealed';
PERMITS: 'permits';
NON_SEALED: 'non-sealed';

// LITERALES
TRUE: 'true';
FALSE: 'false';
NULL: 'null';

INTEGER_LITERAL:[0-9]+;

FLOAT_LITERAL:[0-9]+ '.' [0-9]+;

CHAR_LITERAL: '\'' ( ~['\\] | '\\' . ) '\'';

STRING_LITERAL: '"' ( ~["\\] | '\\' . )* '"';


// IDENTIFICADORES

IDENTIFIER:[a-zA-Z_$] [a-zA-Z0-9_$]*;


// OPERADORES ARITMÉTICOS

PLUS: '+';
MINUS: '-';
MULT: '*';
DIV: '/';
MOD: '%';
INC: '++';
DEC: '--';


// OPERADORES DE ASIGNACIÓN
ASSIGN: '=';
ADD_ASSIGN: '+=';
SUB_ASSIGN: '-=';
MUL_ASSIGN: '*=';
DIV_ASSIGN: '/=';
MOD_ASSIGN: '%=';

// OPERADORES RELACIONALES
EQUAL: '==';
NOTEQUAL: '!=';
GT: '>';
LT: '<';
GE: '>=';
LE: '<=';

// OPERADORES LÓGICOS
AND: '&&';
OR: '||';
NOT: '!';


// OPERADORES BIT A BIT
BIT_AND: '&';
BIT_OR: '|';
BIT_XOR: '^';
BIT_NOT: '~';
LSHIFT: '<<';
RSHIFT: '>>';
URSHIFT: '>>>';


// OPERADOR TERNARIO
QUESTION: '?';
COLON: ':';

// DELIMITADORES
LPAREN: '(';
RPAREN: ')';
LBRACE: '{';
RBRACE: '}';
LBRACK: '[';
RBRACK: ']';
SEMICOLON: ';';
COMMA: ',';
DOT: '.';
AT: '@';
ELLIPSIS: '...';

// COMENTARIOS
LINE_COMMENT: '//' ~[\r\n]* -> skip;

BLOCK_COMMENT: '/*' .*? '*/' -> skip;

// ESPACIOS
WS:[ \t\r\n\f]+ -> skip;