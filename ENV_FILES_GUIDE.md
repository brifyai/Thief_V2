# Guía de Archivos .env

## 📋 Estructura de Archivos .env en el Proyecto

El proyecto tiene múltiples archivos `.env` para diferentes propósitos:

```
Thief_V2/
├── .env.example              # Ejemplo para raíz (no se usa actualmente)
├── backend/
│   ├── .env                  # ✅ ARCHIVO ACTIVO - Configuración real del backend
│   └── .env.example          # Ejemplo de configuración del backend
└── frontend/
    └── .env.example          # Ejemplo de configuración del frontend
```

---

## 🎯 Archivo Activo: `backend/.env`

### Ubicación
```
/Users/camiloalegria/Desktop/AIntelligence/Scrapper/Scraperv3/backend/.env
```

### Contenido Actual
```bash
# Chutes AI Configuration
CHUTES_API_KEY=cpk_178f36e444794015a6c6765c24569340.73d645ff58545311aa226d6de7ec2a15.W0WaeOgYQRVOVskEVTtzWUstJEUcl2Ls

# AI Model Configuration
AI_MODEL=openai/gpt-oss-20b
AI_REASONING_EFFORT=medium

# Server Configuration
PORT=3001
NODE_ENV=development

# Database
DATABASE_URL="postgresql://scraper:scraper123@localhost/scraping_db?schema=public"

# Redis
REDIS_URL="redis://localhost:6379"

# JWT
JWT_SECRET=dev_secret_key_12345678901234567890
JWT_EXPIRATION=24h

# CORS
ALLOWED_ORIGINS=http://localhost:3000,http://127.0.0.1:3000

# Rate Limiting
RATE_LIMIT_WINDOW_MS=900000
RATE_LIMIT_MAX_REQUESTS=100

# Scraping Configuration
SCRAPING_ENABLED=true
SCRAPING_SCHEDULES=0 2 * * *
SCRAPING_TIMEZONE=America/Santiago
SCRAPING_DELAY_MS=1000
SCRAPING_CONCURRENCY=5
SCRAPING_CACHE_TTL=3600

# Cleanup Configuration
CLEANUP_ENABLED=true
CLEANUP_RETENTION_DAYS=30
CLEANUP_SCHEDULE=0 3 * * 0
CLEANUP_TIMEZONE=America/Santiago

# Worker Configuration
ENABLE_WORKER=true
```

---

## 📁 Otros Archivos .env

### 1. `backend/.env.example`
**Propósito**: Plantilla de ejemplo para desarrolladores  
**Uso**: Referencia para crear `.env` local  
**Contenido**: Misma estructura que `backend/.env` pero sin valores reales

### 2. `frontend/.env.example`
**Propósito**: Plantilla de ejemplo para frontend  
**Uso**: Referencia para variables públicas del frontend  
**Contenido**: Variables públicas (NEXT_PUBLIC_*)

### 3. `.env.example` (raíz)
**Propósito**: Documentación general  
**Uso**: Referencia para la estructura completa  
**Contenido**: Combinación de backend y frontend

---

## 🔄 Flujo de Configuración

### Desarrollo Local
```
1. Clonar repositorio
2. Copiar backend/.env.example → backend/.env
3. Editar backend/.env con valores locales
4. Ejecutar: npm run dev
5. Backend carga variables de backend/.env
```

### Producción (Vercel)
```
1. Conectar repositorio a Vercel
2. Configurar variables en Vercel Dashboard
3. Vercel inyecta variables en tiempo de build
4. No se usa archivo .env (se ignora en .gitignore)
```

### Producción (Backend en Railway/Render)
```
1. Conectar repositorio a Railway/Render
2. Configurar variables en dashboard
3. Plataforma inyecta variables en runtime
4. No se usa archivo .env
```

---

## 🔐 Seguridad

### ✅ Lo Que Está Bien
- `backend/.env` está en `.gitignore`
- No se commitea a GitHub
- Contiene valores reales solo en desarrollo local
- En producción se usan variables de entorno del sistema

### ⚠️ Importante
```bash
# NUNCA hacer esto:
git add backend/.env
git commit -m "Agregar .env"

# SIEMPRE hacer esto:
# Usar variables de entorno del sistema en producción
export CHUTES_API_KEY="cpk_..."
export DATABASE_URL="postgresql://..."
```

---

## 📝 Cómo Usar

### Para Desarrollo Local

1. **Crear archivo `.env` en backend**
```bash
cp backend/.env.example backend/.env
```

2. **Editar valores según tu ambiente**
```bash
# backend/.env
CHUTES_API_KEY=tu_api_key_aqui
DATABASE_URL=postgresql://usuario:contraseña@localhost/db
REDIS_URL=redis://localhost:6379
```

3. **Ejecutar aplicación**
```bash
npm run dev
```

### Para Producción en Vercel

1. **Ir a Vercel Dashboard**
2. **Seleccionar proyecto**
3. **Settings → Environment Variables**
4. **Agregar variables:**
   - `NEXT_PUBLIC_API_URL`
   - `CHUTES_API_KEY`
   - Otras variables necesarias

### Para Producción en Railway/Render

1. **Ir a dashboard de la plataforma**
2. **Seleccionar aplicación**
3. **Environment → Variables**
4. **Agregar todas las variables necesarias**

---

## 🔍 Variables Críticas

### Backend (backend/.env)
```
CHUTES_API_KEY          # ✅ CRÍTICA - API Key de Chutes AI
DATABASE_URL            # ✅ CRÍTICA - Conexión a PostgreSQL
REDIS_URL               # ✅ CRÍTICA - Conexión a Redis
JWT_SECRET              # ✅ CRÍTICA - Secreto para JWT
PORT                    # Puerto del servidor (3001)
NODE_ENV                # Entorno (development/production)
```

### Frontend (variables públicas)
```
NEXT_PUBLIC_API_URL     # URL del backend API
```

---

## 🧪 Verificar Configuración

### Verificar que backend carga .env
```bash
cd backend
npm run dev

# Debe mostrar:
# ✅ Configuración validada correctamente
# ✅ Entorno: development
# ✅ Proveedor IA: Chutes AI (openai/gpt-oss-20b)
```

### Verificar variables específicas
```bash
# En Node.js
console.log(process.env.CHUTES_API_KEY);
console.log(process.env.DATABASE_URL);
console.log(process.env.PORT);
```

---

## 📊 Resumen de Archivos

| Archivo | Ubicación | Propósito | Gitignore |
|---------|-----------|----------|-----------|
| `.env` | `backend/.env` | ✅ ACTIVO - Configuración real | Sí |
| `.env.example` | `backend/.env.example` | Plantilla de ejemplo | No |
| `.env.example` | `frontend/.env.example` | Plantilla frontend | No |
| `.env.example` | `.env.example` | Documentación general | No |

---

## 🎯 Checklist

- [x] `backend/.env` contiene valores reales
- [x] `backend/.env` está en `.gitignore`
- [x] Variables críticas configuradas
- [x] Chutes AI API Key configurada
- [x] Database URL configurada
- [x] Redis URL configurada
- [x] JWT Secret configurado
- [x] Aplicación carga variables correctamente

---

## 📞 Troubleshooting

### Error: "CHUTES_API_KEY no está configurado"
```bash
# Solución: Verificar que backend/.env existe
ls -la backend/.env

# Si no existe:
cp backend/.env.example backend/.env
# Editar con valores reales
```

### Error: "Cannot connect to database"
```bash
# Solución: Verificar DATABASE_URL
echo $DATABASE_URL

# Debe ser:
postgresql://usuario:contraseña@localhost/db
```

### Error: "Cannot connect to Redis"
```bash
# Solución: Verificar REDIS_URL
echo $REDIS_URL

# Debe ser:
redis://localhost:6379
```

---

## 🎉 Conclusión

El proyecto utiliza `backend/.env` como archivo de configuración activo. Este archivo:

✅ Contiene todas las variables necesarias  
✅ Está protegido en `.gitignore`  
✅ Se carga automáticamente al iniciar el backend  
✅ Contiene la configuración de Chutes AI  

**¡La configuración está lista para usar!**

---

**Guía Creada**: 4 de Noviembre de 2025  
**Versión**: 1.0  
**Estado**: ✅ Listo para Usar