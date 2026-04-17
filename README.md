# Iron Brain

Ecosistema central de decisiones de TodoCESPED. Sincroniza datos desde Odoo 15 (en modo solo lectura) a un almacén propio en Supabase y expone módulos departamentales con inteligencia sobre esos datos.

## Estado

En desarrollo inicial. Ver [ESTADO-DEL-PROYECTO.md](./ESTADO-DEL-PROYECTO.md).

## Arquitectura

Tres niveles:

1. **Conexión Odoo** (`lib/odoo/`): cliente XML-RPC/JSON-RPC de solo lectura con allowlist estricta de métodos.
2. **Núcleo Iron Brain** (Next.js + Supabase): sync programado, almacén propio y módulos departamentales.
3. **Aplicaciones IA** (futuro, fuera del alcance actual): servicios Python en VPS.

## Stack

- Next.js 15 (App Router) + TypeScript
- Supabase (Postgres + Google OAuth)
- Vercel (hosting + Cron)
- pnpm como gestor de paquetes
- Node.js 22 LTS

## Setup local

Ver [`docs/SETUP.md`](./docs/SETUP.md).

## Documentación del proyecto

- [`ESTADO-DEL-PROYECTO.md`](./ESTADO-DEL-PROYECTO.md) — Estado vivo, bloqueadores, próximos pasos.
- [`decisiones/`](./decisiones/) — Registros de decisiones arquitectónicas (ADRs).
- [`memoria/`](./memoria/) — Capítulos de la memoria del TFG.
- [`docs/`](./docs/) — Documentación operativa.

## Contexto académico

Este proyecto es el Trabajo Fin de Grado de Daniel Sanagustín López en el Grado en Ingeniería Informática de la Escuela Universitaria Politécnica de Teruel (Universidad de Zaragoza), realizado en colaboración con TodoCESPED bajo acuerdo de confidencialidad.

## Licencia

Código propietario de TodoCESPED. Todos los derechos reservados.