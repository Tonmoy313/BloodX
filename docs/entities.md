# Application entities

The application entities are declared in `blood_server/lib/src/models/` and
generated using Serverpod's table and protocol conventions. PostgreSQL-specific
constraints and triggers are kept in additive migrations.

## User

`User` stores the application profile and lifecycle state. Phone numbers are
unique while present; deletion anonymizes the account by setting the phone to
null, the display name to `Deleted user`, and the status to `deleted`.
`authUserId` maps the application profile to Serverpod authentication and is
cleared during account deletion. Donor mode is stored separately; User has no
role column.

The phone HMAC is retained only while suspended to block re-registration.
Deletion is blocked for suspended accounts unless an administrator with the
super-admin role completes a review and records its reference.

## Device

`Device` associates an installation with a user and stores platform, app/OS
versions, and an optional push token. Account deletion removes all associated
device rows. The unique PostgreSQL partial index is named
`device_push_token_idx` and applies only when the token is not null.

## OtpChallenge

`OtpChallenge` stores a code hash, type, attempt count, installation and
request metadata, and expiry. Clear OTP codes are never stored. Account
deletion removes outstanding challenges matching the user's phone number.

## ConsentRecord

Account deletion is a soft delete: consent records remain associated with the
anonymized user row.

## DonorProfile

`DonorProfile` is server-only and stores the donor's blood group, area,
address, precise coordinates, and preferred centers. This information is used
only for donor registration and nearby matching. Account deletion removes the
profile. A non-donor may receive an optional in-app registration prompt no more
often than once every 30 days; eligibility and claiming are enforced by the
server.

## FeatureFlag

`FeatureFlag` stores whether a feature is enabled and its applicable scope and
minimum app version. Flags are used for the app's coming-soon behavior.

## Config

`Config` stores non-secret tunables. API keys, tokens, passwords, and other
credentials must be stored in the deployment secret manager, never here.
Config rows are deactivated with `enabled=false`, not deleted. Changes require
an enabled super-admin, set the transaction-local `app.actor_user_id`, and
write an audit record without copying configuration values into the audit log.
Audit sources are `api`, `migration`, or `seed`; migration audits use a null
actor. Metadata must not contain secrets or health data.

## AuditLog

`AuditLog` is append-only. Database triggers reject updates, deletes, and
truncation. Config audit records include the transaction actor and source
metadata in the same transaction as the Config change.

## Serverpod mappings

Serverpod's generated schema uses its supported PostgreSQL types and an
auto-generated bigint `id` for table entities. PostgreSQL-specific partial
indexes and audit/lifecycle safeguards are applied by migration SQL. Verify
these database-level objects after migrations are applied; model declarations
alone do not prove that the safeguards exist in a deployed database.
