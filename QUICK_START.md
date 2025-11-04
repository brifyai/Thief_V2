# ⚡ Inicio Rápido - AI Scraper

## 🚀 En 3 Pasos

### 1️⃣ Instalar
```bash
chmod +x setup.sh
./setup.sh
```

### 2️⃣ Configurar
```bash
# Backend
cp backend/.env.example backend/.env
# Edita backend/.env con tus valores

# Frontend
cp frontend/.env.example frontend/.env.local
# Edita frontend/.env.local
```

### 3️⃣ Ejecutar
```bash
npm run dev
```

✅ **Listo!** Accede a http://localhost:3000

---

## 📚 Documentación

| Archivo | Descripción |
|---------|-------------|
| [`README.md`](README.md) | Documentación completa |
| [`SETUP_GUIDE.md`](SETUP_GUIDE.md) | Guía detallada de configuración |
| [`PROJECT_STRUCTURE.md`](PROJECT_STRUCTURE.md) | Estructura del proyecto |
| [`QUICK_START.md`](QUICK_START.md) | Este archivo |

---

## 🛠️ Comandos Útiles

```bash
# Desarrollo
npm run dev              # Backend + Frontend
npm run dev:backend      # Solo backend
npm run dev:frontend     # Solo frontend

# Build
npm run build            # Compilar ambas
npm run build:backend    # Solo backend
npm run build:frontend   # Solo frontend

# Producción
npm start                # Ejecutar ambas
npm run start:backend    # Solo backend
npm run start:frontend   # Solo frontend

# Base de datos (Backend)
cd backend
npx prisma migrate dev   # Ejecutar migraciones
npx prisma studio       # Abrir Prisma Studio
cd ..
```

---

## 🔧 Requisitos

- Node.js >= 18.x
- npm >= 9.x
- PostgreSQL (para backend)

---

## 📁 Estructura

```
.
├── backend/          # API REST (Node.js + Express)
├── frontend/         # Web App (Next.js + React)
├── package.json      # Configuración monorepo
├── setup.sh          # Script de instalación
└── README.md         # Documentación
```

---

## ❓ Problemas Comunes

### Puerto 3000 en uso
```bash
lsof -ti:3000 | xargs kill -9
```

### Dependencias no instaladas
```bash
npm run install:all
```

### Base de datos no configurada
```bash
cd backend
cp .env.example .env
# Edita .env con tu DATABASE_URL
npx prisma migrate dev
cd ..
```

---

## 📖 Más Información

Para más detalles, consulta:
- [`SETUP_GUIDE.md`](SETUP_GUIDE.md) - Configuración completa
- [`PROJECT_STRUCTURE.md`](PROJECT_STRUCTURE.md) - Estructura del proyecto
- `backend/src/config/README.md` - Documentación del backend
- `frontend/README.md` - Documentación del frontend

---

**¡Listo para empezar!** 🎉