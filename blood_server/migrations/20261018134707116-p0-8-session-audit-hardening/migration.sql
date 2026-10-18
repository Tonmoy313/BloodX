BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "admin_user" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "role" text NOT NULL,
    "enabled" boolean NOT NULL DEFAULT true,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "admin_user_user_id" ON "admin_user" USING btree ("userId");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "app_config" ADD COLUMN "enabled" boolean NOT NULL DEFAULT true;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "app_user" ADD COLUMN "authUserId" uuid;
CREATE INDEX "app_user_auth_user_id" ON "app_user" USING btree ("authUserId");
--
-- ACTION ALTER TABLE
--
ALTER TABLE "audit_log" ADD COLUMN "metadata" json;

--
-- Keep API credentials out of the application configuration table.
--
ALTER TABLE "app_config"
    ADD CONSTRAINT "app_config_key_no_secrets"
    CHECK ("key" !~* '(api[_-]?key|secret|password|credential|private[_-]?key)');

--
-- Require transaction-local attribution for Config writes and never audit values.
--
DROP TRIGGER IF EXISTS "app_config_audit" ON "app_config";
DROP FUNCTION IF EXISTS "audit_app_config_change"();

CREATE FUNCTION "audit_app_config_change"()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
    actor_id bigint;
    source_tag text;
    config_key text;
    config_enabled boolean;
BEGIN
    IF TG_OP = 'DELETE' THEN
        RAISE EXCEPTION 'Config rows cannot be deleted; disable the row instead'
            USING ERRCODE = 'restrict_violation';
    END IF;

    actor_id := NULLIF(current_setting('app.actor_user_id', true), '')::bigint;
    IF actor_id IS NULL THEN
        RAISE EXCEPTION 'app.actor_user_id must be set for Config changes'
            USING ERRCODE = 'insufficient_privilege';
    END IF;
    IF actor_id <> NEW."updatedById" THEN
        RAISE EXCEPTION 'Config updatedById must match app.actor_user_id'
            USING ERRCODE = 'insufficient_privilege';
    END IF;

    source_tag := COALESCE(
        NULLIF(current_setting('app.audit_source', true), ''),
        'application'
    );
    config_key := NEW."key";
    config_enabled := NEW."enabled";

    INSERT INTO "audit_log" (
        "actorId",
        "action",
        "entityType",
        "entityKey",
        "details",
        "metadata"
    )
    VALUES (
        actor_id,
        lower(TG_OP),
        'Config',
        config_key,
        json_build_object('enabled', config_enabled)::text,
        json_build_object('source', source_tag)
    );

    RETURN NEW;
END;
$$;

CREATE TRIGGER "app_config_audit"
AFTER INSERT OR UPDATE ON "app_config"
FOR EACH ROW EXECUTE FUNCTION "audit_app_config_change"();

CREATE FUNCTION "block_config_delete"()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
    RAISE EXCEPTION 'Config rows cannot be deleted; disable the row instead'
        USING ERRCODE = 'restrict_violation';
END;
$$;

CREATE TRIGGER "app_config_no_delete"
BEFORE DELETE ON "app_config"
FOR EACH ROW EXECUTE FUNCTION "block_config_delete"();

--
-- AuditLog is append-only, including protection against TRUNCATE.
--
CREATE FUNCTION "block_audit_log_mutation"()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
    RAISE EXCEPTION 'AuditLog is immutable'
        USING ERRCODE = 'restrict_violation';
END;
$$;

CREATE TRIGGER "audit_log_no_update_delete"
BEFORE UPDATE OR DELETE ON "audit_log"
FOR EACH ROW EXECUTE FUNCTION "block_audit_log_mutation"();

CREATE TRIGGER "audit_log_no_truncate"
BEFORE TRUNCATE ON "audit_log"
FOR EACH STATEMENT EXECUTE FUNCTION "block_audit_log_mutation"();

--
-- PostgreSQL's unique indexes allow multiple NULL values; make push-token
-- uniqueness explicitly partial so only registered tokens are indexed.
--
DROP INDEX IF EXISTS "device_push_token";
CREATE UNIQUE INDEX "device_push_token"
    ON "device" USING btree ("pushToken")
    WHERE "pushToken" IS NOT NULL;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "admin_user"
    ADD CONSTRAINT "admin_user_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "app_user"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR blood
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('blood', '20261018134707116-p0-8-session-audit-hardening', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261018134707116-p0-8-session-audit-hardening', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260213194423028', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260213194423028', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260129181112269', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181112269', "timestamp" = now();


COMMIT;
