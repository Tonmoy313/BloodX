BEGIN;

--
-- Function: gen_random_uuid_v7()
-- Source: https://gist.github.com/kjmph/5bd772b2c2df145aa645b837da7eca74
-- License: MIT (copyright notice included on the generator source code).
--
create or replace function gen_random_uuid_v7()
returns uuid
as $$
begin
  -- use random v4 uuid as starting point (which has the same variant we need)
  -- then overlay timestamp
  -- then set version 7 by flipping the 2 and 1 bit in the version 4 string
  return encode(
    set_bit(
      set_bit(
        overlay(uuid_send(gen_random_uuid())
                placing substring(int8send(floor(extract(epoch from clock_timestamp()) * 1000)::bigint) from 3)
                from 1 for 6
        ),
        52, 1
      ),
      53, 1
    ),
    'hex')::uuid;
end
$$
language plpgsql
volatile;

--
-- Class Area as table app_area
--
CREATE TABLE "app_area" (
    "id" bigserial PRIMARY KEY,
    "type" text NOT NULL,
    "district" text NOT NULL,
    "name" text NOT NULL,
    "centroidCell" text
);

-- Indexes
CREATE INDEX "app_area_type" ON "app_area" USING btree ("type");
CREATE INDEX "app_area_district" ON "app_area" USING btree ("district");
CREATE UNIQUE INDEX "app_area_district_name" ON "app_area" USING btree ("district", "name");

--
-- Class Config as table app_config
--
CREATE TABLE "app_config" (
    "id" bigserial PRIMARY KEY,
    "key" text NOT NULL,
    "value" json NOT NULL,
    "enabled" boolean NOT NULL DEFAULT true,
    "description" text,
    "updatedById" bigint NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "app_config_key" ON "app_config" USING btree ("key");
CREATE INDEX "app_config_updated_by" ON "app_config" USING btree ("updatedById");

--
-- Class User as table app_user
--
CREATE TABLE "app_user" (
    "id" bigserial PRIMARY KEY,
    "phoneE164" text,
    "phoneHmac" text,
    "imageKey" text,
    "name" text NOT NULL,
    "authUserId" uuid,
    "tierId" bigint NOT NULL,
    "donorPromptPending" boolean NOT NULL DEFAULT false,
    "lastDonorPromptAt" timestamp without time zone,
    "boundInstallId" uuid,
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
CREATE INDEX "app_user_tier_id" ON "app_user" USING btree ("tierId");

--
-- Class UserPreference as table app_user_preference
--
CREATE TABLE "app_user_preference" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "notifyRequest" boolean NOT NULL DEFAULT true,
    "notifyFeed" boolean NOT NULL DEFAULT true,
    "quietHoursEnabled" boolean NOT NULL DEFAULT false,
    "quietHoursStart" timestamp without time zone,
    "quietHoursEnd" timestamp without time zone,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "app_user_preference_user_id" ON "app_user_preference" USING btree ("userId");

--
-- Class AuditLog as table audit_log
--
CREATE TABLE "audit_log" (
    "id" bigserial PRIMARY KEY,
    "actorId" bigint NOT NULL,
    "action" text NOT NULL,
    "entityType" text NOT NULL,
    "entityKey" text NOT NULL,
    "details" text,
    "metadata" json,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "audit_log_actor_created_at" ON "audit_log" USING btree ("actorId", "createdAt");
CREATE INDEX "audit_log_entity_created_at" ON "audit_log" USING btree ("entityType", "entityKey", "createdAt");

--
-- Class ConsentRecord as table consent_record
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
CREATE UNIQUE INDEX "consent_record_user_type_version" ON "consent_record" USING btree ("userId", "type", "version");
CREATE INDEX "consent_record_user_type_accepted_at" ON "consent_record" USING btree ("userId", "type", "acceptedAt");

--
-- Class Deferral as table deferral
--
CREATE TABLE "deferral" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
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
-- Class Device as table device
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
CREATE UNIQUE INDEX "device_user_id" ON "device" USING btree ("userId");
CREATE UNIQUE INDEX "device_push_token" ON "device" USING btree ("pushToken");

--
-- Class DonorArea as table donor_area
--
CREATE TABLE "donor_area" (
    "id" bigserial PRIMARY KEY,
    "donorProfileId" bigint NOT NULL,
    "kind" text NOT NULL,
    "areaId" bigint NOT NULL,
    "gpsCell" bigint,
    "confirmedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "donor_area_profile_kind" ON "donor_area" USING btree ("donorProfileId", "kind");
CREATE INDEX "donor_area_area" ON "donor_area" USING btree ("areaId");

--
-- Class DonorProfile as table donor_profile
--
CREATE TABLE "donor_profile" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "dateOfBirth" timestamp without time zone NOT NULL,
    "sex" text NOT NULL,
    "bloodGroup" text NOT NULL,
    "bloodGroupSource" text NOT NULL DEFAULT 'self'::text,
    "apheresisWilling" boolean NOT NULL DEFAULT false,
    "weightKg" double precision NOT NULL,
    "weightDeclaredAt" timestamp without time zone NOT NULL,
    "lastDonatedAt" timestamp without time zone,
    "totalDonations" bigint NOT NULL DEFAULT 0,
    "donorStatus" text NOT NULL DEFAULT 'setupIncomplete'::text,
    "leftDonorAt" timestamp without time zone,
    "alertMode" text NOT NULL DEFAULT 'off'::text,
    "availableUntil" timestamp without time zone,
    "eligibiltyReminder" boolean NOT NULL DEFAULT true,
    "lastPromptAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "donor_profile_user_id" ON "donor_profile" USING btree ("userId");

--
-- Class FeatureFlag as table feature_flag
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
-- Class KycVerification as table kyc_verification
--
CREATE TABLE "kyc_verification" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "type" text NOT NULL,
    "provider" text NOT NULL,
    "providerRef" text NOT NULL,
    "status" text NOT NULL DEFAULT 'pending'::text,
    "subjectHmac" text,
    "rejectionCode" text,
    "submittedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "completedAt" timestamp without time zone,
    "expiresAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "kyc_verification_user_type_status" ON "kyc_verification" USING btree ("userId", "type", "status");
CREATE UNIQUE INDEX "kyc_verification_provider_ref" ON "kyc_verification" USING btree ("provider", "providerRef");

--
-- Class OtpChallenge as table otp_challenge
--
CREATE TABLE "otp_challenge" (
    "id" bigserial PRIMARY KEY,
    "phoneE164" text NOT NULL,
    "codeHash" text NOT NULL,
    "type" text NOT NULL,
    "attempts" bigint NOT NULL DEFAULT 0,
    "sendCount" bigint NOT NULL DEFAULT 0,
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
-- Class ReadinessCheck as table readiness_check
--
CREATE TABLE "readiness_check" (
    "id" bigserial PRIMARY KEY,
    "donorProfileId" bigint NOT NULL,
    "questionnaireVersion" text NOT NULL,
    "outcome" text NOT NULL,
    "weightKg" double precision NOT NULL,
    "validUntil" timestamp without time zone,
    "locale" text NOT NULL,
    "appVersion" text NOT NULL,
    "checkedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "readiness_check_donor_checked_at" ON "readiness_check" USING btree ("donorProfileId", "checkedAt");

--
-- Class Tier as table tier
--
CREATE TABLE "tier" (
    "id" bigserial PRIMARY KEY,
    "code" text NOT NULL,
    "name" text NOT NULL,
    "maxOpenRequests" bigint NOT NULL DEFAULT 1,
    "requiresVerificationLevel" text NOT NULL DEFAULT 'phone'::text,
    "isActive" boolean NOT NULL DEFAULT true,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "tier_code" ON "tier" USING btree ("code");

--
-- Class TierLimit as table tier_limit
--
CREATE TABLE "tier_limit" (
    "id" bigserial PRIMARY KEY,
    "tierId" bigint NOT NULL,
    "component" text NOT NULL,
    "maxOpenBags" bigint NOT NULL,
    "maxBagsPerWindow" bigint,
    "windowDays" bigint
);

-- Indexes
CREATE UNIQUE INDEX "tier_limit_tier_component" ON "tier_limit" USING btree ("tierId", "component");

--
-- Class UserCredential as table user_credential
--
CREATE TABLE "user_credential" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "pinHash" text NOT NULL,
    "failedAttempts" bigint NOT NULL DEFAULT 0,
    "lockedUntil" timestamp without time zone,
    "pinChangedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "user_credential_user_id" ON "user_credential" USING btree ("userId");

--
-- Class UserEmail as table user_email
--
CREATE TABLE "user_email" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "email" text NOT NULL,
    "verifiedAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "user_email_user_id" ON "user_email" USING btree ("userId");
CREATE UNIQUE INDEX "user_email_email" ON "user_email" USING btree ("email");

--
-- Class CloudStorageEntry as table serverpod_cloud_storage
--
CREATE TABLE "serverpod_cloud_storage" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "addedTime" timestamp without time zone NOT NULL,
    "expiration" timestamp without time zone,
    "byteData" bytea NOT NULL,
    "verified" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_path_idx" ON "serverpod_cloud_storage" USING btree ("storageId", "path");
CREATE INDEX "serverpod_cloud_storage_expiration" ON "serverpod_cloud_storage" USING btree ("expiration");

--
-- Class CloudStorageDirectUploadEntry as table serverpod_cloud_storage_direct_upload
--
CREATE TABLE "serverpod_cloud_storage_direct_upload" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL,
    "authKey" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_direct_upload_storage_path" ON "serverpod_cloud_storage_direct_upload" USING btree ("storageId", "path");

--
-- Class FutureCallEntry as table serverpod_future_call
--
CREATE TABLE "serverpod_future_call" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "serializedObject" text,
    "serverId" text NOT NULL,
    "identifier" text
);

-- Indexes
CREATE INDEX "serverpod_future_call_time_idx" ON "serverpod_future_call" USING btree ("time");
CREATE INDEX "serverpod_future_call_serverId_idx" ON "serverpod_future_call" USING btree ("serverId");
CREATE INDEX "serverpod_future_call_identifier_idx" ON "serverpod_future_call" USING btree ("identifier");

--
-- Class ServerHealthConnectionInfo as table serverpod_health_connection_info
--
CREATE TABLE "serverpod_health_connection_info" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "active" bigint NOT NULL,
    "closing" bigint NOT NULL,
    "idle" bigint NOT NULL,
    "granularity" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_connection_info_timestamp_idx" ON "serverpod_health_connection_info" USING btree ("timestamp", "serverId", "granularity");

--
-- Class ServerHealthMetric as table serverpod_health_metric
--
CREATE TABLE "serverpod_health_metric" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "isHealthy" boolean NOT NULL,
    "value" double precision NOT NULL,
    "granularity" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_metric_timestamp_idx" ON "serverpod_health_metric" USING btree ("timestamp", "serverId", "name", "granularity");

--
-- Class LogEntry as table serverpod_log
--
CREATE TABLE "serverpod_log" (
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "reference" text,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "logLevel" bigint NOT NULL,
    "message" text NOT NULL,
    "error" text,
    "stackTrace" text,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_log_sessionLogId_idx" ON "serverpod_log" USING btree ("sessionLogId");

--
-- Class MessageLogEntry as table serverpod_message_log
--
CREATE TABLE "serverpod_message_log" (
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "serverId" text NOT NULL,
    "messageId" bigint NOT NULL,
    "endpoint" text NOT NULL,
    "messageName" text NOT NULL,
    "duration" double precision NOT NULL,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
);

--
-- Class MethodInfo as table serverpod_method
--
CREATE TABLE "serverpod_method" (
    "id" bigserial PRIMARY KEY,
    "endpoint" text NOT NULL,
    "method" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_method_endpoint_method_idx" ON "serverpod_method" USING btree ("endpoint", "method");

--
-- Class DatabaseMigrationVersion as table serverpod_migrations
--
CREATE TABLE "serverpod_migrations" (
    "id" bigserial PRIMARY KEY,
    "module" text NOT NULL,
    "version" text NOT NULL,
    "timestamp" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_migrations_ids" ON "serverpod_migrations" USING btree ("module");

--
-- Class QueryLogEntry as table serverpod_query_log
--
CREATE TABLE "serverpod_query_log" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "query" text NOT NULL,
    "duration" double precision NOT NULL,
    "numRows" bigint,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_query_log_sessionLogId_idx" ON "serverpod_query_log" USING btree ("sessionLogId");

--
-- Class ReadWriteTestEntry as table serverpod_readwrite_test
--
CREATE TABLE "serverpod_readwrite_test" (
    "id" bigserial PRIMARY KEY,
    "number" bigint NOT NULL
);

--
-- Class RuntimeSettings as table serverpod_runtime_settings
--
CREATE TABLE "serverpod_runtime_settings" (
    "id" bigserial PRIMARY KEY,
    "logSettings" json NOT NULL,
    "logSettingsOverrides" json NOT NULL,
    "logServiceCalls" boolean NOT NULL,
    "logMalformedCalls" boolean NOT NULL
);

--
-- Class SessionLogEntry as table serverpod_session_log
--
CREATE TABLE "serverpod_session_log" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "module" text,
    "endpoint" text,
    "method" text,
    "duration" double precision,
    "numQueries" bigint,
    "slow" boolean,
    "error" text,
    "stackTrace" text,
    "authenticatedUserId" bigint,
    "userId" text,
    "isOpen" boolean,
    "touched" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_session_log_serverid_idx" ON "serverpod_session_log" USING btree ("serverId");
CREATE INDEX "serverpod_session_log_time_idx" ON "serverpod_session_log" USING btree ("time");
CREATE INDEX "serverpod_session_log_touched_idx" ON "serverpod_session_log" USING btree ("touched");
CREATE INDEX "serverpod_session_log_isopen_idx" ON "serverpod_session_log" USING btree ("isOpen");

--
-- Class AnonymousAccount as table serverpod_auth_idp_anonymous_account
--
CREATE TABLE "serverpod_auth_idp_anonymous_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- Class AppleAccount as table serverpod_auth_idp_apple_account
--
CREATE TABLE "serverpod_auth_idp_apple_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "userIdentifier" text NOT NULL,
    "refreshToken" text NOT NULL,
    "refreshTokenRequestedWithBundleIdentifier" boolean NOT NULL,
    "lastRefreshedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "email" text,
    "isEmailVerified" boolean,
    "isPrivateEmail" boolean,
    "firstName" text,
    "lastName" text
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_apple_account_identifier" ON "serverpod_auth_idp_apple_account" USING btree ("userIdentifier");

--
-- Class EmailAccount as table serverpod_auth_idp_email_account
--
CREATE TABLE "serverpod_auth_idp_email_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "email" text NOT NULL,
    "passwordHash" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_idp_email_account_email" ON "serverpod_auth_idp_email_account" USING btree ("email");

--
-- Class EmailAccountPasswordResetRequest as table serverpod_auth_idp_email_account_password_reset_request
--
CREATE TABLE "serverpod_auth_idp_email_account_password_reset_request" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "emailAccountId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "challengeId" uuid NOT NULL,
    "setPasswordChallengeId" uuid
);

--
-- Class EmailAccountRequest as table serverpod_auth_idp_email_account_request
--
CREATE TABLE "serverpod_auth_idp_email_account_request" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "email" text NOT NULL,
    "challengeId" uuid NOT NULL,
    "createAccountChallengeId" uuid
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_idp_email_account_request_email" ON "serverpod_auth_idp_email_account_request" USING btree ("email");

--
-- Class FacebookAccount as table serverpod_auth_idp_facebook_account
--
CREATE TABLE "serverpod_auth_idp_facebook_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "userIdentifier" text NOT NULL,
    "email" text,
    "fullName" text,
    "firstName" text,
    "lastName" text
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_facebook_account_user_identifier" ON "serverpod_auth_idp_facebook_account" USING btree ("userIdentifier");

--
-- Class FirebaseAccount as table serverpod_auth_idp_firebase_account
--
CREATE TABLE "serverpod_auth_idp_firebase_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "created" timestamp without time zone NOT NULL,
    "email" text,
    "phone" text,
    "userIdentifier" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_firebase_account_user_identifier" ON "serverpod_auth_idp_firebase_account" USING btree ("userIdentifier");

--
-- Class GitHubAccount as table serverpod_auth_idp_github_account
--
CREATE TABLE "serverpod_auth_idp_github_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "userIdentifier" text NOT NULL,
    "email" text,
    "created" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_github_account_user_identifier" ON "serverpod_auth_idp_github_account" USING btree ("userIdentifier");

--
-- Class GoogleAccount as table serverpod_auth_idp_google_account
--
CREATE TABLE "serverpod_auth_idp_google_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "created" timestamp without time zone NOT NULL,
    "email" text NOT NULL,
    "userIdentifier" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_google_account_user_identifier" ON "serverpod_auth_idp_google_account" USING btree ("userIdentifier");

--
-- Class MicrosoftAccount as table serverpod_auth_idp_microsoft_account
--
CREATE TABLE "serverpod_auth_idp_microsoft_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "userIdentifier" text NOT NULL,
    "email" text,
    "created" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_microsoft_account_user_identifier" ON "serverpod_auth_idp_microsoft_account" USING btree ("userIdentifier");

--
-- Class PasskeyAccount as table serverpod_auth_idp_passkey_account
--
CREATE TABLE "serverpod_auth_idp_passkey_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "keyId" bytea NOT NULL,
    "keyIdBase64" text NOT NULL,
    "clientDataJSON" bytea NOT NULL,
    "attestationObject" bytea NOT NULL,
    "originalChallenge" bytea NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_idp_passkey_account_key_id_base64" ON "serverpod_auth_idp_passkey_account" USING btree ("keyIdBase64");

--
-- Class PasskeyChallenge as table serverpod_auth_idp_passkey_challenge
--
CREATE TABLE "serverpod_auth_idp_passkey_challenge" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "createdAt" timestamp without time zone NOT NULL,
    "challenge" bytea NOT NULL
);

--
-- Class RateLimitedRequestAttempt as table serverpod_auth_idp_rate_limited_request_attempt
--
CREATE TABLE "serverpod_auth_idp_rate_limited_request_attempt" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "domain" text NOT NULL,
    "source" text NOT NULL,
    "nonce" text NOT NULL,
    "ipAddress" text,
    "attemptedAt" timestamp without time zone NOT NULL,
    "extraData" json
);

-- Indexes
CREATE INDEX "serverpod_auth_idp_rate_limited_request_attempt_composite" ON "serverpod_auth_idp_rate_limited_request_attempt" USING btree ("domain", "source", "nonce", "attemptedAt");

--
-- Class SecretChallenge as table serverpod_auth_idp_secret_challenge
--
CREATE TABLE "serverpod_auth_idp_secret_challenge" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "challengeCodeHash" text NOT NULL
);

--
-- Class RefreshToken as table serverpod_auth_core_jwt_refresh_token
--
CREATE TABLE "serverpod_auth_core_jwt_refresh_token" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "scopeNames" json NOT NULL,
    "extraClaims" text,
    "method" text NOT NULL,
    "fixedSecret" bytea NOT NULL,
    "rotatingSecretHash" text NOT NULL,
    "lastUpdatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "serverpod_auth_core_jwt_refresh_token_last_updated_at" ON "serverpod_auth_core_jwt_refresh_token" USING btree ("lastUpdatedAt");

--
-- Class UserProfile as table serverpod_auth_core_profile
--
CREATE TABLE "serverpod_auth_core_profile" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "userName" text,
    "fullName" text,
    "email" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "imageId" uuid
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_profile_user_profile_email_auth_user_id" ON "serverpod_auth_core_profile" USING btree ("authUserId");

--
-- Class UserProfileImage as table serverpod_auth_core_profile_image
--
CREATE TABLE "serverpod_auth_core_profile_image" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "userProfileId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "url" text NOT NULL
);

--
-- Class ServerSideSession as table serverpod_auth_core_session
--
CREATE TABLE "serverpod_auth_core_session" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "scopeNames" json NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lastUsedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" timestamp without time zone,
    "expireAfterUnusedFor" bigint,
    "sessionKeyHash" bytea NOT NULL,
    "sessionKeySalt" bytea NOT NULL,
    "method" text NOT NULL
);

--
-- Class AuthUser as table serverpod_auth_core_user
--
CREATE TABLE "serverpod_auth_core_user" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "createdAt" timestamp without time zone NOT NULL,
    "scopeNames" json NOT NULL,
    "blocked" boolean NOT NULL
);

--
-- Foreign relations for "app_config" table
--
ALTER TABLE ONLY "app_config"
    ADD CONSTRAINT "app_config_fk_0"
    FOREIGN KEY("updatedById")
    REFERENCES "app_user"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;

--
-- Foreign relations for "app_user" table
--
ALTER TABLE ONLY "app_user"
    ADD CONSTRAINT "app_user_fk_0"
    FOREIGN KEY("tierId")
    REFERENCES "tier"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;

--
-- Foreign relations for "app_user_preference" table
--
ALTER TABLE ONLY "app_user_preference"
    ADD CONSTRAINT "app_user_preference_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "app_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "audit_log" table
--
ALTER TABLE ONLY "audit_log"
    ADD CONSTRAINT "audit_log_fk_0"
    FOREIGN KEY("actorId")
    REFERENCES "app_user"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;

--
-- Foreign relations for "consent_record" table
--
ALTER TABLE ONLY "consent_record"
    ADD CONSTRAINT "consent_record_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "app_user"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;

--
-- Foreign relations for "deferral" table
--
ALTER TABLE ONLY "deferral"
    ADD CONSTRAINT "deferral_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "app_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "device" table
--
ALTER TABLE ONLY "device"
    ADD CONSTRAINT "device_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "app_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "donor_area" table
--
ALTER TABLE ONLY "donor_area"
    ADD CONSTRAINT "donor_area_fk_0"
    FOREIGN KEY("donorProfileId")
    REFERENCES "donor_profile"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "donor_area"
    ADD CONSTRAINT "donor_area_fk_1"
    FOREIGN KEY("areaId")
    REFERENCES "app_area"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;

--
-- Foreign relations for "donor_profile" table
--
ALTER TABLE ONLY "donor_profile"
    ADD CONSTRAINT "donor_profile_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "app_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "feature_flag" table
--
ALTER TABLE ONLY "feature_flag"
    ADD CONSTRAINT "feature_flag_fk_0"
    FOREIGN KEY("updatedById")
    REFERENCES "app_user"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;

--
-- Foreign relations for "kyc_verification" table
--
ALTER TABLE ONLY "kyc_verification"
    ADD CONSTRAINT "kyc_verification_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "app_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "readiness_check" table
--
ALTER TABLE ONLY "readiness_check"
    ADD CONSTRAINT "readiness_check_fk_0"
    FOREIGN KEY("donorProfileId")
    REFERENCES "donor_profile"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "tier_limit" table
--
ALTER TABLE ONLY "tier_limit"
    ADD CONSTRAINT "tier_limit_fk_0"
    FOREIGN KEY("tierId")
    REFERENCES "tier"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;

--
-- Foreign relations for "user_credential" table
--
ALTER TABLE ONLY "user_credential"
    ADD CONSTRAINT "user_credential_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "app_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "user_email" table
--
ALTER TABLE ONLY "user_email"
    ADD CONSTRAINT "user_email_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "app_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_log" table
--
ALTER TABLE ONLY "serverpod_log"
    ADD CONSTRAINT "serverpod_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_message_log" table
--
ALTER TABLE ONLY "serverpod_message_log"
    ADD CONSTRAINT "serverpod_message_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_query_log" table
--
ALTER TABLE ONLY "serverpod_query_log"
    ADD CONSTRAINT "serverpod_query_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_anonymous_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_anonymous_account"
    ADD CONSTRAINT "serverpod_auth_idp_anonymous_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_apple_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_apple_account"
    ADD CONSTRAINT "serverpod_auth_idp_apple_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_email_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_email_account"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_email_account_password_reset_request" table
--
ALTER TABLE ONLY "serverpod_auth_idp_email_account_password_reset_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_password_reset_request_fk_0"
    FOREIGN KEY("emailAccountId")
    REFERENCES "serverpod_auth_idp_email_account"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_idp_email_account_password_reset_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_password_reset_request_fk_1"
    FOREIGN KEY("challengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_idp_email_account_password_reset_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_password_reset_request_fk_2"
    FOREIGN KEY("setPasswordChallengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_email_account_request" table
--
ALTER TABLE ONLY "serverpod_auth_idp_email_account_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_request_fk_0"
    FOREIGN KEY("challengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_idp_email_account_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_request_fk_1"
    FOREIGN KEY("createAccountChallengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_facebook_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_facebook_account"
    ADD CONSTRAINT "serverpod_auth_idp_facebook_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_firebase_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_firebase_account"
    ADD CONSTRAINT "serverpod_auth_idp_firebase_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_github_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_github_account"
    ADD CONSTRAINT "serverpod_auth_idp_github_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_google_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_google_account"
    ADD CONSTRAINT "serverpod_auth_idp_google_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_microsoft_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_microsoft_account"
    ADD CONSTRAINT "serverpod_auth_idp_microsoft_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_passkey_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_passkey_account"
    ADD CONSTRAINT "serverpod_auth_idp_passkey_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_core_jwt_refresh_token" table
--
ALTER TABLE ONLY "serverpod_auth_core_jwt_refresh_token"
    ADD CONSTRAINT "serverpod_auth_core_jwt_refresh_token_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_core_profile" table
--
ALTER TABLE ONLY "serverpod_auth_core_profile"
    ADD CONSTRAINT "serverpod_auth_core_profile_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_core_profile"
    ADD CONSTRAINT "serverpod_auth_core_profile_fk_1"
    FOREIGN KEY("imageId")
    REFERENCES "serverpod_auth_core_profile_image"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_core_profile_image" table
--
ALTER TABLE ONLY "serverpod_auth_core_profile_image"
    ADD CONSTRAINT "serverpod_auth_core_profile_image_fk_0"
    FOREIGN KEY("userProfileId")
    REFERENCES "serverpod_auth_core_profile"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_core_session" table
--
ALTER TABLE ONLY "serverpod_auth_core_session"
    ADD CONSTRAINT "serverpod_auth_core_session_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR blood
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('blood', '20261103101503765-otp-schema-index-alignment', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261103101503765-otp-schema-index-alignment', "timestamp" = now();

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
