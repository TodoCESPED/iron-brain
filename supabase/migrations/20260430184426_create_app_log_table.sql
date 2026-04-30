-- ============================================================
-- Migración: Crear tabla app_log
-- ============================================================
-- Tabla para el registro centralizado de eventos de aplicación
-- de Iron Brain. Se utiliza desde código server-side (Server
-- Components, Server Actions, Route Handlers, Crons) mediante
-- el cliente con service_role key.
--
-- Diseño:
-- - Identificador entero auto-incrementable (BIGSERIAL).
-- - Severidad estandarizada en 5 niveles: debug, info, warning,
--   error, fatal. Se valida con CHECK constraint.
-- - Módulo emisor del log (ej: "odoo.sync", "auth", "api").
-- - Mensaje en texto libre.
-- - Contexto estructurado en JSONB para datos adicionales.
-- - Fecha de creación con zona horaria (timestamptz).
--
-- Política de retención: trigger que borra registros con más
-- de 90 días en cada inserción. Mantiene la tabla acotada sin
-- requerir intervención externa.
--
-- Seguridad: Row Level Security activo. Solo los administradores
-- pueden consultar; las inserciones se hacen exclusivamente con
-- service_role key desde código server-side.
-- ============================================================

CREATE TABLE public.app_log (
    id          BIGSERIAL PRIMARY KEY,
    level       TEXT NOT NULL CHECK (level IN ('debug', 'info', 'warning', 'error', 'fatal')),
    module      TEXT NOT NULL,
    message     TEXT NOT NULL,
    context     JSONB,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

COMMENT ON TABLE public.app_log IS
    'Registro centralizado de eventos de aplicación de Iron Brain. '
    'Solo se escribe desde código server-side con service_role key.';

COMMENT ON COLUMN public.app_log.id IS
    'Identificador único auto-incrementable.';

COMMENT ON COLUMN public.app_log.level IS
    'Severidad del evento. Valores permitidos: debug, info, warning, error, fatal.';

COMMENT ON COLUMN public.app_log.module IS
    'Módulo emisor del log (ej: "odoo.sync", "auth", "api.health").';

COMMENT ON COLUMN public.app_log.message IS
    'Mensaje descriptivo del evento.';

COMMENT ON COLUMN public.app_log.context IS
    'Datos estructurados adicionales en formato JSONB.';

COMMENT ON COLUMN public.app_log.created_at IS
    'Fecha y hora de creación del log con zona horaria.';

-- ============================================================
-- Índices
-- ============================================================
-- Índice por level: consultas habituales tipo "dame todos los errores".
CREATE INDEX idx_app_log_level
    ON public.app_log (level);

-- Índice por module: consultas tipo "logs del sync de Odoo".
CREATE INDEX idx_app_log_module
    ON public.app_log (module);

-- Índice por created_at descendente: consultas tipo "logs más recientes".
CREATE INDEX idx_app_log_created_at_desc
    ON public.app_log (created_at DESC);

-- Índice combinado: consultas frecuentes que combinan severidad y orden temporal.
CREATE INDEX idx_app_log_level_created_at
    ON public.app_log (level, created_at DESC);

-- ============================================================
-- Política de retención: borrado automático de logs antiguos
-- ============================================================
-- Función que elimina logs con más de 90 días.
-- Se ejecuta tras cada inserción mediante trigger.
-- Por eficiencia, solo se ejecuta el borrado si el id es
-- divisible por 100, evitando carga excesiva en cada insert.
CREATE OR REPLACE FUNCTION public.app_log_cleanup_old()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF (NEW.id % 100) = 0 THEN
        DELETE FROM public.app_log
        WHERE created_at < (now() - interval '90 days');
    END IF;
    RETURN NEW;
END;
$$;

COMMENT ON FUNCTION public.app_log_cleanup_old() IS
    'Elimina logs con más de 90 días. Se ejecuta probabilísticamente '
    '(1 de cada 100 inserciones) para evitar sobrecarga.';

CREATE TRIGGER trg_app_log_cleanup
    AFTER INSERT ON public.app_log
    FOR EACH ROW
    EXECUTE FUNCTION public.app_log_cleanup_old();

-- ============================================================
-- Row Level Security
-- ============================================================
-- RLS está activado por defecto en este proyecto. Definimos
-- políticas explícitas. Sin políticas, RLS bloquea todo acceso
-- excepto el service_role key.
ALTER TABLE public.app_log ENABLE ROW LEVEL SECURITY;

-- Política: nadie puede leer la tabla a través de la API anon.
-- Las consultas legítimas se hacen desde server-side con service_role.
-- Cuando exista el sistema de roles, se añadirá una política para
-- permitir lectura a usuarios con rol 'admin'.

-- (No se define ninguna política positiva: RLS bloqueará por defecto
-- cualquier acceso desde el cliente con anon key. Esta es la postura
-- más segura.)

-- ============================================================
-- Permisos del esquema
-- ============================================================
-- Aseguramos que el rol service_role mantiene acceso total para
-- escritura desde código server-side. authenticated y anon NO tienen
-- acceso (lo bloquea RLS por defecto).
GRANT SELECT, INSERT, UPDATE, DELETE ON public.app_log TO service_role;
GRANT USAGE, SELECT ON SEQUENCE public.app_log_id_seq TO service_role;