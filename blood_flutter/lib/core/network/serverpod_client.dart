import 'package:blood_client/blood_client.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

late final Client client;
late String serverUrl;

void initializeClient(String url) {
  serverUrl = url;
  client = Client(url)
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authSessionManager = FlutterAuthSessionManager();
}
