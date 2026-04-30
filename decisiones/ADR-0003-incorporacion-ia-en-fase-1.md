# ADR-0003: Incorporación de capacidades de inteligencia artificial en la fase 1 del proyecto

- **Fecha**: 2026-04-28
- **Estado**: aceptado
- **Decisor**: Daniel Sanagustín López
- **Revisor técnico**: CTO de TodoCESPED

## Contexto

El alcance original de la fase 1 del proyecto, recogido en el documento de requisitos IRONB-AD-RQ v0.2, se centra en la construcción de una intranet corporativa y un conjunto de megadashboards estratégicos para los responsables de los departamentos de Ventas B2B y B2C. Las capacidades de inteligencia artificial documentadas en el primer borrador del Módulo 1 (`docs/04-modulos/MOD1-motor-inteligencia-comercial-v1.0.md`) quedan en estado pausado, a desplegar como fase posterior.

Se plantea sin embargo la conveniencia de incorporar dos componentes de inteligencia artificial dentro del alcance de la fase 1, por dos motivos:

- **Valor para el cliente**. La incorporación de predicciones y de un resumen automatizado de los megadashboards aporta capacidad analítica diferencial sobre soluciones puramente descriptivas (Power BI, Tableau).
- **Valor académico**. El proyecto, como Trabajo Fin de Grado, se beneficia de incluir un componente de inteligencia artificial bien delimitado y defendible, que ejercite competencias específicas de la titulación.

El cliente ha autorizado la incorporación de estos componentes dentro del alcance.

## Alternativas consideradas

### Alternativa A — No incorporar inteligencia artificial en la fase 1

Mantener el alcance del documento de requisitos sin variación. La IA se reactiva cuando el cliente lo decida, en una fase posterior.

Ventajas:

- Reduce riesgo de no llegar a depósito en plazo.
- Centra el esfuerzo en los megadashboards y la intranet.
- No requiere infraestructura adicional.

Inconvenientes:

- El TFG carece de un componente de IA visible y defendible. La parte técnica más diferencial del grado en Ingeniería Informática queda fuera del alcance.
- Iron Brain queda al nivel de un panel de control, sin capacidad analítica diferencial.

### Alternativa B — Reactivar el motor de inteligencia comercial completo (Health Score, Stock Push)

Volver al alcance previo del Módulo 1 v1.0: motor de acciones recomendadas diarias dirigido al comercial individual.

Ventajas:

- Componente de IA potente, con valor de negocio claro.
- Aprovecha el trabajo previo de definición funcional.

Inconvenientes:

- Es un cambio de alcance que el cliente ha pausado deliberadamente, por considerar más prioritario dotar a los responsables de departamento de capacidad de decisión informada antes que automatizar acciones a nivel comercial.
- Excede claramente el plazo disponible hasta el depósito (banda 3, junio 2026).

### Alternativa C — Incorporar dos componentes de IA delimitados dentro del alcance actual (seleccionada)

Añadir al alcance de la fase 1 dos componentes de inteligencia artificial integrados en los megadashboards estratégicos:

- **Predicción de facturación** mediante modelo de series temporales. Aplicable a los KPIs de cabecera de los megadashboards B2B y B2C.
- **Resumen ejecutivo periódico en lenguaje natural** mediante un modelo de lenguaje grande, generado a partir de los datos del megadashboard.

Otras capacidades planteadas (clasificación automática de motivos de no cierre, detección de anomalías estadísticas) se documentan como trabajo futuro dentro de la memoria del Trabajo Fin de Grado, sin compromiso de implementación en el plazo del depósito.

Ventajas:

- Componente de IA presente, defendible académicamente y útil al negocio.
- Alcance acotado y temporalmente realista (estimación: 3-4 semanas, dentro del plan general de proyecto).
- Modular: cada componente se puede desactivar sin afectar al funcionamiento de los megadashboards.
- Coexiste con la pausa del motor de acciones diarias: este queda como fase 4, sin contradicción.

Inconvenientes:

- Aumenta la complejidad técnica del proyecto: introduce Python como segunda tecnología principal junto a TypeScript / Next.js.
- Introduce un coste recurrente menor por uso de API de modelo de lenguaje.
- Reduce el margen temporal del proyecto en 3-4 semanas, que se asignan al desarrollo de IA en lugar de pulir megadashboards adicionales.

## Decisión

Se incorporan al alcance de la fase 1 dos componentes de inteligencia artificial:

- **Componente 1 — Forecasting de facturación**: predicción del cierre del periodo (mes en curso) por equipo y por comercial, sobre los megadashboards B2B y B2C. Implementado con un modelo de series temporales (Prophet o equivalente) en un servicio Python aislado del núcleo Next.js. Salida: valor predicho con intervalo de confianza, mostrado junto a los KPIs de cabecera.

- **Componente 2 — Resumen ejecutivo en lenguaje natural**: generación periódica (semanal) de un texto en español que sintetiza los KPIs y observaciones más relevantes del megadashboard. Implementado mediante llamadas a la API de un modelo de lenguaje (Claude API u OpenAI), con guardrails para mitigar alucinaciones (validación posterior contra datos fuente, plantilla acotada).

Las capacidades pausadas del Módulo 1 v1.0 (Health Score, Stock Push, predicción de demanda multivariable) quedan como trabajo futuro. Otras capacidades planteadas (clasificación NLP de motivos de no cierre, detección estadística de anomalías) se documentan como trabajo futuro de menor plazo.

## Consecuencias

### Positivas

- Iron Brain incorpora capacidad analítica diferencial respecto a soluciones puramente descriptivas.
- El Trabajo Fin de Grado dispone de un componente de inteligencia artificial bien delimitado y defendible.
- La arquitectura del proyecto incorpora desde la fase 1 la decisión de mantener Python y TypeScript como tecnologías separadas pero comunicadas mediante API REST, lo que facilita la incorporación posterior de capacidades adicionales sin reescribir el núcleo.

### Negativas o riesgos asumidos

- Se introduce complejidad operativa: dos lenguajes principales, despliegue Python adicional (en VPS pequeño o en Vercel con limitaciones de timeout).
- Se introduce un coste recurrente menor por uso de la API de un modelo de lenguaje. Magnitud estimada: dos dígitos en euros mensuales bajo uso normal.
- Las predicciones y los resúmenes generados pueden contener errores. Se mitigan mediante intervalos de confianza explícitos (componente 1) y validación post-generación (componente 2). Las salidas se presentan al usuario como apoyo a la decisión, nunca como verdad absoluta.

### Acciones derivadas

- [ ] Especificar técnicamente el módulo en `docs/04-modulos/MOD2-ia-forecasting-y-resumen.md`.
- [ ] Decidir y documentar dónde se aloja el servicio Python (ADR posterior).
- [ ] Decidir el modelo de lenguaje a utilizar para el resumen ejecutivo (ADR posterior).
- [ ] Implementar los dos componentes en el plan de proyecto (semanas 4-5 según plan).
- [ ] Documentar en la memoria del Trabajo Fin de Grado, capítulo 5 (Diseño) y capítulo 6 (Implementación), las decisiones técnicas tomadas para cada componente.

## Referencias

- IRONB-AD-RQ v0.2: documento de requisitos del proyecto.
- `docs/04-modulos/MOD1-intranet-megadashboards-v1.0.md`: especificación funcional vigente del Módulo 1.
- `docs/04-modulos/MOD1-motor-inteligencia-comercial-v1.0.md`: especificación pausada del motor de acciones.
- Taylor, S.J. y Letham, B. (2018). *Forecasting at scale*. The American Statistician, 72(1), 37-45. (Documentación de Prophet.)