BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "donor_profile"
    RENAME COLUMN "availabilityMode" TO "alertMode";
ALTER TABLE "donor_profile" DROP COLUMN "criticalOverride";
ALTER TABLE "donor_profile"
    RENAME COLUMN "remindersOptIn" TO "eligibiltyReminder";
ALTER TABLE "donor_profile" DROP COLUMN "promptSnoozeUntil";
ALTER TABLE "donor_profile" DROP COLUMN "notificationPausedUntil";
ALTER TABLE "donor_profile" ALTER COLUMN "weightKg" SET NOT NULL;
ALTER TABLE "donor_profile" ALTER COLUMN "weightDeclaredAt" SET NOT NULL;

--
-- MIGRATION VERSION FOR blood
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('blood', '20261103091311414-donor-profile-column-alignment', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261103091311414-donor-profile-column-alignment', "timestamp" = now();

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
