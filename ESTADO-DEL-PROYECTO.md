# Estado del proyecto Iron Brain

Última actualización: 28 de abril de 2026.

## Objetivo de banda

Banda 3 (curso 2025/2026). Depósito objetivo: del 8 al 18 de junio de 2026. Defensa: del 24 de junio al 2 de julio de 2026.

## Cambio de alcance reciente (29 de abril de 2026)

El documento de requisitos IRONB-AD-RQ v0.2 sustituye al briefing inicial en cuanto al alcance funcional de la fase 1. El proyecto pivota de un motor de inteligencia comercial dirigido al comercial individual (acciones diarias recomendadas) a una intranet corporativa con megadashboards estratégicos para responsables de departamento y dirección.

El motor de inteligencia comercial original (`docs/04-modulos/MOD1-motor-inteligencia-comercial-v1.0.md`) queda en pausa, no descartado, como fase posterior.

Se incorpora al alcance de la fase 1 un nuevo módulo de inteligencia artificial (`docs/04-modulos/MOD2-ia-forecasting-y-resumen.md`) con dos componentes acotados: forecasting de facturación y resumen ejecutivo en lenguaje natural. La justificación está en el ADR-0003.

## Plan de proyecto hasta el depósito

| Semana | Periodo | Foco principal | Foco secundario |
|--------|---------|----------------|-----------------|
| 1 | 29 abr – 4 may | Configuración de Supabase y sincronización inicial con Odoo | Capítulo 4 (Análisis y requisitos) |
| 2 | 5 – 11 may | Intranet, autenticación con Google OAuth y permisos | Capítulo 5 (Diseño) |
| 3 | 12 – 18 may | Megadashboard B2B v1 (cabecera y productividad por comercial) | Capítulo 6 (Implementación) |
| 4 | 19 – 25 may | Componente 1 de IA: forecasting de facturación | Continuar capítulo 6 |
| 5 | 26 may – 1 jun | Componente 2 de IA: resumen ejecutivo en lenguaje natural | Capítulo 7 (Pruebas) |
| 6 | 2 – 8 jun | Megadashboard B2C v1 y cierre técnico | Capítulo 8 (Despliegue) y capítulo 9 (Conclusiones) |
| 7 | 9 – 15 jun | Pruebas de extremo a extremo, revisión final y depósito | Memoria final y preparación de la defensa |

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
- ADR-0001 (arquitectura en tres niveles), ADR-0002 (cliente Odoo de solo lectura sobre JSON-RPC) y ADR-0003 (incorporación de IA en fase 1) redactados.
- Página inicial de Iron Brain (`src/app/page.tsx`) con identidad visual de TodoCESPED: tipografía Ubuntu, paleta corporativa, hero, tres pilares, footer.
- Proyecto desplegado en Vercel sobre el equipo `NODRIZAtech's projects` (plan Pro). URL pública: https://iron-brain-ten.vercel.app/.
- Auto-deploy configurado: cada push a `main` despliega producción; cada pull request genera preview deployment.

### Documental

- Catálogo de campos de la instancia Odoo 15 de TodoCESPED recibido y analizado (fuente: Sygel, 15/04/2026).
- Recursos de marca recibidos: logos en variantes verde, blanco y negro, favicon, manual de marca con paleta y tipografía.
- Documento de requisitos IRONB-AD-RQ v0.2 incorporado como referencia funcional vigente.
- Especificación funcional `docs/04-modulos/MOD1-intranet-megadashboards-v1.0.pdf` incorporada.
- Especificación técnica del módulo de IA: `docs/04-modulos/MOD2-ia-forecasting-y-resumen.md`.

## Bloqueadores resueltos

- Acceso a la organización `TodoCESPED` en GitHub: completado.
- Acceso al equipo `NODRIZAtech's projects` en Vercel: completado.
- Acceso a Supabase: completado, pendiente de configurar el proyecto Iron Brain.
- **B1 (Sygel/Odoo)**: usuario API `api@todocesped.es` con permisos de solo lectura facilitado por Sygel. Entorno de pruebas disponible en `https://testtodocesped.sygel.es/`. La clave API se gestiona como variable de entorno secreta. Pendiente: verificar manualmente desde el cliente Iron Brain que las credenciales funcionan y que efectivamente la cuenta es de solo lectura.

## Bloqueadores abiertos

| ID | Descripción | Dueño | Estado |
|----|-------------|-------|--------|
| B2 | Feedback de la dirección académica sobre el capítulo 3 de la memoria. | Tutora | Esperando |
| B3 | Lista priorizada definitiva de KPIs validada por los jefes de ventas (Pablo en B2B, Iván en B2C). | Pedro | Pendiente |
| B4 | Catálogo definitivo de herramientas de la pool a registrar en la intranet en fase 1. | Pedro | Pendiente |
| B5 | Definición exacta de "actividad comercial" en Odoo: campos en `mail.activity`, `calendar.event` u otros. Sin esto, el bloque de productividad del megadashboard no se calcula con precisión. | Pedro / Sygel | Pendiente |
| B6 | Confirmación de la plataforma e-commerce B2C utilizada y de si los pedidos web se vuelcan a Odoo. | Pedro | Pendiente |

## Decisiones pendientes con Pedro

| ID | Tema | Estado |
|----|------|--------|
| P1 | Spend Management de Vercel: configurar alertas de coste y límite presupuestario. | Pendiente |
| P2 | Speed Insights y Analytics de Vercel: decidir si se activan desde el inicio. | Pendiente |
| P3 | Dominio personalizado para Iron Brain (ej. `iron-brain.todocesped.es`). | Pendiente |
| P4 | Identidad visual propia de Iron Brain o herencia de TodoCESPED. | Pendiente |
| P5 | Infraestructura del servicio Python para los componentes de IA (Vercel, VPS pequeño, otro). | Pendiente |
| P6 | Modelo de lenguaje a utilizar para el resumen ejecutivo (Claude API, GPT-4o-mini, Mistral u otro). | Pendiente |

## Deuda técnica conocida

| ID | Descripción | Prioridad |
|----|-------------|-----------|
| D1 | Definir Content-Security-Policy estricta en `next.config.ts` cuando se incorporen Supabase Auth y otras fuentes externas. | Media |
| D2 | Configurar Prettier como dependencia del proyecto y unificar formato. | Baja |
| D3 | Endpoint `GET /api/odoo/health` pendiente de implementar. | Alta (próxima semana) |
| D4 | Tabla `app_log` en Supabase pendiente de crear como primera migración. | Alta (próxima semana) |
| D5 | Verificar manualmente desde el cliente Iron Brain que el usuario `api@todocesped.es` es efectivamente de solo lectura, antes de integrar el cliente con el sync. | Alta (próxima semana) |

## Decisiones de diseño con justificación documentada

- **SEO bloqueado mediante meta `noindex, nofollow`**: Iron Brain es una herramienta corporativa interna, no se requiere indexación en motores de búsqueda. Lighthouse penaliza la puntuación de SEO (63/100) por esta directiva, pero la decisión es deliberada y defendible.
- **Hidratación con `suppressHydrationWarning` en `<html>`**: para mitigar los warnings producidos por extensiones del navegador que inyectan atributos en la etiqueta raíz tras el render del servidor.
- **Incorporación de IA en fase 1**: ver ADR-0003. Dos componentes acotados (forecasting y resumen ejecutivo); resto de capacidades (Health Score, Stock Push, NLP de why nots, anomalías) como trabajo futuro.

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
- Proyecto Supabase: pendiente de configurar el proyecto Iron Brain y crear las primeras migraciones (semana 1).
- Auth Google con restricción de dominios: pendiente, dependiente de Supabase (semana 2).
- Esquema `odoo_*` en Supabase: pendiente (semanas 1 y 2).
- Endpoint `GET /api/odoo/health`: pendiente (semana 1).
- Servicio Python para IA: pendiente (semanas 4 y 5).

### Documental

- Capítulo 3 de la memoria: enviado a la tutora.
- ADRs 0001, 0002 y 0003 redactados.
- Documentación de modelos de Odoo: pendiente, se irá creando en `docs/odoo-models/` a medida que se incorporen tablas espejo al esquema.

### Académico

- Propuesta: cerrada.
- Capítulo 3 (Metodología y planificación): enviado, esperando feedback.
- Próximos capítulos según el plan: 4 (semana 1), 5 (semana 2), 6 (semanas 3-4), 7 (semana 5), 8 y 9 (semana 6), revisión final (semana 7).
- Test de Privacidad UZ: pendiente de confirmar si aplica.

#### Preguntas pendientes para la dirección académica y la Secretaría EUPT

| ID | Pregunta | Dirigida a |
|----|----------|------------|
| E1 | ¿Existe plantilla específica de la EUPT para la memoria, o se usa el modelo genérico UZ disponible en biblioteca? | Director |
| E2 | Estilo de citas preferido. Propuesta del autor: IEEE numérico. | Director |
| E3 | Declaración responsable sobre uso de IA: ¿modelo propio EUPT o genérico UZ? | Secretaría EUPT |
| E4 | Test de Privacidad de la UZ: ¿se requiere dado el tratamiento de datos personales de clientes en `res.partner`? | Secretaría EUPT / Director |
| E5 | ¿Existe rúbrica de evaluación publicada o la evaluación se rige únicamente por la normativa EUPT? | Director |
| E6 | Preferencia sobre tipografía y formato del documento. | Director |
| E7 | Herramienta para la memoria: Word, LaTeX o Markdown convertido a PDF vía Pandoc. | Director |

## Alcance del TFG

**Dentro**: 

- Infraestructura completa: Next.js sobre Vercel, base de datos Supabase, sincronización con Odoo en modo solo lectura, autenticación con Google OAuth y restricción de dominios, observabilidad mínima.
- Intranet corporativa: home con tarjetas de herramientas filtradas por permisos, registro de accesos para auditoría.
- Megadashboards estratégicos: B2B v1 completo con sus bloques de KPIs, B2C v1 reducido (cabecera y operativa) si el plazo lo permite.
- Componente 1 de IA: forecasting de facturación con modelo de series temporales.
- Componente 2 de IA: resumen ejecutivo en lenguaje natural mediante API de modelo de lenguaje.

**Fuera, como trabajo futuro documentado en la memoria**: 

- Motor de inteligencia comercial original (Health Score, Stock Push Intelligence, predicción de demanda multivariable).
- Clasificación automática de motivos de no cierre con NLP.
- Detección estadística de anomalías en KPIs.
- Megadashboards de otros departamentos (Marketing, Logística, Controlling, RRHH).
- Integración completa con WooCommerce u otra plataforma B2C, y con plataformas de analítica web.

## Próximos pasos inmediatos

Sin fechas fijas dentro de cada semana. Orden recomendado para la semana 1:

1. Configurar variables de entorno en Vercel (preview y producción) con las credenciales de Odoo de prueba.
2. Crear proyecto Iron Brain en Supabase y generar las claves de servicio y anónima.
3. Configurar variables de Supabase en Vercel y en `.env.local`.
4. Instalar el SDK de Supabase y configurar cliente para Server Components y server actions.
5. Redactar la primera migración con la tabla `app_log`.
6. Redactar la migración con la tabla `profiles` y configurar Row Level Security básica.
7. Implementar el endpoint `GET /api/odoo/health` que utilice el `OdooClient` con las credenciales reales y verifique manualmente que la cuenta es de solo lectura.
8. En paralelo, comenzar la redacción del capítulo 4 (Análisis y requisitos).