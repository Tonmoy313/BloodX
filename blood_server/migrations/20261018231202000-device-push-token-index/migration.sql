BEGIN;

--
-- Reconcile databases that applied an earlier migration with the
-- Serverpod-generated device_push_token_idx name. Keep uniqueness partial:
-- NULL push tokens are not registered and must not occupy the index.
--
DROP INDEX IF EXISTS "device_push_token";
DROP INDEX IF EXISTS "device_push_token_idx";
CREATE UNIQUE INDEX "device_push_token_idx"
    ON "device" USING btree ("pushToken")
    WHERE "pushToken" IS NOT NULL;

--
-- MIGRATION VERSION FOR blood
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('blood', '20261018231202000-device-push-token-index', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261018231202000-device-push-token-index', "timestamp" = now();

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
