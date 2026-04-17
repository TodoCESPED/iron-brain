# Estado del proyecto Iron Brain

Última actualización: 17 de abril de 2026.

## Objetivo de banda

Banda 3 (curso 2025/2026) — Depósito objetivo: mediados de junio de 2026. Defensa entre el 24 de junio y el 2 de julio de 2026.

## Hitos cerrados

- Propuesta de TFG registrada y aprobada por la EUPT.
- Acuerdo de confidencialidad en vigor.
- Título del TFG fijado en la propuesta aprobada.
- Accesos iniciales a Odoo facilitados por Sygel (pendiente reconfiguración a solo lectura — ver bloqueadores).
- Catálogo de campos de la instancia Odoo 15 de TodoCESPED recibido y analizado (fuente: Sygel, 15/04/2026).
- Repositorio `iron-brain` creado en GitHub (privado, cuenta personal, pendiente de transferir a Pedro).
- Bootstrap técnico completado: Next.js 16 + React 19 + TypeScript + Tailwind v4, con pnpm 10.33.0 y Node 22 LTS.

## Bloqueadores abiertos

| ID | Descripción | Dueño | Estado |
|----|-------------|-------|--------|
| B1 | Usuario Odoo `api@todocesped.es` tiene rol de administrador; rompe la regla de solo lectura de la arquitectura. Solicitada reconfiguración a Sygel vía Javier. | Javier / Sygel | Esperando |

## Deuda técnica conocida

| ID | Descripción | Prioridad |
|----|-------------|-----------|
| D1 | Warning de Turbopack sobre `pnpm-workspace.yaml` como "additional lockfile". Requiere añadir `turbopack.root` al `next.config.ts`. | Baja |
| D2 | Página `src/app/page.tsx` es la demo de Next.js y hay que sustituirla por una página inicial propia. | Media |
| D3 | Ajustar `next.config.ts` con headers de seguridad (CSP, HSTS, X-Frame-Options, etc.). | Media, antes de primer deploy |
| D4 | Prettier no está instalado como dependencia del proyecto. Añadirlo cuando se endurezca el tooling. | Baja |

## Estado de los frentes

### Técnico

- Repo: creado y con bootstrap completado (privado, cuenta personal, pendiente de transferir a Pedro).
- Bootstrap Next.js: ✅
- Proyecto Supabase: existente (gestionado por TodoCESPED, pendiente recibir acceso).
- Cliente Odoo con allowlist: pendiente (esperando usuario de solo lectura).
- Esquema `odoo_*`: pendiente.
- Auth Google con restricción de dominios: pendiente.
- Protección de rama `main` en GitHub: pendiente.

### Documental

- Excel de campos Odoo: analizado.
- Índice de memoria: esbozado, pendiente de afinar.
- ADRs: ninguno escrito aún. El siguiente es el ADR-0001 (arquitectura en 3 niveles).

### Académico

- Propuesta: cerrada.
- Seguimiento con director: pendiente de agendar primer contacto formal del proyecto.
- Test de Privacidad UZ: pendiente de confirmar si aplica.

## Alcance del TFG

**Dentro**: Fase 1 (infraestructura, sync con Odoo, auth, RLS, observabilidad mínima) + Módulo 1 (Motor de Inteligencia Comercial).

**Fuera, como trabajo futuro**: Fase 2 (IA en VPS con Python/FastAPI/Ollama) y resto de módulos departamentales.

## Próximos pasos inmediatos

Sin fechas fijas. Orden recomendado:

1. Protección de rama `main` en GitHub.
2. ADR-0001: Arquitectura en 3 niveles.
3. Primer esqueleto del cliente Odoo con allowlist (no conecta aún, solo la estructura y el test de violación).
4. ADR-0002: Cliente Odoo de solo lectura (al terminar el esqueleto).