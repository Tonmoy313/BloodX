BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "app_config" (
    "id" bigserial PRIMARY KEY,
    "key" text NOT NULL,
    "value" json NOT NULL,
    "updatedById" bigint NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "app_config_key" ON "app_config" USING btree ("key");
CREATE INDEX "app_config_updated_by" ON "app_config" USING btree ("updatedById");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "app_user" (
    "id" bigserial PRIMARY KEY,
    "phoneE164" text,
    "phoneHmac" text,
    "displayName" text NOT NULL,
    "language" text NOT NULL DEFAULT 'bn'::text,
    "status" text NOT NULL DEFAULT 'active'::text,
    "suspendedReason" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lastSeenAt" timestamp without time zone,
    "deletedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "app_user_phone_e164" ON "app_user" USING btree ("phoneE164");
CREATE INDEX "app_user_status" ON "app_user" USING btree ("status");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "consent_record" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "type" text NOT NULL,
    "version" text NOT NULL,
    "acceptedAt" timestamp without time zone NOT NULL,
    "locale" text NOT NULL,
    "appVersion" text NOT NULL,
    "withdrawnAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "consent_record_user_type_accepted_at" ON "consent_record" USING btree ("userId", "type", "acceptedAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "device" (
    "id" bigserial PRIMARY KEY,
    "installId" uuid NOT NULL,
    "userId" bigint NOT NULL,
    "platform" text NOT NULL,
    "pushToken" text,
    "pushTokenUpdatedAt" timestamp without time zone,
    "appVersion" text NOT NULL,
    "osVersion" text NOT NULL,
    "appCheckOkAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lastSeenAt" timestamp without time zone NOT NULL,
    "revokedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "device_install_id" ON "device" USING btree ("installId");
CREATE INDEX "device_user_id" ON "device" USING btree ("userId");
CREATE UNIQUE INDEX "device_push_token" ON "device" USING btree ("pushToken");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "feature_flag" (
    "id" bigserial PRIMARY KEY,
    "key" text NOT NULL,
    "enabled" boolean NOT NULL,
    "scope" text NOT NULL DEFAULT 'all'::text,
    "minAppVersion" text,
    "updatedById" bigint NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "feature_flag_key" ON "feature_flag" USING btree ("key");
CREATE INDEX "feature_flag_updated_by" ON "feature_flag" USING btree ("updatedById");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "otp_challenge" (
    "id" bigserial PRIMARY KEY,
    "phoneE164" text NOT NULL,
    "codeHash" text NOT NULL,
    "type" text NOT NULL,
    "attempts" bigint NOT NULL DEFAULT 0,
    "consumedAt" timestamp without time zone,
    "installId" uuid NOT NULL,
    "ip" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "otp_challenge_phone_created_at" ON "otp_challenge" USING btree ("phoneE164", "createdAt");
CREATE INDEX "otp_challenge_ip_created_at" ON "otp_challenge" USING btree ("ip", "createdAt");
CREATE INDEX "otp_challenge_install_created_at" ON "otp_challenge" USING btree ("installId", "createdAt");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "app_config"
    ADD CONSTRAINT "app_config_fk_0"
    FOREIGN KEY("updatedById")
    REFERENCES "app_user"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "consent_record"
    ADD CONSTRAINT "consent_record_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "app_user"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "device"
    ADD CONSTRAINT "device_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "app_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "feature_flag"
    ADD CONSTRAINT "feature_flag_fk_0"
    FOREIGN KEY("updatedById")
    REFERENCES "app_user"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR blood
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('blood', '20261018125653748-p0-8-auth-models', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261018125653748-p0-8-auth-models', "timestamp" = now();

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
