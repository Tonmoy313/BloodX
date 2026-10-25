BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "audit_log" (
    "id" bigserial PRIMARY KEY,
    "actorId" bigint NOT NULL,
    "action" text NOT NULL,
    "entityType" text NOT NULL,
    "entityKey" text NOT NULL,
    "details" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "audit_log_actor_created_at" ON "audit_log" USING btree ("actorId", "createdAt");
CREATE INDEX "audit_log_entity_created_at" ON "audit_log" USING btree ("entityType", "entityKey", "createdAt");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "audit_log"
    ADD CONSTRAINT "audit_log_fk_0"
    FOREIGN KEY("actorId")
    REFERENCES "app_user"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;

--
-- Preserve account-deletion and suspended-user phone-HMAC invariants.
--
ALTER TABLE "app_user"
    ADD CONSTRAINT "app_user_phone_hmac_suspended"
    CHECK ("phoneHmac" IS NULL OR "status" = 'suspended');

ALTER TABLE "app_user"
    ADD CONSTRAINT "app_user_deleted_anonymized"
    CHECK (
        ("status" = 'deleted' AND "phoneE164" IS NULL AND "displayName" = 'Deleted user')
        OR ("status" <> 'deleted' AND "phoneE164" IS NOT NULL)
    );

--
-- Keep an audit row in the same transaction for every app_config mutation.
--
CREATE FUNCTION "audit_app_config_change"()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
    actor_id bigint;
    config_key text;
    old_value json;
    new_value json;
BEGIN
    IF TG_OP = 'DELETE' THEN
        actor_id := OLD."updatedById";
        config_key := OLD."key";
        old_value := OLD."value";
    ELSE
        actor_id := NEW."updatedById";
        config_key := NEW."key";
        new_value := NEW."value";
        IF TG_OP = 'UPDATE' THEN
            old_value := OLD."value";
        END IF;
    END IF;

    INSERT INTO "audit_log" (
        "actorId",
        "action",
        "entityType",
        "entityKey",
        "details"
    )
    VALUES (
        actor_id,
        lower(TG_OP),
        'Config',
        config_key,
        json_build_object('oldValue', old_value, 'newValue', new_value)::text
    );

    IF TG_OP = 'DELETE' THEN
        RETURN OLD;
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER "app_config_audit"
AFTER INSERT OR UPDATE OR DELETE ON "app_config"
FOR EACH ROW EXECUTE FUNCTION "audit_app_config_change"();


--
-- MIGRATION VERSION FOR blood
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('blood', '20261018125845984-p0-8-audit-model', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261018125845984-p0-8-audit-model', "timestamp" = now();

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
