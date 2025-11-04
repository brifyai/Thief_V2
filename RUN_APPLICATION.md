# 🚀 Ejecutar la Aplicación Unificada AI Web Scraper

## ✅ Estado Actual
La aplicación ha sido **unificada exitosamente** en una estructura de monorepo con:
- **Backend**: Express.js en puerto **3001**
- **Frontend**: Next.js en puerto **3000**
- **Base de Datos**: PostgreSQL
- **Autenticación**: JWT

## 📋 Requisitos Previos

Asegúrate de tener instalado:
- **Node.js** v18+ (recomendado v24+)
- **npm** v9+
- **PostgreSQL** 12+ (con usuario `scraper` y contraseña `scraper123`)
- **Redis** (opcional, para procesamiento en background)

## 🔧 Instalación Rápida

### 1. Instalar dependencias de ambas aplicaciones
```bash
npm run install-all
```

O manualmente:
```bash
npm install
cd backend && npm install && cd ..
cd frontend && npm install && cd ..
```

### 2. Configurar variables de entorno

El archivo `backend/.env` ya está configurado con:
- `PORT=3001` (Backend)
- `DATABASE_URL=postgresql://scraper:scraper123@localhost/scraping_db?schema=public`
- `JWT_SECRET=dev_secret_key_12345678901234567890`
- `GROQ_API_KEY=demo_key_for_development`

El archivo `frontend/.env.local` ya está configurado con:
- `NEXT_PUBLIC_API_URL=http://localhost:3001/api`

### 3. Ejecutar las migraciones de base de datos
```bash
cd backend
npx prisma migrate deploy
cd ..
```

### 4. Crear usuario de prueba (si es necesario)
```bash
cd backend
node scripts/create-user.js
cd ..
```

Credenciales de prueba:
- **Email**: `camiloalegriabarra@gmail.com`
- **Contraseña**: `admin123`
- **Rol**: `admin`

## 🎯 Ejecutar la Aplicación

### Opción 1: Ejecutar ambas aplicaciones simultáneamente (Recomendado)
```bash
npm run dev
```

Esto iniciará:
- ✅ Backend en `http://localhost:3001`
- ✅ Frontend en `http://localhost:3000`

### Opción 2: Ejecutar por separado

**Terminal 1 - Backend:**
```bash
npm run dev:backend
```

**Terminal 2 - Frontend:**
```bash
npm run dev:frontend
```

## 🌐 Acceder a la Aplicación

1. Abre tu navegador en: **http://localhost:3000**
2. Inicia sesión con:
   - Email: `camiloalegriabarra@gmail.com`
   - Contraseña: `admin123`
3. ¡Listo! Accederás al dashboard

## 📊 Endpoints Disponibles

### Backend API
- **Health Check**: `http://localhost:3001/health`
- **Documentación Swagger**: `http://localhost:3001/api-docs`
- **Login**: `POST http://localhost:3001/api/auth/login`

### Frontend
- **Dashboard**: `http://localhost:3000/dashboard`
- **Mis Fuentes**: `http://localhost:3000/dashboard/sources`
- **Búsqueda IA**: `http://localhost:3000/dashboard/ai-search`
- **Monitor de Entidades**: `http://localhost:3000/dashboard/entities`

## 🛠️ Scripts Disponibles

```bash
# Instalar todas las dependencias
npm run install-all

# Ejecutar ambas aplicaciones
npm run dev

# Ejecutar solo backend
npm run dev:backend

# Ejecutar solo frontend
npm run dev:frontend

# Build para producción
npm run build

# Ejecutar en producción
npm run start
```

## 🔍 Verificar que todo funciona

### 1. Verificar Backend
```bash
curl http://localhost:3001/health
```

Respuesta esperada:
```json
{
  "uptime": 123.456,
  "timestamp": 1234567890,
  "status": "ok",
  "services": {
    "database": "ok"
  }
}
```

### 2. Verificar Frontend
Abre `http://localhost:3000` en el navegador

### 3. Verificar Conexión Backend-Frontend
Intenta hacer login con las credenciales de prueba

## 🐛 Solución de Problemas

### Puerto 3000 o 3001 ya está en uso
```bash
# Matar procesos en los puertos
lsof -ti:3000 | xargs kill -9
lsof -ti:3001 | xargs kill -9
```

### Error de conexión a base de datos
```bash
# Verificar que PostgreSQL está corriendo
psql -U scraper -d scraping_db -c "SELECT 1"

# Si no existe la base de datos, crearla:
createdb -U scraper scraping_db
```

### Error de módulos no encontrados
```bash
# Limpiar node_modules y reinstalar
rm -rf node_modules backend/node_modules frontend/node_modules
npm run install-all
```

### Frontend no se conecta al backend
- Verificar que `frontend/.env.local` tiene `NEXT_PUBLIC_API_URL=http://localhost:3001/api`
- Verificar que el backend está corriendo en puerto 3001
- Limpiar caché del navegador (Ctrl+Shift+Delete)

## 📁 Estructura del Proyecto

```
Scraperv3/
├── backend/                 # Express.js API
│   ├── src/
│   │   ├── config/         # Configuración
│   │   ├── controllers/    # Controladores
│   │   ├── routes/         # Rutas
│   │   ├── services/       # Servicios
│   │   ├── middleware/     # Middleware
│   │   └── utils/          # Utilidades
│   ├── prisma/             # ORM Prisma
│   ├── scripts/            # Scripts útiles
│   ├── index.js            # Punto de entrada
│   └── package.json
│
├── frontend/               # Next.js App
│   ├── app/               # App Router
│   ├── src/
│   │   ├── components/    # Componentes React
│   │   ├── services/      # Servicios API
│   │   ├── hooks/         # Custom hooks
│   │   ├── lib/           # Utilidades
│   │   └── types/         # TypeScript types
│   ├── package.json
│   └── next.config.ts
│
├── package.json           # Root package.json
├── setup.sh              # Script de instalación
└── README.md             # Documentación
```

## 🚀 Despliegue en Producción

### Backend (Vercel, Railway, Render)
```bash
npm run build
npm start
```

### Frontend (Vercel, Netlify)
```bash
npm run build
npm start
```

## 📞 Soporte

Para más información, consulta:
- [`README.md`](README.md) - Documentación general
- [`SETUP_GUIDE.md`](SETUP_GUIDE.md) - Guía de configuración
- [`PROJECT_STRUCTURE.md`](PROJECT_STRUCTURE.md) - Estructura del proyecto
- [`TROUBLESHOOTING.md`](TROUBLESHOOTING.md) - Solución de problemas

---

**¡La aplicación está lista para usar! 🎉**