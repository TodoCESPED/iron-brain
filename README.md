# Iron Brain

Ecosistema central de decisiones de TodoCESPED. Sincroniza datos desde el sistema ERP Odoo 15 (en modo solo lectura) hacia un almacén propio en Supabase y expone módulos departamentales con capacidad analítica sobre los datos consolidados.

## Estado

En desarrollo. Producción accesible en https://iron-brain-ten.vercel.app/. Ver [ESTADO-DEL-PROYECTO.md](./ESTADO-DEL-PROYECTO.md) para el detalle de hitos cerrados, bloqueadores abiertos y próximos pasos.

## Arquitectura

El sistema se organiza en tres niveles diferenciados:

1. **Conexión Odoo** (`src/lib/odoo/`): cliente JSON-RPC de solo lectura con allowlist estricta de métodos. Cualquier invocación a métodos de escritura se rechaza a nivel de aplicación antes de enviarse al ERP.
2. **Núcleo Iron Brain** (Next.js sobre Vercel + Supabase): sincronización programada por polling, almacén propio con tablas espejo y módulos departamentales con autenticación y autorización por roles.
3. **Aplicaciones de IA** (futuro, fuera del alcance del Trabajo Fin de Grado): servicios en Python sobre VPS dedicado.

La justificación detallada de la arquitectura se encuentra en [`decisiones/ADR-0001-arquitectura-3-niveles.md`](./decisiones/ADR-0001-arquitectura-3-niveles.md).

## Stack

- **Framework**: Next.js 16 (App Router) + React 19 + TypeScript.
- **Estilos**: Tailwind CSS v4.
- **Base de datos y autenticación**: Supabase (PostgreSQL + Google OAuth).
- **Hosting y CI/CD**: Vercel (incluye Vercel Cron para tareas programadas).
- **Pruebas**: Vitest.
- **Gestor de paquetes**: pnpm 10.33 sobre Node.js 22 LTS.

## Despliegue

- **Producción**: https://iron-brain-ten.vercel.app/. Cada push a la rama `main` despliega automáticamente.
- **Previsualización**: cada pull request genera un preview deployment con su propia URL temporal.
- **Equipo Vercel**: `NODRIZAtech's projects` (plan Pro).
- **Variables de entorno**: gestionadas desde el panel de Vercel para los entornos desplegados. En desarrollo local se utiliza un archivo `.env.local` excluido del control de versiones. La plantilla de variables requeridas se encuentra en [`.env.example`](./.env.example).
- **Dominio**: subdominio temporal de Vercel. La adopción de un dominio personalizado de TodoCESPED queda pendiente de decisión.

## Setup local

Requisitos:

- Node.js 22 LTS.
- pnpm 10.33 o superior.

Pasos:

1. Clonar el repositorio.
2. `pnpm install` para instalar dependencias.
3. Copiar `.env.example` a `.env.local` y rellenar los valores.
4. `pnpm dev` para arrancar el servidor de desarrollo en `http://localhost:3000`.

Documentación detallada en [`docs/SETUP.md`](./docs/SETUP.md).

## Scripts disponibles

| Script | Función |
|--------|---------|
| `pnpm dev` | Servidor de desarrollo con recarga en caliente. |
| `pnpm build` | Build de producción. |
| `pnpm start` | Sirve el build de producción en local. |
| `pnpm lint` | Análisis estático con ESLint. |
| `pnpm typecheck` | Comprobación de tipos con el compilador de TypeScript. |
| `pnpm test` | Ejecuta las pruebas unitarias con Vitest una vez. |
| `pnpm test:watch` | Ejecuta las pruebas unitarias en modo watch. |

## Documentación del proyecto

- [`ESTADO-DEL-PROYECTO.md`](./ESTADO-DEL-PROYECTO.md): estado vivo del proyecto, hitos cerrados, bloqueadores y próximos pasos.
- [`decisiones/`](./decisiones/): registros de decisiones arquitectónicas (ADRs).
- [`memoria/`](./memoria/): capítulos y anexos de la memoria del Trabajo Fin de Grado.
- [`docs/`](./docs/): documentación operativa, manuales de instalación y referencia de modelos de Odoo.

## Contexto académico

Este proyecto es el Trabajo Fin de Grado de Daniel Sanagustín López, estudiante del Grado en Ingeniería Informática de la Escuela Universitaria Politécnica de Teruel (Universidad de Zaragoza), realizado en colaboración con TodoCESPED bajo acuerdo de confidencialidad.

Modalidad: artículo 4.1.c del Texto Refundido del Reglamento de los trabajos de fin de grado y fin de máster de la Universidad de Zaragoza, desarrollada por la Normativa Interna de Gestión de Trabajos Fin de Estudios de la Escuela Universitaria Politécnica de Teruel de 17 de mayo de 2023: trabajos específicos realizados como resultado de prácticas en empresas o instituciones.

## Licencia

Código propietario de TodoCESPED. Todos los derechos reservados.