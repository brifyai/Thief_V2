# Guía de Configuración - Chutes AI

## 🚀 Inicio Rápido

### 1. Obtener API Key de Chutes AI

1. Visita https://chutes.ai
2. Crea una cuenta o inicia sesión
3. Ve a la sección de API Keys
4. Copia tu API Key (formato: `cpk_...`)

### 2. Configurar Variables de Entorno

#### Opción A: Archivo `.env` (Desarrollo)

```bash
# Chutes AI Configuration
CHUTES_API_KEY=tu_api_key_aqui

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

# CORS
ALLOWED_ORIGINS=http://localhost:3000,http://127.0.0.1:3000

# JWT
JWT_SECRET=dev_secret_key_12345678901234567890
JWT_EXPIRATION=24h
```

#### Opción B: Variables de Entorno del Sistema (Producción)

```bash
export CHUTES_API_KEY="tu_api_key_aqui"
export AI_MODEL="openai/gpt-oss-20b"
export AI_REASONING_EFFORT="medium"
export PORT="3001"
export NODE_ENV="production"
export DATABASE_URL="postgresql://user:pass@host/db"
export REDIS_URL="redis://host:port"
export ALLOWED_ORIGINS="https://tu-dominio.com"
export JWT_SECRET="tu_jwt_secret_seguro"
```

### 3. Instalar Dependencias

```bash
# Instalar todo (backend y frontend)
npm install

# O instalar por separado
cd backend && npm install
cd ../frontend && npm install
```

### 4. Ejecutar la Aplicación

#### Desarrollo (Ambos servidores)

```bash
npm run dev
```

Esto ejecutará:
- Backend en `http://localhost:3001`
- Frontend en `http://localhost:3000`

#### Desarrollo (Por separado)

```bash
# Terminal 1 - Backend
cd backend
npm run dev

# Terminal 2 - Frontend
cd frontend
npm run dev
```

#### Producción

```bash
# Build
npm run build

# Start
npm start
```

---

## 🔧 Configuración Avanzada

### Modelos Disponibles en Chutes AI

```javascript
// Modelos recomendados
"openai/gpt-oss-20b"      // Modelo por defecto (recomendado)
"openai/gpt-4-turbo"      // Más potente
"openai/gpt-3.5-turbo"    // Más rápido
"openai/claude-3-opus"    // Alternativa
```

### Parámetros de IA

```javascript
// Temperature (0.0 - 2.0)
// 0.0 = Determinístico (siempre la misma respuesta)
// 0.7 = Balanceado (por defecto)
// 2.0 = Muy creativo

// Max Tokens
// 1000 = Respuestas cortas
// 4000 = Respuestas medianas (por defecto)
// 8000 = Respuestas largas

// Reasoning Effort
// "low"    = Rápido
// "medium" = Balanceado (por defecto)
// "high"   = Más preciso
```

### Rate Limiting

```javascript
// En backend/.env
RATE_LIMIT_WINDOW_MS=900000      // 15 minutos
RATE_LIMIT_MAX_REQUESTS=100      // 100 requests por ventana
```

### Scraping Automático

```javascript
// En backend/.env
SCRAPING_ENABLED=true
SCRAPING_SCHEDULES=0 2 * * *     // Diariamente a las 2 AM
SCRAPING_TIMEZONE=America/Santiago
SCRAPING_CONCURRENCY=5           // 5 URLs simultáneamente
SCRAPING_CACHE_TTL=3600          // 1 hora de caché
```

---

## 📊 Monitoreo y Debugging

### Ver Logs del Backend

```bash
# En tiempo real
tail -f /tmp/backend.log

# Últimas 50 líneas
tail -50 /tmp/backend.log

# Buscar errores
grep -i "error" /tmp/backend.log
```

### Ver Logs del Frontend

```bash
# En tiempo real
tail -f /tmp/frontend.log

# Últimas 50 líneas
tail -50 /tmp/frontend.log
```

### Verificar Conectividad a Chutes AI

```bash
# Test de API Key
curl -X GET https://api.chutes.ai/v1/models \
  -H "Authorization: Bearer YOUR_API_KEY"

# Test de Chat Completions
curl -X POST https://api.chutes.ai/v1/chat/completions \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "openai/gpt-oss-20b",
    "messages": [{"role": "user", "content": "Hola"}],
    "max_tokens": 100
  }'
```

---

## 🔐 Seguridad

### Mejores Prácticas

1. **Nunca commits API Keys**
   ```bash
   # Agregar a .gitignore
   echo ".env" >> .gitignore
   echo ".env.local" >> .gitignore
   ```

2. **Usar variables de entorno en producción**
   ```bash
   # NO hacer esto
   CHUTES_API_KEY="cpk_..." npm start
   
   # Hacer esto
   export CHUTES_API_KEY="cpk_..."
   npm start
   ```

3. **Rotar API Keys regularmente**
   - Cambiar API Key cada 90 días
   - Revocar keys antiguas en dashboard de Chutes AI

4. **Monitorear uso de API**
   - Revisar dashboard de Chutes AI regularmente
   - Configurar alertas de costos

### Validación de Seguridad

```bash
# Verificar que no hay API Keys en el código
grep -r "cpk_" . --exclude-dir=node_modules

# Verificar que .env está en .gitignore
cat .gitignore | grep ".env"
```

---

## 🐛 Troubleshooting

### Error: "CHUTES_API_KEY no está configurado"

```bash
# Solución 1: Verificar .env
cat backend/.env | grep CHUTES_API_KEY

# Solución 2: Verificar variables de entorno
echo $CHUTES_API_KEY

# Solución 3: Reiniciar servidor
npm run dev
```

### Error: "Error de la API de Chutes AI: 401"

```bash
# Problema: API Key inválida o expirada
# Solución:
1. Verificar API Key en dashboard de Chutes AI
2. Generar nueva API Key si es necesario
3. Actualizar .env con nueva key
4. Reiniciar servidor
```

### Error: "Error de la API de Chutes AI: 429"

```bash
# Problema: Rate limit excedido
# Solución:
1. Aumentar RATE_LIMIT_WINDOW_MS
2. Disminuir RATE_LIMIT_MAX_REQUESTS
3. Esperar a que se reinicie la ventana
4. Considerar plan de Chutes AI con más límites
```

### Error: "Circuit breaker is open"

```bash
# Problema: Demasiados errores consecutivos
# Solución:
1. Verificar conectividad a internet
2. Verificar estado de Chutes AI API
3. Esperar 30 segundos para que se reinicie
4. Revisar logs para más detalles
```

### Frontend no se conecta al Backend

```bash
# Problema: CORS o puerto incorrecto
# Solución:
1. Verificar que backend está en puerto 3001
2. Verificar ALLOWED_ORIGINS en .env
3. Verificar que frontend está en puerto 3000
4. Limpiar caché del navegador
```

---

## 📈 Optimización de Costos

### Estrategias de Ahorro

1. **Usar modelo más económico**
   ```javascript
   // Cambiar en .env
   AI_MODEL=openai/gpt-3.5-turbo  // Más barato
   ```

2. **Reducir max_tokens**
   ```javascript
   // En ai.service.js
   max_tokens: 2000  // Reducido de 4000
   ```

3. **Aumentar temperatura para menos precisión**
   ```javascript
   // En ai.service.js
   temperature: 0.5  // Reducido de 0.7
   ```

4. **Implementar caché**
   ```javascript
   // Ya implementado en scrapingCache.service.js
   SCRAPING_CACHE_TTL=3600  // 1 hora
   ```

5. **Usar reasoning effort bajo**
   ```javascript
   // En .env
   AI_REASONING_EFFORT=low  // Cambiar de medium
   ```

---

## 📚 Recursos Útiles

### Documentación Oficial
- **Chutes AI Docs**: https://chutes.ai/docs/api-reference/overview
- **OpenAI API Reference**: https://platform.openai.com/docs/api-reference
- **Modelos Disponibles**: https://chutes.ai/docs/models

### Comunidad
- **GitHub Issues**: Reportar bugs
- **Discord**: Soporte comunitario
- **Email**: support@chutes.ai

### Ejemplos de Código

#### Reescritura de Artículos
```bash
curl -X POST http://localhost:3001/api/scraping/rewrite \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "titulo": "Título original",
    "contenido": "Contenido original"
  }'
```

#### Categorización
```bash
curl -X POST http://localhost:3001/api/scraping/categorize \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "titulo": "Título",
    "contenido": "Contenido",
    "url": "https://ejemplo.com"
  }'
```

#### Búsqueda Semántica
```bash
curl -X POST http://localhost:3001/api/search/intelligent \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "política internacional"
  }'
```

---

## ✅ Checklist de Verificación

- [ ] API Key de Chutes AI obtenida
- [ ] `.env` configurado correctamente
- [ ] Dependencias instaladas (`npm install`)
- [ ] Backend ejecutándose en puerto 3001
- [ ] Frontend ejecutándose en puerto 3000
- [ ] Login funciona correctamente
- [ ] Panel de administración accesible
- [ ] Reescritura de artículos funciona
- [ ] Categorización funciona
- [ ] Búsqueda semántica funciona
- [ ] Logs muestran "Proveedor IA: Chutes AI"
- [ ] Sin errores en consola

---

## 🎯 Próximos Pasos

1. **Configurar monitoreo**
   - Alertas de costos
   - Alertas de errores
   - Dashboard de uso

2. **Optimizar rendimiento**
   - Ajustar parámetros de IA
   - Implementar caché adicional
   - Optimizar prompts

3. **Escalar a producción**
   - Configurar base de datos en producción
   - Configurar Redis en producción
   - Configurar CORS para dominio real
   - Configurar SSL/TLS

---

## 📞 Soporte

Si encuentras problemas:

1. **Revisar logs**
   ```bash
   tail -f /tmp/backend.log
   tail -f /tmp/frontend.log
   ```

2. **Verificar configuración**
   ```bash
   cat backend/.env | grep CHUTES
   ```

3. **Contactar soporte**
   - Email: support@chutes.ai
   - Documentación: https://chutes.ai/docs
   - GitHub Issues: Reportar bugs

---

**Última actualización**: 4 de Noviembre de 2025  
**Versión**: 1.0  
**Estado**: ✅ Listo para Producción
