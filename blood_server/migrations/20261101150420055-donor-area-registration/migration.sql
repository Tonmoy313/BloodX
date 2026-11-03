BEGIN;

ALTER TABLE "donor_area"
    ADD COLUMN "kind" text NOT NULL DEFAULT 'tertiary',
    ADD COLUMN "gpsCell" bigint,
    ADD COLUMN "confirmedAt" timestamp without time zone NOT NULL
      DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE "donor_area"
    ALTER COLUMN "kind" DROP DEFAULT;

CREATE UNIQUE INDEX "donor_area_profile_kind"
  ON "donor_area" USING btree ("donorProfileId", "kind");
CREATE INDEX "donor_area_area"
  ON "donor_area" USING btree ("areaId");
CREATE INDEX "donor_area_gps_cell"
  ON "donor_area" USING btree ("gpsCell")
  WHERE "gpsCell" IS NOT NULL;

--
-- MIGRATION VERSION FOR blood
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('blood', '20261101150420055-donor-area-registration', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261101150420055-donor-area-registration', "timestamp" = now();

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
