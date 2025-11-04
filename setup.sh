#!/bin/bash

# ============================================
# Script de Instalación - AI Scraper Monorepo
# ============================================

set -e

echo "🚀 Iniciando instalación de AI Scraper..."
echo ""

# Colores para output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Función para imprimir con color
print_step() {
    echo -e "${BLUE}▶ $1${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

# Verificar Node.js
print_step "Verificando Node.js..."
if ! command -v node &> /dev/null; then
    echo "❌ Node.js no está instalado. Por favor, instálalo desde https://nodejs.org/"
    exit 1
fi
NODE_VERSION=$(node -v)
print_success "Node.js $NODE_VERSION encontrado"

# Verificar npm
print_step "Verificando npm..."
if ! command -v npm &> /dev/null; then
    echo "❌ npm no está instalado."
    exit 1
fi
NPM_VERSION=$(npm -v)
print_success "npm $NPM_VERSION encontrado"

echo ""

# Instalar dependencias raíz
print_step "Instalando dependencias del proyecto raíz..."
npm install
print_success "Dependencias raíz instaladas"

echo ""

# Instalar dependencias del backend
print_step "Instalando dependencias del backend..."
cd backend
npm install
print_success "Dependencias del backend instaladas"

# Crear archivo .env si no existe
if [ ! -f .env ]; then
    print_warning "Archivo .env no encontrado en backend/"
    if [ -f .env.example ]; then
        cp .env.example .env
        print_success "Archivo .env creado desde .env.example"
        print_warning "⚠️  Por favor, actualiza backend/.env con tus valores"
    fi
fi

cd ..

echo ""

# Instalar dependencias del frontend
print_step "Instalando dependencias del frontend..."
cd frontend
npm install
print_success "Dependencias del frontend instaladas"

# Crear archivo .env.local si no existe
if [ ! -f .env.local ]; then
    print_warning "Archivo .env.local no encontrado en frontend/"
    if [ -f .env.example ]; then
        cp .env.example .env.local
        print_success "Archivo .env.local creado desde .env.example"
        print_warning "⚠️  Por favor, actualiza frontend/.env.local con tus valores"
    fi
fi

cd ..

echo ""
echo -e "${GREEN}✅ ¡Instalación completada exitosamente!${NC}"
echo ""
echo "📝 Próximos pasos:"
echo "1. Configura las variables de entorno:"
echo "   - backend/.env"
echo "   - frontend/.env.local"
echo ""
echo "2. Ejecuta las migraciones de base de datos (si es necesario):"
echo "   cd backend && npx prisma migrate dev"
echo ""
echo "3. Inicia el desarrollo:"
echo "   npm run dev"
echo ""
echo "Para más información, consulta README.md"