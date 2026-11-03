BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "deferral" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint,                              -- nullable: FK SET NULL on account delete
    "phoneHmac" text,
    "type" text NOT NULL,
    "reason" text NOT NULL,
    "source" text NOT NULL,
    "readinessCheckId" bigint,
    "startsAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "endsAt" timestamp without time zone,
    "liftedAt" timestamp without time zone,
    "liftedBy" bigint,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "permanent_deferral_block" (
    "id" bigserial PRIMARY KEY,
    "phoneHmac" text NOT NULL,
    "reason" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "permanent_deferral_block_phone_hmac"
    ON "permanent_deferral_block" USING btree ("phoneHmac");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "deferral"
    ADD CONSTRAINT "deferral_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "app_user"("id")
    ON DELETE SET NULL        -- ← keep permanent rows after account deletion
    ON UPDATE NO ACTION;

ALTER TABLE ONLY "deferral"
    ADD CONSTRAINT "deferral_fk_1"
    FOREIGN KEY("readinessCheckId")
    REFERENCES "readiness_check"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;

-- -------------------------------------------------------------------------
-- CHECK: PERMANENT ⇔ endsAt IS NULL
-- Adjust 'permanent'/'temporary' casing to match what your Dart code writes.
-- -------------------------------------------------------------------------
ALTER TABLE "deferral"
  ADD CONSTRAINT "deferral_permanent_ends_at_chk"
  CHECK ((("type" = 'permanent') = ("endsAt" IS NULL)));

-- -------------------------------------------------------------------------
-- CHECK: reason must be one of the coarse values
-- -------------------------------------------------------------------------
ALTER TABLE "deferral"
  ADD CONSTRAINT "deferral_reason_chk"
  CHECK ("reason" IN (
    'lowWeight','ageLimit','recentDonation',
    'temporaryHealth','travel','medicalReview'
  ));

ALTER TABLE "permanent_deferral_block"
  ADD CONSTRAINT "permanent_deferral_block_reason_chk"
  CHECK ("reason" IN (
    'lowWeight','ageLimit','recentDonation',
    'temporaryHealth','travel','medicalReview'
  ));

-- -------------------------------------------------------------------------
-- Partial indexes (column names MUST match the model, in quotes)
-- -------------------------------------------------------------------------
CREATE INDEX "deferral_user_id_active_idx"
  ON "deferral" ("userId")
  WHERE "liftedAt" IS NULL;

CREATE UNIQUE INDEX "kyc_verification_subject_hmac_verified"
  ON "kyc_verification" ("subjectHmac")
  WHERE "status" = 'verified';

CREATE UNIQUE INDEX "kyc_verification_user_type_pending"
  ON "kyc_verification" ("userId", "type")
  WHERE "status" = 'pending';

DROP INDEX IF EXISTS "device_push_token";
CREATE UNIQUE INDEX "device_push_token"
  ON "device" ("pushToken")
  WHERE "pushToken" IS NOT NULL;

CREATE UNIQUE INDEX "otp_challenge_phone_type_open"
  ON "otp_challenge" ("phoneE164", "type")
  WHERE "consumedAt" IS NULL;

CREATE INDEX "donor_profile_matching"
  ON "donor_profile" ("bloodGroup")
  WHERE "donorStatus" = 'active' AND "availabilityMode" <> 'off';

CREATE INDEX "donor_profile_availability_expiry"
  ON "donor_profile" ("availableUntil")
  WHERE "availabilityMode" <> 'off';

--
-- MIGRATION VERSION FOR blood
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('blood', '20261101093420764', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261101093420764', "timestamp" = now();

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
