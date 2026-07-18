import streamlit as st
# Importamos la función en el helper_compilador.py que inyectamos en este archivo para que se ejecute el análisis léxico y sintáctico
from helper_compilador import analizar_codigo

st.set_page_config(page_title="Analizador Java", page_icon="☕")

st.title("Analizador Léxico y Sintáctico de Java")
st.markdown("Sube tu archivo `.java` para comprobar si cumple con los requerimientos del proyecto.")

# El componente para subir el archivo
archivo_subido = st.file_uploader("Sube un archivo .java", type=["java"])

if archivo_subido is not None:
    # Leemos el contenido del archivo subido
    codigo_fuente = archivo_subido.getvalue().decode("utf-8")
    
    st.subheader("Código a analizar:")
    st.code(codigo_fuente, language="java")
    
    # Botón para detonar el análisis
    if st.button("Analizar Código", type="primary"):
        with st.spinner("Analizando..."):
            # Aquí ocurre la magia: llamamos a tu helper
            resultado = analizar_codigo(codigo_fuente)
            
            st.subheader("Resultado del Análisis:")
            # Usamos st.text para respetar los saltos de línea del árbol de sintaxis
            st.text(resultado)