# Referencia Rápida - Chutes AI

## 🚀 Inicio Rápido (30 segundos)

```bash
# 1. Configurar API Key
export CHUTES_API_KEY="tu_api_key_aqui"

# 2. Instalar dependencias
npm install

# 3. Ejecutar aplicación
npm run dev

# 4. Acceder
# Backend:  http://localhost:3001
# Frontend: http://localhost:3000
```

---

## 📋 Comandos Esenciales

### Desarrollo
```bash
npm run dev              # Ejecutar backend + frontend
cd backend && npm run dev    # Solo backend
cd frontend && npm run dev   # Solo frontend
```

### Producción
```bash
npm run build           # Build de ambas aplicaciones
npm start              # Ejecutar en producción
```

### Debugging
```bash
tail -f /tmp/backend.log    # Ver logs backend
tail -f /tmp/frontend.log   # Ver logs frontend
grep -i error /tmp/backend.log  # Buscar errores
```

---

## 🔧 Configuración Rápida

### Variables de Entorno Críticas
```bash
CHUTES_API_KEY=cpk_...              # API Key (REQUERIDA)
AI_MODEL=openai/gpt-oss-20b         # Modelo
AI_REASONING_EFFORT=medium          # Esfuerzo
PORT=3001                           # Puerto backend
NODE_ENV=development                # Entorno
```

### Archivo `.env` Mínimo
```bash
CHUTES_API_KEY=tu_api_key_aqui
AI_MODEL=openai/gpt-oss-20b
PORT=3001
NODE_ENV=development
DATABASE_URL=postgresql://scraper:scraper123@localhost/scraping_db
REDIS_URL=redis://localhost:6379
JWT_SECRET=dev_secret_key_12345678901234567890
```

---

## 🧪 Pruebas Rápidas

### Verificar API Key
```bash
curl -X GET https://api.chutes.ai/v1/models \
  -H "Authorization: Bearer $CHUTES_API_KEY"
```

### Probar Chat Completions
```bash
curl -X POST https://api.chutes.ai/v1/chat/completions \
  -H "Authorization: Bearer $CHUTES_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "openai/gpt-oss-20b",
    "messages": [{"role": "user", "content": "Hola"}],
    "max_tokens": 100
  }'
```

### Probar Reescritura
```bash
curl -X POST http://localhost:3001/api/scraping/rewrite \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "titulo": "Título",
    "contenido": "Contenido"
  }'
```

---

## 🐛 Troubleshooting Rápido

| Problema | Solución |
|----------|----------|
| `CHUTES_API_KEY no configurado` | `export CHUTES_API_KEY="tu_key"` |
| `Error 401` | Verificar API Key en dashboard Chutes AI |
| `Error 429` | Rate limit - esperar o aumentar límites |
| `Circuit breaker open` | Esperar 30 segundos, revisar conectividad |
| `Frontend no conecta` | Verificar CORS en `.env` |
| `Puerto 3001 en uso` | `lsof -ti:3001 \| xargs kill -9` |
| `Puerto 3000 en uso` | `lsof -ti:3000 \| xargs kill -9` |

---

## 📊 Monitoreo Rápido

### Ver Estado del Backend
```bash
curl http://localhost:3001/health
```

### Ver Logs en Tiempo Real
```bash
# Backend
tail -f /tmp/backend.log | grep -i "chutes\|error"

# Frontend
tail -f /tmp/frontend.log | grep -i "error"
```

### Verificar Procesos
```bash
ps aux | grep node
lsof -i :3000
lsof -i :3001
```

---

## 🔐 Seguridad Rápida

### Nunca hacer
```bash
# ❌ NO hacer esto
CHUTES_API_KEY="cpk_..." npm start
git add .env
echo "CHUTES_API_KEY=cpk_..." > config.js
```

### Hacer siempre
```bash
# ✅ Hacer esto
export CHUTES_API_KEY="cpk_..."
echo ".env" >> .gitignore
# Usar variables de entorno del sistema
```

---

## 📈 Optimización Rápida

### Reducir Costos
```bash
# En .env
AI_MODEL=openai/gpt-3.5-turbo    # Más barato
AI_REASONING_EFFORT=low          # Más rápido
SCRAPING_CACHE_TTL=7200          # Más caché (2 horas)
```

### Aumentar Rendimiento
```bash
# En .env
SCRAPING_CONCURRENCY=10          # Más paralelo
RATE_LIMIT_MAX_REQUESTS=200      # Más requests
```

---

## 🎯 Flujo de Trabajo Típico

### 1. Desarrollo Local
```bash
# Terminal 1
cd backend && npm run dev

# Terminal 2
cd frontend && npm run dev

# Terminal 3
tail -f /tmp/backend.log
```

### 2. Hacer Cambios
```bash
# Editar archivos
# Los servidores se recargan automáticamente
```

### 3. Probar
```bash
# Abrir http://localhost:3000
# Probar funcionalidades
# Revisar logs
```

### 4. Commit
```bash
git add .
git commit -m "Cambios"
git push
```

---

## 📚 Documentación Rápida

| Documento | Propósito |
|-----------|-----------|
| `MIGRATION_GROQ_TO_CHUTES_AI.md` | Detalles técnicos |
| `CHUTES_AI_VERIFICATION.md` | Checklist completo |
| `CHUTES_AI_SETUP_GUIDE.md` | Guía detallada |
| `MIGRATION_SUMMARY.md` | Resumen ejecutivo |
| `QUICK_REFERENCE.md` | Este documento |

---

## 🔗 Enlaces Útiles

- **Chutes AI Docs**: https://chutes.ai/docs/api-reference/overview
- **OpenAI API**: https://platform.openai.com/docs/api-reference
- **Dashboard Chutes AI**: https://dashboard.chutes.ai
- **GitHub**: Tu repositorio

---

## ⚡ Atajos Útiles

### Alias Bash (agregar a `.bashrc` o `.zshrc`)
```bash
alias start-app="npm run dev"
alias stop-app="pkill -9 node"
alias logs-backend="tail -f /tmp/backend.log"
alias logs-frontend="tail -f /tmp/frontend.log"
alias check-ports="lsof -i :3000,3001"
alias clean-ports="lsof -ti:3000,3001 | xargs kill -9 2>/dev/null"
```

### Uso
```bash
start-app           # Inicia aplicación
stop-app            # Detiene aplicación
logs-backend        # Ver logs backend
check-ports         # Ver puertos en uso
clean-ports         # Liberar puertos
```

---

## 🎓 Conceptos Clave

### Chutes AI
- **API Base**: `https://api.chutes.ai/v1`
- **Compatibilidad**: 100% OpenAI
- **Autenticación**: Bearer Token
- **Modelos**: `openai/gpt-oss-20b`, `openai/gpt-4-turbo`, etc.

### Aplicación
- **Backend**: Node.js + Express (Puerto 3001)
- **Frontend**: Next.js (Puerto 3000)
- **Base de Datos**: PostgreSQL
- **Cache**: Redis

### Protecciones
- **Rate Limiting**: Controla llamadas a API
- **Circuit Breaker**: Protege contra fallos
- **Reintentos**: Exponential backoff
- **Validación**: Todas las respuestas

---

## 📞 Soporte Rápido

### Si algo no funciona
1. Revisar logs: `tail -f /tmp/backend.log`
2. Verificar API Key: `echo $CHUTES_API_KEY`
3. Probar conectividad: `curl https://api.chutes.ai/v1/models`
4. Revisar documentación: Ver archivos `.md` en raíz
5. Contactar soporte: support@chutes.ai

### Información Útil
- **Versión Node**: `node --version`
- **Versión npm**: `npm --version`
- **Versión Next.js**: `npm list next`
- **Versión Express**: `npm list express`

---

## ✅ Checklist Diario

- [ ] Verificar logs sin errores
- [ ] Probar login
- [ ] Probar reescritura de artículos
- [ ] Revisar dashboard admin
- [ ] Verificar uso de API en Chutes AI
- [ ] Revisar alertas de costos

---

## 🎉 Listo para Usar

Esta referencia rápida te permite:
- ✅ Iniciar la aplicación en 30 segundos
- ✅ Resolver problemas comunes
- ✅ Monitorear la aplicación
- ✅ Optimizar rendimiento
- ✅ Acceder a documentación

**¡La aplicación está lista para producción!**

---

**Última actualización**: 4 de Noviembre de 2025  
**Versión**: 1.0  
**Estado**: ✅ Listo
