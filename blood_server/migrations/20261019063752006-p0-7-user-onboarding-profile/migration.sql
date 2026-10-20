BEGIN;

--
-- ACTION ALTER TABLE
--
-- Donor registration and prompt fields were already added by the earlier
-- registered migration; the latest timestamped snapshot predates that change.
ALTER TABLE "app_user" ADD COLUMN "sex" text;
ALTER TABLE "app_user" ADD COLUMN "dateOfBirth" timestamp without time zone;
ALTER TABLE "app_user" ADD COLUMN "profileImagePath" text;

--
-- MIGRATION VERSION FOR blood
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('blood', '20261019063752006-p0-7-user-onboarding-profile', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261019063752006-p0-7-user-onboarding-profile', "timestamp" = now();

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
