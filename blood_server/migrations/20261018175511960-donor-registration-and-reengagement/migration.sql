BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "app_user" ADD COLUMN "lastDonorPromptAt" timestamp without time zone;
ALTER TABLE "app_user" ADD COLUMN "donorPromptPending" boolean NOT NULL DEFAULT false;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "donor_profile" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "bloodGroup" text NOT NULL,
    "area" text NOT NULL,
    "address" text NOT NULL,
    "latitude" double precision NOT NULL,
    "longitude" double precision NOT NULL,
    "preferredCenters" json NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "donor_profile_user_id" ON "donor_profile" USING btree ("userId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "donor_profile"
    ADD CONSTRAINT "donor_profile_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "app_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR blood
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('blood', '20261018175511960-donor-registration-and-reengagement', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261018175511960-donor-registration-and-reengagement', "timestamp" = now();

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
