from antlr4 import *
from ExprLexer import ExprLexer
from ExprParser import ExprParser

def analizar_codigo(codigo_fuente):
    """
    Toma el código fuente en texto plano, lo pasa por el Lexer y el Parser,
    y devuelve el árbol de sintaxis o los errores encontrados.
    """
    try:
        # 1. Convertir el texto en un flujo de datos que ANTLR entienda
        input_stream = InputStream(codigo_fuente)
        
        # 2. Análisis Léxico (Mi parte)
        lexer = ExprLexer(input_stream)
        stream = CommonTokenStream(lexer)
        
        # 3. Análisis Sintáctico (La parte de Cris)
        parser = ExprParser(stream)
        
        # Le decimos al parser que empiece a leer desde la regla principal.
        # NOTA: Asegúrare de que la primera regla se llame 'program'
        tree = parser.program() 
        
        # Por ahora, solo devolvemos el árbol en formato de texto para ver si funciona
        return tree.toStringTree(recog=parser)
        
    except Exception as e:
        return f"Error en la compilación: {str(e)}"