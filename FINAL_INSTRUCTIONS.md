# 🎯 Instrucciones Finales - Ejecutar la Aplicación

## ✅ Lo que se ha completado

1. ✅ **Estructura unificada** - Backend y frontend en una sola carpeta
2. ✅ **URLs de API corregidas** - Sin duplicación de `/api`
3. ✅ **Manejo de errores mejorado** - Dashboard muestra datos incluso si la API falla
4. ✅ **Página de entidades creada** - Menú lateral completo
5. ✅ **Documentación completa** - 7 archivos de guías

## 🚀 Pasos para Ejecutar

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

**Edita `backend/.env`:**
```env
# Base de datos (REQUERIDO)
DATABASE_URL=postgresql://user:password@localhost:5432/scraper_db

# JWT (REQUERIDO)
JWT_SECRET=tu_clave_secreta_super_segura_aqui_minimo_32_caracteres

# Redis (Opcional pero recomendado)
REDIS_URL=redis://localhost:6379

# APIs externas (Opcional)
GROQ_API_KEY=tu_api_key_aqui

# Servidor
BACKEND_PORT=3000
NODE_ENV=development
CORS_ORIGIN=http://localhost:3000
```

**Ejecuta migraciones:**
```bash
npx prisma migrate dev
cd ..
```

### Paso 3: Configurar Frontend

```bash
cd frontend
cp .env.example .env.local
```

**Edita `frontend/.env.local`:**
```env
# ⚠️ CRÍTICO: SIN /api al final
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

**Esto iniciará:**
- Backend en http://localhost:3000
- Frontend en http://localhost:3000 (Next.js dev server)

### Paso 5: Acceder a la Aplicación

1. Abre http://localhost:3000 en tu navegador
2. Haz clic en "Registrarse"
3. Crea una cuenta con:
   - Nombre: Tu nombre
   - Email: tu@email.com
   - Contraseña: mínimo 6 caracteres
4. ¡Listo! Verás el dashboard con el menú lateral

## 🔍 Verificar que Todo Funciona

### Checklist

- [ ] Backend ejecutándose sin errores
- [ ] Frontend ejecutándose sin errores
- [ ] Puedes acceder a http://localhost:3000
- [ ] Puedes registrarte
- [ ] Puedes iniciar sesión
- [ ] Ves el menú lateral en el dashboard
- [ ] Las tarjetas de estadísticas muestran datos
- [ ] Puedes navegar por las diferentes secciones

### Logs Esperados

**Backend:**
```
Server running on port 3000
Database connected
```

**Frontend:**
```
▲ Next.js 16.0.0
- Local:        http://localhost:3000
```

## 🐛 Si Algo No Funciona

### Error: "Cannot find module"
```bash
npm run install:all
```

### Error: "Port 3000 already in use"
```bash
lsof -ti:3000 | xargs kill -9
```

### Error: "DATABASE_URL is not set"
```bash
cd backend
cp .env.example .env
# Edita .env con tu DATABASE_URL
npx prisma migrate dev
cd ..
```

### Error: "HTTP 404 en métricas"
**Verificar que `frontend/.env.local` tiene:**
```env
NEXT_PUBLIC_API_URL=http://localhost:3000
```
(Sin `/api` al final)

### El menú lateral no aparece
1. Verifica que estés autenticado
2. Recarga la página (F5)
3. Abre la consola del navegador (F12) y busca errores

## 📊 Estructura de Carpetas

```
Scraperv3/
├── backend/                 # API REST
│   ├── src/
│   ├── prisma/             # Base de datos
│   ├── .env                # Variables de entorno
│   └── package.json
├── frontend/               # Web App
│   ├── app/
│   ├── src/
│   ├── .env.local          # Variables de entorno
│   └── package.json
├── package.json            # Raíz
└── README.md
```

## 🔐 Seguridad

### Antes de Producción

- [ ] Cambiar `JWT_SECRET` a una clave fuerte
- [ ] Cambiar `DATABASE_URL` a una BD segura
- [ ] Usar HTTPS
- [ ] Configurar CORS correctamente
- [ ] Ejecutar `npm audit`

```bash
npm audit
npm audit fix
```

## 📚 Documentación

- [`COMPLETE_SETUP.md`](COMPLETE_SETUP.md) - Guía completa
- [`QUICK_START.md`](QUICK_START.md) - Inicio rápido
- [`TROUBLESHOOTING.md`](TROUBLESHOOTING.md) - Solución de problemas
- [`PROJECT_STRUCTURE.md`](PROJECT_STRUCTURE.md) - Estructura del proyecto

## 🎓 Próximos Pasos

1. **Configurar Base de Datos**: PostgreSQL local o remota
2. **Crear Usuario Admin**: `node scripts/create-admin.js`
3. **Explorar la Aplicación**: Navega por todas las secciones
4. **Configurar APIs**: Groq u otros servicios
5. **Personalizar**: Modifica según tus necesidades

## ✨ Características Disponibles

### Para Usuarios Regulares
- ✅ Mis Fuentes - Gestionar fuentes de noticias
- ✅ Búsqueda IA - Buscar con inteligencia artificial
- ✅ Mis Artículos - Ver artículos guardados
- ✅ Monitor de Entidades - Monitorear entidades

### Para Administradores
- ✅ Panel Admin - Visión general del sistema
- ✅ Web Scraper - Gestionar URLs y scraping
- ✅ Usuarios - Gestionar usuarios
- ✅ Estadísticas - Ver métricas del sistema
- ✅ Sistema - Configuración del sistema
- ✅ Caché - Gestionar caché
- ✅ Colas - Ver colas de trabajo
- ✅ Tokens IA - Monitorear uso de IA

## 🎉 ¡Listo!

Tu aplicación está completamente configurada y lista para usar.

**Ejecuta:**
```bash
npm run dev
```

**Y accede a:**
```
http://localhost:3000
```

¡Disfruta! 🚀