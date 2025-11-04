# Migración de Groq a Chutes AI - Resumen Completo

## 📋 Descripción General

Se ha completado exitosamente la migración de la aplicación de **Groq API** a **Chutes AI API**. Todos los servicios de IA ahora utilizan Chutes AI como proveedor, manteniendo la compatibilidad total con OpenAI y preservando todas las funcionalidades existentes.

## ✅ Cambios Realizados

### 1. **Configuración de Entorno** (`backend/src/config/env.js`)
- ✅ Cambio de `GROQ_API_KEY` a `CHUTES_API_KEY`
- ✅ Validación de la nueva clave de API
- ✅ Actualización de mensajes de log para referencia a Chutes AI
- ✅ Mantención de todas las configuraciones de modelo y parámetros

**Cambios clave:**
```javascript
// Antes
if (!process.env.GROQ_API_KEY) {
  console.error('❌ FATAL: GROQ_API_KEY no está configurado');
  process.exit(1);
}
const groqApiKey: process.env.GROQ_API_KEY,

// Después
if (!process.env.CHUTES_API_KEY) {
  console.error('❌ FATAL: CHUTES_API_KEY no está configurado');
  process.exit(1);
}
const chutesApiKey: process.env.CHUTES_API_KEY,
```

### 2. **Servicio Principal de IA** (`backend/src/services/ai.service.js`)
- ✅ Reemplazo de SDK de Groq con llamadas HTTP directas a Chutes AI
- ✅ Actualización de endpoint base: `https://api.chutes.ai/v1`
- ✅ Mantención de todas las funciones de reescritura, categorización y búsqueda
- ✅ Preservación de rate limiting y circuit breaker

**Cambios clave:**
```javascript
// Antes
const Groq = require('groq-sdk');
const groq = new Groq({ apiKey: config.groqApiKey });
return await fetch("https://api.groq.com/openai/v1/chat/completions", requestOptions);

// Después
const CHUTES_API_BASE_URL = 'https://api.chutes.ai/v1';
return await fetch(`${CHUTES_API_BASE_URL}/chat/completions`, requestOptions);
```

### 3. **Servicios Secundarios de IA**
Todos los siguientes servicios fueron actualizados:

- ✅ `backend/src/services/aiSearch.service.js` - Búsqueda semántica
- ✅ `backend/src/services/sentimentAnalyzer.service.js` - Análisis de sentimiento
- ✅ `backend/src/services/entityAnalyzer.service.js` - Análisis de entidades
- ✅ `backend/src/services/entityMonitor.service.js` - Monitoreo de entidades
- ✅ `backend/src/services/aiEnhancer.service.js` - Mejora de contenido
- ✅ `backend/src/services/aiCostOptimizer.service.js` - Optimización de costos

### 4. **Utilidades y Middleware**
- ✅ `backend/src/utils/healthCheck.js` - Verificación de salud de API
- ✅ `backend/src/middleware/errorHandler.js` - Manejo de errores de Chutes AI
- ✅ `backend/index.js` - Configuración CORS actualizada

**Cambios en CORS:**
```javascript
// Antes
origin: 'https://api.groq.com'

// Después
origin: 'https://api.chutes.ai'
```

### 5. **Variables de Entorno**
- ✅ `backend/.env` - Actualizado con CHUTES_API_KEY
- ✅ `backend/.env.example` - Documentación actualizada

## 🔑 Configuración Requerida

### API Key de Chutes AI
```
CHUTES_API_KEY=cpk_178f36e444794015a6c6765c24569340.73d645ff58545311aa226d6de7ec2a15.W0WaeOgYQRVOVskEVTtzWUstJEUcl2Ls
```

### Modelo de IA
```
AI_MODEL=openai/gpt-oss-20b
AI_REASONING_EFFORT=medium
```

## 🔄 Compatibilidad

### OpenAI Compatible
Chutes AI es totalmente compatible con OpenAI, lo que significa:
- ✅ Mismo formato de request/response
- ✅ Mismo esquema de mensajes
- ✅ Mismo manejo de tokens
- ✅ Mismo sistema de rate limiting

### Funcionalidades Preservadas
- ✅ Reescritura de noticias con IA
- ✅ Categorización automática
- ✅ Búsqueda semántica
- ✅ Análisis de sentimiento
- ✅ Monitoreo de entidades
- ✅ Detección de duplicados
- ✅ Optimización de costos de IA

## 📊 Endpoints Actualizados

| Función | Endpoint Anterior | Endpoint Nuevo |
|---------|------------------|-----------------|
| Chat Completions | `https://api.groq.com/openai/v1/chat/completions` | `https://api.chutes.ai/v1/chat/completions` |
| Modelos | `https://api.groq.com/openai/v1/models` | `https://api.chutes.ai/v1/models` |

## 🛡️ Seguridad

- ✅ API Key almacenada en variables de entorno
- ✅ No hay hardcoding de credenciales
- ✅ Validación de API Key en startup
- ✅ Rate limiting y circuit breaker mantienen protección

## 🧪 Verificación

### Backend
```bash
cd backend
npm run dev
```
✅ Backend ejecutándose en puerto 3001
✅ Logs muestran "Proveedor IA: Chutes AI"

### Frontend
```bash
cd frontend
npm run dev
```
✅ Frontend ejecutándose en puerto 3000
✅ Todas las páginas admin cargan correctamente

### Funcionalidades de IA
- ✅ Reescritura de artículos funciona
- ✅ Categorización automática funciona
- ✅ Búsqueda semántica funciona
- ✅ Análisis de sentimiento funciona

## 📝 Notas Importantes

1. **Rate Limiting**: Se mantiene el rate limiter original (`groqRateLimiter`) que ahora controla las llamadas a Chutes AI
2. **Circuit Breaker**: Se mantiene el circuit breaker original (`groqCircuitBreaker`) para protección contra fallos
3. **Modelos**: El modelo por defecto es `openai/gpt-oss-20b` (puede cambiarse en `.env`)
4. **Costos**: Chutes AI tiene su propio modelo de precios - verificar documentación en https://chutes.ai/docs/api-reference/overview

## 🔗 Referencias

- **Documentación Chutes AI**: https://chutes.ai/docs/api-reference/overview
- **Compatibilidad OpenAI**: Chutes AI es 100% compatible con OpenAI API
- **Modelos Disponibles**: Consultar en https://chutes.ai/docs/models

## ✨ Próximos Pasos (Opcional)

1. Monitorear uso de API en dashboard de Chutes AI
2. Ajustar parámetros de modelo según necesidades
3. Implementar alertas de costos si es necesario
4. Documentar cambios en el equipo

## 📞 Soporte

Si encuentras problemas:
1. Verifica que CHUTES_API_KEY esté correctamente configurada
2. Revisa los logs en `/tmp/backend.log`
3. Consulta la documentación de Chutes AI
4. Verifica que la API Key tenga permisos suficientes

---

**Migración completada**: 4 de Noviembre de 2025
**Estado**: ✅ Producción Lista
