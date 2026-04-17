# Memoria del TFG — Iron Brain

Índice preliminar. Se irá refinando a medida que avance el trabajo.

## Preliminares

- Portada (formato normalizado UZ).
- Declaración de autoría.
- Resumen (castellano).
- Abstract (inglés, máximo 1 folio).
- Agradecimientos.
- Índice general.
- Índice de figuras y tablas.
- Glosario de términos y acrónimos.

## Capítulos

1. **Introducción** — Contexto de TodoCESPED, motivación del proyecto, objetivos SMART, alcance y estructura del documento.
2. **Estado del arte** — Sistemas ERP, Odoo en el ecosistema empresarial, arquitecturas data-driven, soluciones comerciales de sincronización de datos (Fivetran, Airbyte), patrones de integración con ERPs.
3. **Metodología y planificación** — Metodología de trabajo (trunk-based con PRs), control de versiones, planificación temporal, análisis de riesgos, presupuesto.
4. **Análisis y requisitos** — Descripción del dominio de TodoCESPED, actores del sistema, casos de uso principales, requisitos funcionales, requisitos no funcionales, restricciones técnicas y legales.
5. **Diseño del sistema** — Arquitectura en 3 niveles, modelo de datos del almacén propio, diseño del cliente Odoo, estrategia de sincronización, autenticación y seguridad a nivel de fila (RLS), diseño de la interfaz de usuario.
6. **Implementación** — Stack tecnológico justificado, estructura del proyecto, implementación del cliente Odoo con allowlist, proceso de sincronización, sistema de autenticación, Módulo 1 (Motor de Inteligencia Comercial), observabilidad.
7. **Pruebas y validación** — Pruebas unitarias, de integración, end-to-end, pruebas de seguridad, verificación de requisitos.
8. **Despliegue y operación** — Integración y despliegue continuo, gestión de secretos, observabilidad en producción, copias de seguridad, análisis de costes operativos.
9. **Conclusiones y trabajo futuro** — Objetivos alcanzados, competencias desarrolladas, reflexión crítica, líneas de trabajo futuro (Fase 2: IA en VPS).

## Finales

- Bibliografía (formato IEEE, mínimo 20-30 referencias).
- Anexos:
  - Manual de instalación.
  - Manual de usuario.
  - ADRs completos.
  - Especificaciones de modelos de Odoo sincronizados.
  - Plan de pruebas detallado.
  - Test de Privacidad (si aplica).