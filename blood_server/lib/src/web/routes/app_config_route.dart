import 'package:serverpod/serverpod.dart';

class AppConfigWidget extends JsonWidget {
  final String apiUrl;

  AppConfigWidget({
    required this.apiUrl,
    required String minSupportedAppVersion,
  }) : super(
         object: {
           'apiUrl': apiUrl,
           'minSupportedAppVersion': minSupportedAppVersion,
         },
       );
}

class AppConfigRoute extends WidgetRoute {
  AppConfigWidget widget;

  AppConfigRoute({
    required final ServerConfig apiConfig,
    required String minSupportedAppVersion,
  }) : widget = AppConfigWidget(
         apiUrl: apiConfig.apiUrl.toString(),
         minSupportedAppVersion: minSupportedAppVersion,
       );

  @override
  Future<WebWidget> build(Session session, Request request) async {
    return widget;
  }
}

extension on ServerConfig {
  Uri get apiUrl => Uri(
    scheme: publicScheme,
    host: publicHost,
    port: publicPort,
  );
}
