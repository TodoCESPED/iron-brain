# Estado del proyecto Iron Brain

Última actualización: 28 de abril de 2026.

## Objetivo de banda

Banda 3 (curso 2025/2026). Depósito objetivo: del 8 al 18 de junio de 2026. Defensa: del 24 de junio al 2 de julio de 2026.

## Hitos cerrados

### Académico

- Propuesta de TFG registrada y aprobada por la EUPT.
- Acuerdo de confidencialidad en vigor.
- Título del TFG fijado en la propuesta aprobada.
- Capítulo 3 de la memoria (Metodología y planificación) redactado y enviado a la dirección académica para revisión.

### Técnico

- Repositorio `iron-brain` creado en GitHub y transferido a la organización `TodoCESPED`.
- Protección de rama `main`: pull request obligatoria, merge mediante squash, sin push directo, historial lineal.
- Bootstrap del proyecto completado: Next.js 16 + React 19 + TypeScript + Tailwind v4, sobre pnpm 10.33 y Node 22 LTS.
- Vitest configurado con alias `@/*` y modo estricto sobre globals.
- Cabeceras HTTP de seguridad aplicadas a todas las rutas (X-Frame-Options, X-Content-Type-Options, Referrer-Policy, Permissions-Policy, Strict-Transport-Security).
- Cliente Odoo implementado en `src/lib/odoo/` con tres módulos diferenciados: tipos compartidos, allowlist tipada con type guard y assertion, transporte JSON-RPC genérico, y cliente de alto nivel `OdooClient` con autenticación, validación contra allowlist y health check.
- 38 pruebas unitarias verdes que cubren la allowlist, el transporte y el cliente.
- ADR-0001 (arquitectura en tres niveles) y ADR-0002 (cliente Odoo de solo lectura sobre JSON-RPC) redactados.
- Página inicial de Iron Brain (`src/app/page.tsx`) con identidad visual de TodoCESPED: tipografía Ubuntu, paleta corporativa, hero, tres pilares, footer.
- Proyecto desplegado en Vercel sobre el equipo `NODRIZAtech's projects` (plan Pro). URL pública: https://iron-brain-ten.vercel.app/.
- Auto-deploy configurado: cada push a `main` despliega producción; cada pull request genera preview deployment.

### Documental

- Catálogo de campos de la instancia Odoo 15 de TodoCESPED recibido y analizado (fuente: Sygel, 15/04/2026).
- Recursos de marca recibidos: logos en variantes verde, blanco y negro, favicon, manual de marca con paleta y tipografía.

## Bloqueadores abiertos

| ID | Descripción | Dueño | Estado |
|----|-------------|-------|--------|
| B1 | Usuario `api@todocesped.es` con rol de administrador. Solicitada reconfiguración a solo lectura para cumplir la regla innegociable de la arquitectura. | Javier / Sygel | Esperando |
| B2 | Feedback de la dirección académica sobre el capítulo 3 de la memoria. | Tutora | Esperando |
| B3 | Especificación funcional completa del Módulo 1 (Motor de Inteligencia Comercial). | Pedro | Pendiente |

## Bloqueadores resueltos

- Acceso a la organización `TodoCESPED` en GitHub: completado.
- Acceso al equipo `NODRIZAtech's projects` en Vercel: completado.
- Acceso a Supabase: completado, pendiente de configurar el proyecto Iron Brain.

## Decisiones pendientes con Pedro

| ID | Tema | Estado |
|----|------|--------|
| P1 | Spend Management de Vercel: configurar alertas de coste y límite presupuestario. | Pendiente |
| P2 | Speed Insights y Analytics de Vercel: decidir si se activan desde el inicio. | Pendiente |
| P3 | Dominio personalizado para Iron Brain (ej. `iron-brain.todocesped.es`). | Pendiente |
| P4 | Identidad visual propia de Iron Brain: Pedro confirmará si se mantiene la herencia visual de TodoCESPED o se desarrolla un logotipo específico. | Pendiente |

## Deuda técnica conocida

| ID | Descripción | Prioridad |
|----|-------------|-----------|
| D1 | Definir Content-Security-Policy estricta en `next.config.ts` cuando se incorporen Supabase Auth y otras fuentes externas. | Media |
| D2 | Configurar Prettier como dependencia del proyecto y unificar formato. | Baja |
| D3 | Endpoint `GET /api/odoo/health` pendiente de implementar (dependencia: usuario Odoo de solo lectura, B1). | Media |
| D4 | Tabla `app_log` en Supabase pendiente de crear como primera migración. | Alta cuando se inicie el bloque Supabase |

## Decisiones de diseño con justificación documentada

- **SEO bloqueado mediante meta `noindex, nofollow`**: Iron Brain es una herramienta corporativa interna, no se requiere indexación en motores de búsqueda. Lighthouse penaliza la puntuación de SEO (63/100) por esta directiva, pero la decisión es deliberada y defendible.
- **Hidratación con `suppressHydrationWarning` en `<html>`**: para mitigar los warnings producidos por extensiones del navegador que inyectan atributos en la etiqueta raíz tras el render del servidor.

## Métricas de calidad en producción

Lighthouse sobre la URL pública (Chromium en modo incógnito, perfil emulado Moto G Power):

| Categoría | Puntuación |
|-----------|------------|
| Performance | 99 |
| Accessibility | 95 |
| Best Practices | 100 |
| SEO | 63 (justificado, ver decisiones de diseño) |

## Estado de los frentes

### Técnico

- Repo transferido a `TodoCESPED`.
- Bootstrap Next.js completado.
- Cliente Odoo implementado y verificado por pruebas unitarias.
- Despliegue en Vercel operativo.
- Proyecto Supabase: pendiente de configurar el proyecto Iron Brain y crear las primeras migraciones.
- Auth Google con restricción de dominios: pendiente, dependiente de Supabase.
- Esquema `odoo_*` en Supabase: pendiente.
- Endpoint `GET /api/odoo/health`: pendiente, dependiente de B1.

### Documental

- Capítulo 3 de la memoria: enviado a la tutora.
- ADRs 0001 y 0002 redactados.
- Documentación de modelos de Odoo: pendiente, se irá creando en `docs/odoo-models/` a medida que se incorporen tablas espejo al esquema.

### Académico

- Propuesta: cerrada.
- Capítulo 3 (Metodología y planificación): enviado, esperando feedback.
- Próximo capítulo: Capítulo 4 (Análisis y requisitos), o continuación según indicaciones de la tutora.
- Test de Privacidad UZ: pendiente de confirmar si aplica.

#### Preguntas pendientes para la dirección académica y la Secretaría EUPT

| ID | Pregunta | Dirigida a |
|----|----------|------------|
| E1 | ¿Existe plantilla específica de la EUPT para la memoria, o se usa el modelo genérico UZ disponible en biblioteca? | Director |
| E2 | Estilo de citas preferido. Propuesta del autor: IEEE numérico. | Director |
| E3 | Declaración responsable sobre uso de IA: ¿modelo propio EUPT o genérico UZ? | Secretaría EUPT |
| E4 | Test de Privacidad de la UZ: ¿se requiere dado el tratamiento de datos personales de clientes en `res.partner`? | Secretaría EUPT / Director |
| E5 | ¿Existe rúbrica de evaluación publicada o la evaluación se rige únicamente por la normativa EUPT? | Director |
| E6 | Preferencia sobre tipografía y formato del documento. Propuesta por defecto: A4, Times New Roman 12pt, interlineado 1,5, márgenes 2,5cm (3cm izquierdo). | Director |
| E7 | Herramienta para la memoria: Word, LaTeX o Markdown convertido a PDF vía Pandoc. | Director |

## Alcance del TFG

**Dentro**: Fase 1 (infraestructura, sincronización con Odoo, autenticación, RLS, observabilidad mínima) y Módulo 1 (Motor de Inteligencia Comercial).

**Fuera, como trabajo futuro**: Fase 2 (servicios de IA en VPS dedicado con Python, FastAPI y Ollama) y resto de módulos departamentales.

## Próximos pasos inmediatos

Sin fechas fijas. Orden recomendado:

1. Conectar Supabase: configurar variables de entorno en Vercel (preview y producción), crear proyecto Iron Brain en Supabase, instalar el SDK, redactar primera migración con la tabla `app_log`.
2. Implementar tabla `profiles` y configurar Row Level Security básica.
3. Configurar autenticación con Google OAuth y restricción por dominio.
4. Esperar usuario Odoo de solo lectura (B1) para implementar `/api/odoo/health` y verificar conexión real.
5. Esperar feedback de la tutora (B2) para continuar con la memoria.
6. Esperar especificación del Módulo 1 (B3) para iniciar su implementación.