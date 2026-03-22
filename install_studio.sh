#!/bin/bash

# =================================================================
# SCRIPT DE INSTALACIÓN AUTOMATIZADA: ANDROID STUDIO ARM64 (TERMUX)
# =================================================================

echo "🚀 Iniciando configuración de Android Studio..."

# 1. Definir rutas (Ajusta estas si tus carpetas se llaman distinto)
STUDIO_DIR="$HOME/android-studio"
IDEA_DIR="$HOME/idea-IC" # Asegúrate de que este sea el nombre tras extraer IntelliJ

# 2. Actualizar sistema e instalar dependencias necesarias
echo "📦 Instalando OpenJDK 21 y dependencias..."
sudo apt update
sudo apt install -y openjdk-21-jdk tar wget

# 3. Parche de compatibilidad (El corazón del proceso)
echo "🔧 Aplicando parche de librerías ARM64 desde IntelliJ..."

if [ -d "$IDEA_DIR" ] && [ -d "$STUDIO_DIR" ]; then
    # Copiar librerías JNA, Native y Pty4j
    cp -r "$IDEA_DIR/lib/jna/"* "$STUDIO_DIR/lib/jna/"
    cp -r "$IDEA_DIR/lib/native/"* "$STUDIO_DIR/lib/native/"
    cp -r "$IDEA_DIR/lib/pty4j/"* "$STUDIO_DIR/lib/pty4j/"
    echo "✅ Librerías parcheadas correctamente."
else
    echo "❌ Error: No se encontraron las carpetas de Android Studio o IntelliJ."
    exit 1
fi

# 4. Configuración del Java Runtime (JBR)
echo "☕ Configurando Java Runtime compatible..."
if [ -d "$STUDIO_DIR/jbr" ]; then
    rm -rf "$STUDIO_DIR/jbr"
fi

# Crear el enlace simbólico al JDK del sistema
ln -s /usr/lib/jvm/java-21-openjdk-arm64 "$STUDIO_DIR/jbr"
echo "✅ Enlace simbólico de Java creado."

# 5. Permisos de ejecución
echo "🔑 Otorgando permisos de ejecución..."
chmod +x "$STUDIO_DIR/bin/studio.sh"

echo "----------------------------------------------------"
echo "🎉 ¡PROCESO COMPLETADO!"
echo "Para iniciar Android Studio, usa:"
echo "cd $STUDIO_DIR/bin && ./studio.sh"
echo "----------------------------------------------------"
