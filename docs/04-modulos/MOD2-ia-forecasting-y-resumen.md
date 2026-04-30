# Módulo 2 — IA · Forecasting de facturación y resumen ejecutivo en lenguaje natural

- **Versión**: 0.1
- **Fecha**: 2026-04-28
- **Estado**: borrador

## Resumen

Este módulo introduce dos componentes de inteligencia artificial que enriquecen los megadashboards estratégicos de Iron Brain:

- **Componente 1 — Forecasting de facturación**. Predicción del cierre del periodo (mes en curso) a partir del histórico y del ritmo actual.
- **Componente 2 — Resumen ejecutivo en lenguaje natural**. Generación periódica de un texto que sintetiza los KPIs y observaciones más relevantes del megadashboard.

La incorporación de estos componentes está justificada en el ADR-0003.

## Componente 1 — Forecasting de facturación

### Objetivo

Mostrar al jefe de ventas, junto al KPI de facturación acumulada del periodo, una predicción del valor en el que cerrará el periodo si se mantiene el ritmo actual, considerando el patrón histórico.

### Variables de entrada

- Histórico de facturación diaria del equipo (B2B o B2C según megadashboard) durante los últimos 12-24 meses.
- Día actual del periodo en curso.
- Facturación acumulada hasta el día actual.

### Modelo

Modelo de series temporales con detección de estacionalidad. Se evaluarán inicialmente:

- **Prophet** (Meta): aceptable trade-off entre precisión, robustez frente a datos faltantes y facilidad de calibración.
- **ARIMA / SARIMAX** (statsmodels): alternativa clásica, mayor control sobre hiperparámetros.

La selección final se documentará con un ADR específico tras una fase de prueba con datos reales del entorno de pruebas de Odoo.

### Salida

Predicción puntual del valor al cierre del periodo más un intervalo de confianza (por ejemplo, 80%). Se almacena en una tabla `forecasts` en Supabase con campos: equipo, periodo, fecha de cómputo, valor predicho, banda inferior, banda superior, modelo utilizado, parámetros relevantes.

### Frecuencia de cómputo

Cron diario que recalcula la predicción para el periodo en curso. La predicción del megadashboard se sirve desde la tabla, no se calcula en cada visita.

### Integración en la interfaz

En el bloque de KPIs de cabecera del megadashboard:

- Valor actual: facturación acumulada al día.
- Valor predicho: cierre estimado del mes con banda de confianza.
- Comparación con el objetivo: probabilidad estimada de alcanzar el objetivo, calculada a partir del intervalo de confianza.

### Riesgos y mitigaciones

- **Datos insuficientes**: si el histórico es corto, el modelo es inexacto. Mitigación: aviso explícito en la interfaz cuando el modelo se considera poco fiable.
- **Cambios de comerciales / estructura del equipo**: alteran el patrón histórico. Mitigación: parámetros configurables sobre la ventana de histórico utilizada.

## Componente 2 — Resumen ejecutivo en lenguaje natural

### Objetivo

Generar periódicamente (por defecto semanal, los lunes) un texto en español que sintetiza los KPIs y observaciones más relevantes del megadashboard correspondiente.

### Variables de entrada

Conjunto estructurado de KPIs y comparativas del periodo (semana anterior por defecto):

- Facturación total y comparación con periodo anterior y con objetivo.
- Top productivo del equipo (por comercial).
- Variaciones significativas respecto al periodo anterior.
- Motivos de no cierre agregados (Typeform, cuando esté integrado).

### Modelo

Llamada a una API de modelo de lenguaje grande con un prompt que incluye:

- Datos estructurados del periodo en formato JSON.
- Plantilla de salida (formato, tono, secciones).
- Reglas de seguridad (no extrapolar más allá de los datos, no inventar nombres ni valores, citar siempre el dato origen).

Modelos candidatos:

- Claude API (Anthropic).
- GPT-4o-mini (OpenAI).
- Mistral Large API (Mistral).

La selección final se documentará en un ADR específico considerando precisión en español, coste por mensaje, latencia y términos de uso comerciales.

### Guardrails

- **Validación post-generación**: comparación de los valores numéricos del texto generado con los datos fuente. Cualquier discrepancia se marca y el texto se rechaza o se regenera.
- **Plantilla acotada**: la longitud máxima del texto y las secciones admitidas están definidas.
- **Citas a datos**: cada afirmación cuantitativa debe poder rastrearse a un campo de los datos de entrada.

### Salida

Texto en español, longitud máxima 250 palabras, organizado en secciones fijas: titular del periodo, productividad del equipo, alertas o atipicidades, recomendación operativa.

Almacenamiento en tabla `executive_summaries`: dashboard, periodo, fecha de generación, modelo utilizado, prompt versión, texto, hash del prompt y de los datos de entrada para trazabilidad.

### Frecuencia de generación

Semanal, los lunes a primera hora. El responsable puede solicitar regeneración manual desde el panel del megadashboard.

### Riesgos y mitigaciones

- **Alucinaciones del modelo**: invención de datos no presentes. Mitigación: validación post-generación.
- **Coste recurrente**: el uso continuado de la API supone gasto. Mitigación: cacheo del resumen, regeneración solo cuando los datos cambian o el usuario lo solicita.
- **Privacidad**: los datos enviados a la API no deben incluir información personal innecesaria. Mitigación: agregar antes de enviar, enviar solo los datos mínimos necesarios.

## Alcance del Trabajo Fin de Grado

Este módulo se implementa en las semanas 4 y 5 del plan general del proyecto (mayo de 2026). Las pruebas y la documentación se completan en la semana 7.

Quedan explícitamente fuera del alcance del Trabajo Fin de Grado y se documentan como trabajo futuro:

- Clasificación automática (NLP) de motivos de no cierre registrados en Typeform.
- Detección estadística de anomalías sobre los KPIs.
- Health Score, Stock Push Intelligence y predicción de demanda del Módulo 1 v1.0 (en pausa por decisión del cliente).

## Métricas de evaluación

- **Componente 1 (Forecasting)**: error medio absoluto porcentual (MAPE) sobre los datos históricos disponibles.
- **Componente 2 (Resumen)**: porcentaje de resúmenes generados sin errores de validación post-generación; tiempo medio de generación; coste medio por resumen.

## Datos pendientes

- Decisión sobre dónde alojar el servicio Python (Vercel, VPS pequeño, otro). Se documentará en un ADR específico.
- Decisión sobre el modelo concreto de lenguaje a utilizar (Claude, GPT-4o-mini u otro). Se documentará en un ADR específico.
- Volumen real de histórico en Odoo (a verificar al iniciar el sync).