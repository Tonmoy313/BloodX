import 'dart:async';
import 'package:serverpod/serverpod.dart';

/// GET /health — returns 200 OK with JSON body when the server is alive.
/// Cloud Run uses this as the liveness probe (startup + liveness checks).
/// Response is intentionally cheap: no DB call, no external I/O.

class HealthRoute extends Route {
  // Automatically handles non-GET requests with a 405 Method Not Allowed response
  HealthRoute() : super(methods: {Method.get});

  @override
  FutureOr<Result> handleCall(Session session, Request request) async {
    return Response.ok(
      body: Body.fromString(
        '{"status":"ok"}',
        mimeType: MimeType.json,
      ),
    );
  }
}
