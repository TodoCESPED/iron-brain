# Setup local de Iron Brain

## Requisitos

- Node.js 22 LTS (ver `.nvmrc`).
- pnpm 9+ (`corepack enable && corepack prepare pnpm@latest --activate`).
- Cuenta de GitHub con acceso al repo.
- Variables de entorno locales (ver `.env.example`).

## Primer arranque

```bash
# Clonar
git clone git@github.com:daniwow71/iron-brain.git
cd iron-brain

# Usar la versión de Node declarada
nvm use

# Instalar dependencias
pnpm install

# Copiar variables de entorno
cp .env.example .env.local
# Edita .env.local con los valores reales (nunca lo commitees)

# Arrancar en desarrollo
pnpm dev
```

La app arrancará en `http://localhost:3000`.

## Scripts disponibles

Se documentarán aquí a medida que se añadan al `package.json`.