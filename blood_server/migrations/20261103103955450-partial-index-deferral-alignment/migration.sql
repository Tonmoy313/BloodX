BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "deferral" DROP CONSTRAINT IF EXISTS "deferral_fk_0";
ALTER TABLE "deferral" ALTER COLUMN "userId" DROP NOT NULL;
CREATE INDEX IF NOT EXISTS "deferral_user_id_active_idx"
  ON "deferral" USING btree ("userId")
  WHERE "liftedAt" IS NULL;
--
-- ACTION ALTER TABLE
--
CREATE INDEX IF NOT EXISTS "donor_area_gps_cell"
  ON "donor_area" USING btree ("gpsCell")
  WHERE "gpsCell" IS NOT NULL;
--
-- ACTION ALTER TABLE
--
CREATE INDEX IF NOT EXISTS "donor_profile_matching"
  ON "donor_profile" USING btree ("bloodGroup")
  WHERE "donorStatus" = 'active' AND "alertMode" <> 'off';
CREATE INDEX IF NOT EXISTS "donor_profile_availability_expiry"
  ON "donor_profile" USING btree ("availableUntil")
  WHERE "alertMode" <> 'off';
--
-- ACTION ALTER TABLE
--
CREATE UNIQUE INDEX IF NOT EXISTS "kyc_verification_subject_hmac_verified"
  ON "kyc_verification" USING btree ("subjectHmac")
  WHERE "status" = 'verified';
CREATE UNIQUE INDEX IF NOT EXISTS "kyc_verification_user_type_pending"
  ON "kyc_verification" USING btree ("userId", "type")
  WHERE "status" = 'pending';
--
-- ACTION ALTER TABLE
--
CREATE UNIQUE INDEX IF NOT EXISTS "otp_challenge_phone_type_open"
  ON "otp_challenge" USING btree ("phoneE164", "type")
  WHERE "consumedAt" IS NULL;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "deferral"
    DROP CONSTRAINT IF EXISTS "deferral_fk_1";

ALTER TABLE ONLY "deferral"
    ADD CONSTRAINT "deferral_fk_1"
    FOREIGN KEY("readinessCheckId")
    REFERENCES "readiness_check"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "deferral"
    ADD CONSTRAINT "deferral_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "app_user"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR blood
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('blood', '20261103103955450-partial-index-deferral-alignment', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261103103955450-partial-index-deferral-alignment', "timestamp" = now();

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
