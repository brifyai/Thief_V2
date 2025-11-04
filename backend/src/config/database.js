const { PrismaClient } = require('@prisma/client');

// Singleton para evitar múltiples instancias de PrismaClient
let prisma;

const prismaConfig = {
  // Connection pooling optimizado
  datasources: {
    db: {
      url: process.env.DATABASE_URL,
    },
  },
  // Logging condicional
  log: process.env.NODE_ENV === 'production' ? ['error', 'warn'] : ['query', 'error', 'warn'],
  errorFormat: process.env.NODE_ENV === 'production' ? 'minimal' : 'pretty',
  // Timeout y retry configuración
  transactionOptions: {
    timeout: 10000,
    maxWait: 5000,
  },
};

if (process.env.NODE_ENV === 'production') {
  prisma = new PrismaClient(prismaConfig);
} else {
  // En desarrollo, usar variable global para hot-reload
  if (!global.prisma) {
    global.prisma = new PrismaClient(prismaConfig);
  }
  prisma = global.prisma;
}

// Manejo de desconexión graceful
process.on('beforeExit', async () => {
  console.log('🔌 Cerrando conexiones de base de datos...');
  await prisma.$disconnect();
});

// Manejo de errores de conexión
prisma.$connect()
  .then(() => {
    console.log('✅ Conexión a base de datos establecida');
  })
  .catch((error) => {
    console.error('❌ Error conectando a base de datos:', error);
    process.exit(1);
  });

module.exports = prisma;
