# Graph Report - blood_client  (2026-10-24)

## Corpus Check
- 14 files · ~3,347 words
- Verdict: corpus is large enough that graph structure adds value.
- Unclassified: 1 file(s) not represented in the graph (top: (none) 1)

## Summary
- 157 nodes · 177 edges · 15 communities (11 shown, 4 thin omitted)
- Extraction: 100% EXTRACTED · 0% INFERRED · 0% AMBIGUOUS
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `736e623c`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- client.dart
- protocol.dart
- package:serverpod_client/serverpod_client.dart
- greeting.dart
- _i1.EndpointRef
- Client
- platform.dart
- language.dart
- admin_role.dart
- consent_type.dart
- otp_type.dart
- CHANGELOG.md
- endpoint.md
- README.md
- @Deprecated

## God Nodes (most connected - your core abstractions)
1. `Greeting` - 5 edges
2. `AdminRole` - 3 edges
3. `ConsentType` - 3 edges
4. `FlagScope` - 3 edges
5. `Language` - 3 edges
6. `OtpType` - 3 edges
7. `Platform` - 3 edges
8. `UserStatus` - 3 edges
9. `EndpointAccountDeletion` - 2 edges
10. `EndpointAuth` - 2 edges

## Surprising Connections (you probably didn't know these)
- `AdminRole` --implements--> `_i1.SerializableModel`  [EXTRACTED]
  lib/src/protocol/admin_role.dart → None  _Bridges community 8 → community 2_
- `ConsentType` --implements--> `_i1.SerializableModel`  [EXTRACTED]
  lib/src/protocol/consent_type.dart → None  _Bridges community 2 → community 9_
- `Greeting` --implements--> `_i1.SerializableModel`  [EXTRACTED]
  lib/src/protocol/greetings/greeting.dart → None  _Bridges community 2 → community 3_
- `Language` --implements--> `_i1.SerializableModel`  [EXTRACTED]
  lib/src/protocol/language.dart → None  _Bridges community 2 → community 7_
- `OtpType` --implements--> `_i1.SerializableModel`  [EXTRACTED]
  lib/src/protocol/otp_type.dart → None  _Bridges community 2 → community 10_

## Import Cycles
- None detected.

## Communities (15 total, 4 thin omitted)

### Community 0 - "client.dart"
Cohesion: 0.04
Nodes (46): AuthSuccess, AuthUserModel, Caller, dart:async, accountDeletion, auth, authIdp, claimDonorPrompt (+38 more)

### Community 1 - "protocol.dart"
Cohesion: 0.09
Nodes (21): admin_role.dart, client.dart, consent_type.dart, flag_scope.dart, greetings/greeting.dart, _i1.SerializationManager, language.dart, deserializeByClassName (+13 more)

### Community 2 - "package:serverpod_client/serverpod_client.dart"
Cohesion: 0.12
Nodes (15): active,
  suspended,, all,
  android,, _i1.SerializableModel, FlagScope, fromJson, ios, toJson, toString (+7 more)

### Community 3 - "greeting.dart"
Cohesion: 0.18
Nodes (11): @_i1, DateTime, author, copyWith, fromJson, Greeting, _GreetingImpl, message (+3 more)

### Community 4 - "_i1.EndpointRef"
Cohesion: 0.25
Nodes (8): _i1.EndpointRef, EndpointAccountDeletion, EndpointAuth, EndpointDonorProfile, EndpointDonorPrompt, EndpointGreeting, EndpointProfile, EndpointR2

### Community 5 - "Client"
Cohesion: 0.14
Nodes (8): _i1.ServerpodClientShared, _i3.EndpointRefreshJwtTokens, _i4.EndpointEmailIdpBase, _i4.EndpointIdpBase, Client, EndpointAuthIdp, EndpointEmailIdp, EndpointJwtRefresh

### Community 6 - "platform.dart"
Cohesion: 0.29
Nodes (6): android,, fromJson, ios, Platform, toJson, toString

### Community 7 - "language.dart"
Cohesion: 0.29
Nodes (6): bn,, en, fromJson, Language, toJson, toString

### Community 8 - "admin_role.dart"
Cohesion: 0.29
Nodes (6): AdminRole, fromJson, superAdmin, toJson, toString, ops,
  medicalReviewer,

### Community 9 - "consent_type.dart"
Cohesion: 0.29
Nodes (6): ConsentType, donorOptIn, fromJson, toJson, toString, termsOfService,
  privacyPolicy,

### Community 10 - "otp_type.dart"
Cohesion: 0.29
Nodes (6): deviceTransfer, fromJson, OtpType, toJson, toString, newAccount,
  forgetPin,

## Knowledge Gaps
- **80 isolated node(s):** `superAdmin`, `fromJson`, `toJson`, `toString`, `Modules` (+75 more)
  These have ≤1 connection - possible missing edges or undocumented components. (Counts symbols only; 119 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **4 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `Greeting` connect `greeting.dart` to `client.dart`, `protocol.dart`, `package:serverpod_client/serverpod_client.dart`?**
  _High betweenness centrality (0.090) - this node is a cross-community bridge._
- **Why does `EndpointAuthIdp` connect `Client` to `client.dart`?**
  _High betweenness centrality (0.012) - this node is a cross-community bridge._
- **Why does `EndpointEmailIdp` connect `Client` to `client.dart`?**
  _High betweenness centrality (0.012) - this node is a cross-community bridge._
- **What connects `superAdmin`, `fromJson`, `toJson` to the rest of the system?**
  _80 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `client.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.0425531914893617 - nodes in this community are weakly interconnected._
- **Should `protocol.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.09090909090909091 - nodes in this community are weakly interconnected._
- **Should `package:serverpod_client/serverpod_client.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.11764705882352941 - nodes in this community are weakly interconnected._