# 🔧 Troubleshooting - Solución de Problemas

## Error: HTTP 404 en Métricas

### Síntoma
```
HTTP error! status: 404
src/services/metrics.service.ts (184:15) @ MetricsService.getGeneralMetrics
```

### Causa
La URL de la API del frontend está configurada incorrectamente. El frontend está agregando `/api` automáticamente a cada endpoint, pero si la variable de entorno incluye `/api`, resulta en URLs duplicadas como `http://localhost:3000/api/api/metrics/general`.

### Solución

#### 1. Verificar `frontend/.env.local`

```bash
# ❌ INCORRECTO
NEXT_PUBLIC_API_URL=http://localhost:3000/api

# ✅ CORRECTO
NEXT_PUBLIC_API_URL=http://localhost:3000
```

#### 2. Verificar `frontend/src/lib/api-secure.ts`

Debe estar configurado así:
```typescript
export const API_BASE_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3000';
```

#### 3. Pasos para Corregir

```bash
# 1. Detener la aplicación (Ctrl+C)

# 2. Editar el archivo frontend/.env.local
cd frontend
nano .env.local  # o usa tu editor favorito

# 3. Cambiar la línea:
# De: NEXT_PUBLIC_API_URL=http://localhost:3000/api
# A:  NEXT_PUBLIC_API_URL=http://localhost:3000

# 4. Guardar y salir

# 5. Reiniciar la aplicación
cd ..
npm run dev
```

---

## Error: "Cannot find module 'concurrently'"

### Síntoma
```
Error: Cannot find module 'concurrently'
```

### Causa
Las dependencias del proyecto raíz no están instaladas.

### Solución
```bash
npm install
```

---

## Error: "EADDRINUSE: address already in use :::3000"

### Síntoma
```
Error: listen EADDRINUSE: address already in use :::3000
```

### Causa
El puerto 3000 ya está siendo usado por otro proceso.

### Solución

#### Opción 1: Matar el proceso que usa el puerto
```bash
# macOS/Linux
lsof -ti:3000 | xargs kill -9

# Windows
netstat -ano | findstr :3000
taskkill /PID <PID> /F
```

#### Opción 2: Cambiar el puerto del backend
```bash
# Editar backend/.env
BACKEND_PORT=3001

# Luego actualizar frontend/.env.local
NEXT_PUBLIC_API_URL=http://localhost:3001
```

---

## Error: "DATABASE_URL is not set"

### Síntoma
```
Error: DATABASE_URL is not set
```

### Causa
El archivo `backend/.env` no existe o no tiene la variable `DATABASE_URL`.

### Solución
```bash
# 1. Crear el archivo .env
cd backend
cp .env.example .env

# 2. Editar backend/.env y agregar tu URL de BD
nano .env

# Ejemplo para PostgreSQL local:
DATABASE_URL="postgresql://user:password@localhost:5432/scraper_db"

# 3. Ejecutar migraciones
npx prisma migrate dev

# 4. Volver a la raíz
cd ..
```

---

## Error: "NEXT_PUBLIC_API_URL is not set"

### Síntoma
```
Error: NEXT_PUBLIC_API_URL is not set
```

### Causa
El archivo `frontend/.env.local` no existe.

### Solución
```bash
# 1. Crear el archivo .env.local
cd frontend
cp .env.example .env.local

# 2. Verificar que contiene:
NEXT_PUBLIC_API_URL=http://localhost:3000

# 3. Volver a la raíz
cd ..

# 4. Reiniciar el frontend
npm run dev:frontend
```

---

## Error: "No authentication token found"

### Síntoma
```
AuthenticationError: No authentication token found. Please login again.
```

### Causa
No hay token de autenticación en localStorage. Necesitas hacer login primero.

### Solución
1. Accede a http://localhost:3000/login
2. Ingresa tus credenciales
3. El token se guardará automáticamente
4. Intenta acceder a la página nuevamente

---

## Error: "Session expired"

### Síntoma
```
AuthenticationError: Session expired. Please login again.
```

### Causa
El token JWT ha expirado.

### Solución
1. Haz logout (si es posible)
2. Limpia el localStorage:
   ```javascript
   // En la consola del navegador
   localStorage.clear()
   ```
3. Recarga la página
4. Haz login nuevamente

---

## Error: "Prisma migrations failed"

### Síntoma
```
Error: Migration failed
```

### Causa
Hay un conflicto en las migraciones de Prisma.

### Solución
```bash
cd backend

# 1. Ver estado de migraciones
npx prisma migrate status

# 2. Si hay migraciones pendientes
npx prisma migrate deploy

# 3. Si necesitas resetear (⚠️ BORRA TODOS LOS DATOS)
npx prisma migrate reset

# 4. Volver a la raíz
cd ..
```

---

## Error: "Port 3000 is already in use by another process"

### Síntoma
El backend no puede iniciar porque el puerto está ocupado.

### Solución
```bash
# Encontrar qué proceso usa el puerto
lsof -i :3000

# Matar el proceso
kill -9 <PID>

# O cambiar el puerto en backend/.env
BACKEND_PORT=3001
```

---

## El Frontend no se conecta al Backend

### Síntomas
- Las peticiones fallan con 404
- Las métricas no cargan
- Los datos no se sincronizan

### Checklist de Diagnóstico

- [ ] ¿El backend está ejecutándose? (`npm run dev:backend`)
- [ ] ¿El frontend está ejecutándose? (`npm run dev:frontend`)
- [ ] ¿`NEXT_PUBLIC_API_URL` está configurado correctamente?
- [ ] ¿No incluye `/api` al final?
- [ ] ¿El puerto es correcto?
- [ ] ¿Hay un token válido en localStorage?
- [ ] ¿Las variables de entorno se cargaron después de cambiarlas?

### Pasos para Debuggear

1. Abre la consola del navegador (F12)
2. Ve a la pestaña "Network"
3. Intenta hacer una acción que requiera API
4. Busca la petición fallida
5. Verifica:
   - URL completa
   - Status code
   - Headers
   - Response

---

## Limpiar y Reinstalar Todo

Si nada funciona, intenta una instalación limpia:

```bash
# 1. Eliminar node_modules
rm -rf node_modules backend/node_modules frontend/node_modules

# 2. Eliminar package-lock.json
rm -f package-lock.json backend/package-lock.json frontend/package-lock.json

# 3. Reinstalar todo
npm run install:all

# 4. Configurar variables de entorno
cp backend/.env.example backend/.env
cp frontend/.env.example frontend/.env.local

# 5. Ejecutar migraciones
cd backend
npx prisma migrate dev
cd ..

# 6. Iniciar
npm run dev
```

---

## Verificar Logs

### Backend
```bash
npm run dev:backend
# Los logs aparecerán en la terminal
```

### Frontend
```bash
npm run dev:frontend
# Los logs aparecerán en la terminal y en la consola del navegador
```

### Base de Datos
```bash
cd backend
npx prisma studio
# Se abrirá una interfaz web para ver la BD
```

---

## Contacto y Soporte

Si el problema persiste:

1. Revisa los logs completos
2. Verifica que todas las variables de entorno estén configuradas
3. Intenta una instalación limpia
4. Consulta la documentación en `README.md` y `SETUP_GUIDE.md`

---

## Checklist Rápido

- [ ] Node.js >= 18.x instalado
- [ ] npm >= 9.x instalado
- [ ] `backend/.env` existe y está configurado
- [ ] `frontend/.env.local` existe y está configurado
- [ ] `NEXT_PUBLIC_API_URL=http://localhost:3000` (sin `/api`)
- [ ] Base de datos configurada y migraciones ejecutadas
- [ ] Puerto 3000 disponible
- [ ] Token de autenticación válido

¡Listo! Si aún tienes problemas, revisa los logs y la documentación.