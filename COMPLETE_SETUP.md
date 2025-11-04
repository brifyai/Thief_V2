# 🎯 Guía Completa de Configuración - AI Scraper

Esta es la guía definitiva para configurar y ejecutar la aplicación completa.

## ⚡ Inicio Rápido (5 minutos)

### Paso 1: Instalar Dependencias

```bash
chmod +x setup.sh
./setup.sh
```

O manualmente:
```bash
npm run install:all
```

### Paso 2: Configurar Backend

```bash
cd backend
cp .env.example .env
```

Edita `backend/.env` y configura:
```env
# Base de datos (PostgreSQL recomendado)
DATABASE_URL=postgresql://user:password@localhost:5432/scraper_db

# JWT
JWT_SECRET=tu_clave_secreta_super_segura_aqui

# Redis (para caché)
REDIS_URL=redis://localhost:6379

# APIs externas
GROQ_API_KEY=tu_api_key_aqui

# Puerto
BACKEND_PORT=3000
NODE_ENV=development
```

Ejecuta migraciones:
```bash
npx prisma migrate dev
cd ..
```

### Paso 3: Configurar Frontend

```bash
cd frontend
cp .env.example .env.local
```

Edita `frontend/.env.local`:
```env
# ⚠️ IMPORTANTE: SIN /api al final
# El frontend agrega automáticamente /api a cada endpoint
NEXT_PUBLIC_API_URL=http://localhost:3000
```

```bash
cd ..
```

### Paso 4: Ejecutar la Aplicación

```bash
npm run dev
```

Esto iniciará:
- **Backend**: http://localhost:3000
- **Frontend**: http://localhost:3000 (Next.js dev server)

### Paso 5: Acceder a la Aplicación

1. Abre http://localhost:3000 en tu navegador
2. Haz clic en "Registrarse" para crear una cuenta
3. O usa credenciales de prueba si existen

---

## 🔧 Configuración Detallada

### Backend

#### Variables de Entorno Requeridas

```env
# Base de datos
DATABASE_URL=postgresql://user:password@localhost:5432/scraper_db

# Autenticación
JWT_SECRET=clave_super_segura_minimo_32_caracteres
JWT_EXPIRE=7d

# Redis
REDIS_URL=redis://localhost:6379

# APIs Externas
GROQ_API_KEY=gsk_xxxxxxxxxxxxx

# Servidor
BACKEND_PORT=3000
NODE_ENV=development

# CORS
CORS_ORIGIN=http://localhost:3000

# Logging
LOG_LEVEL=info
```

#### Crear Base de Datos

```bash
# PostgreSQL
createdb scraper_db

# O con psql
psql -U postgres
CREATE DATABASE scraper_db;
```

#### Ejecutar Migraciones

```bash
cd backend
npx prisma migrate dev
npx prisma generate
cd ..
```

#### Crear Usuario Admin (Opcional)

```bash
cd backend
node scripts/create-admin.js
cd ..
```

### Frontend

#### Variables de Entorno

```env
# API Configuration
# ⚠️ IMPORTANTE: NO incluir /api
NEXT_PUBLIC_API_URL=http://localhost:3000

# Opcional
NEXT_PUBLIC_ENV=development
```

#### Estructura de Carpetas

```
frontend/
├── app/                    # App Router (Next.js 13+)
│   ├── dashboard/         # Rutas protegidas
│   ├── login/             # Página de login
│   └── page.tsx           # Página raíz
├── src/
│   ├── components/        # Componentes React
│   ├── hooks/             # Custom hooks
│   ├── services/          # Servicios API
│   ├── lib/               # Utilidades
│   ├── types/             # TypeScript types
│   ├── middleware/        # Middleware
│   └── stores/            # Zustand stores
└── public/                # Archivos estáticos
```

---

## 📚 Rutas Disponibles

### Autenticación
- `POST /api/auth/login` - Iniciar sesión
- `POST /api/auth/register` - Registrarse
- `GET /api/auth/me` - Obtener usuario actual
- `GET /api/auth/verify` - Verificar token

### Scraping
- `GET /api/scraping/test` - Probar scraping
- `POST /api/scraping/start` - Iniciar scraping
- `GET /api/scraping/status` - Estado del scraping

### Búsqueda
- `GET /api/search` - Búsqueda general
- `POST /api/search/ai` - Búsqueda con IA

### Métricas
- `GET /api/metrics/general` - Métricas generales
- `GET /api/metrics/domains` - Métricas por dominio
- `GET /api/metrics/ai` - Métricas de IA

### Entidades
- `GET /api/entities` - Listar entidades
- `POST /api/entities` - Crear entidad
- `GET /api/entities/:id` - Obtener entidad
- `PUT /api/entities/:id` - Actualizar entidad
- `DELETE /api/entities/:id` - Eliminar entidad

---

## 🚀 Scripts Disponibles

### Raíz del Proyecto

```bash
npm run install:all      # Instalar todas las dependencias
npm run dev              # Ejecutar backend + frontend
npm run dev:backend      # Solo backend
npm run dev:frontend     # Solo frontend
npm run build            # Compilar ambas
npm run build:backend    # Compilar backend
npm run build:frontend   # Compilar frontend
npm start                # Ejecutar en producción
npm run start:backend    # Backend en producción
npm run start:frontend   # Frontend en producción
```

### Backend

```bash
cd backend

# Desarrollo
npm start

# Migraciones
npx prisma migrate dev
npx prisma migrate status
npx prisma migrate reset

# Prisma Studio
npx prisma studio

# Scripts
node scripts/create-admin.js
node scripts/create-user.js
node scripts/cleanup-old-news.js
```

### Frontend

```bash
cd frontend

# Desarrollo
npm run dev

# Build
npm run build

# Producción
npm start

# Linting
npm run lint
```

---

## 🔐 Seguridad

### Antes de Producción

- [ ] Cambiar `JWT_SECRET` a una clave fuerte (mínimo 32 caracteres)
- [ ] Cambiar `DATABASE_URL` a una BD segura
- [ ] Configurar `CORS_ORIGIN` correctamente
- [ ] Usar HTTPS en producción
- [ ] Configurar variables de entorno en el servidor
- [ ] Ejecutar `npm audit` para verificar vulnerabilidades
- [ ] Revisar permisos de archivos
- [ ] Configurar rate limiting
- [ ] Habilitar CSRF protection

```bash
npm audit
npm audit fix
```

---

## 🐛 Troubleshooting

### Error: "HTTP 404 en Métricas"

**Causa**: URL de API configurada incorrectamente

**Solución**:
```bash
# Verificar frontend/.env.local
NEXT_PUBLIC_API_URL=http://localhost:3000  # ✅ Correcto
# NO: NEXT_PUBLIC_API_URL=http://localhost:3000/api  # ❌ Incorrecto
```

### Error: "EADDRINUSE: address already in use :::3000"

**Solución**:
```bash
# Matar proceso en puerto 3000
lsof -ti:3000 | xargs kill -9

# O cambiar puerto en backend/.env
BACKEND_PORT=3001
```

### Error: "DATABASE_URL is not set"

**Solución**:
```bash
cd backend
cp .env.example .env
# Editar .env con tu DATABASE_URL
npx prisma migrate dev
cd ..
```

### Error: "Cannot find module 'concurrently'"

**Solución**:
```bash
npm install
```

### El Frontend no se conecta al Backend

**Checklist**:
- [ ] Backend ejecutándose en puerto 3000
- [ ] Frontend ejecutándose en puerto 3000 (Next.js dev)
- [ ] `NEXT_PUBLIC_API_URL=http://localhost:3000` (sin `/api`)
- [ ] Token válido en localStorage
- [ ] CORS configurado correctamente

---

## 📊 Estructura de Datos

### Usuario

```typescript
{
  id: number;
  name: string;
  email: string;
  role: 'admin' | 'user';
  created_at: string;
}
```

### Artículo

```typescript
{
  id: string;
  title: string;
  content: string;
  url: string;
  domain: string;
  published_at: string;
  created_at: string;
}
```

### Entidad

```typescript
{
  id: string;
  name: string;
  type: string;
  description?: string;
  created_at: string;
  updated_at: string;
}
```

---

## 🔄 Flujo de Autenticación

```
1. Usuario accede a http://localhost:3000
2. Se redirige a /login (no autenticado)
3. Usuario se registra o inicia sesión
4. Backend valida credenciales y devuelve JWT
5. Frontend guarda token en localStorage
6. Se redirige a /dashboard
7. AuthGuard verifica token en cada ruta protegida
8. Si token es válido, muestra contenido
9. Si token es inválido, redirige a /login
```

---

## 📱 Componentes Principales

### Frontend

- **Sidebar**: Navegación principal
- **Header**: Información del usuario y tema
- **Dashboard**: Panel principal
- **Login**: Autenticación
- **Entities**: Gestión de entidades
- **Admin Panel**: Panel de administración

### Backend

- **Auth Controller**: Autenticación
- **Scraping Service**: Lógica de scraping
- **Entity Service**: Gestión de entidades
- **Metrics Service**: Cálculo de métricas
- **AI Service**: Integración con IA

---

## 🎓 Próximos Pasos

1. **Configurar Base de Datos**: PostgreSQL local o remota
2. **Configurar Redis**: Para caché y colas
3. **Obtener API Keys**: Groq u otros servicios
4. **Crear Usuario Admin**: Para acceso administrativo
5. **Configurar CORS**: Para producción
6. **Implementar Logging**: Para debugging
7. **Configurar Backups**: Para BD

---

## 📖 Documentación Adicional

- [`README.md`](README.md) - Documentación general
- [`QUICK_START.md`](QUICK_START.md) - Inicio rápido
- [`SETUP_GUIDE.md`](SETUP_GUIDE.md) - Guía de configuración
- [`PROJECT_STRUCTURE.md`](PROJECT_STRUCTURE.md) - Estructura del proyecto
- [`TROUBLESHOOTING.md`](TROUBLESHOOTING.md) - Solución de problemas
- `backend/src/config/README.md` - Documentación del backend
- `frontend/README.md` - Documentación del frontend

---

## ✅ Checklist Final

- [ ] Node.js >= 18.x instalado
- [ ] npm >= 9.x instalado
- [ ] PostgreSQL instalado y ejecutándose
- [ ] Redis instalado y ejecutándose (opcional)
- [ ] `backend/.env` configurado
- [ ] `frontend/.env.local` configurado
- [ ] Migraciones de Prisma ejecutadas
- [ ] `npm run dev` funciona sin errores
- [ ] Frontend accesible en http://localhost:3000
- [ ] Backend accesible en http://localhost:3000/api
- [ ] Puedes registrarte e iniciar sesión
- [ ] El menú lateral es visible
- [ ] Las métricas cargan correctamente

¡Listo! Tu aplicación está completamente configurada y lista para usar. 🎉