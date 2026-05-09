import 'package:get_it/get_it.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/parse_server_credentials.dart';
import 'package:xlo_mobx/stores/category_store.dart';
import 'package:xlo_mobx/stores/page_store.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

class Startup {
  static Future<void> _setupParseServer() async {
    await Parse().initialize(
      applicationId,
      serverUrl,
      clientKey: clientKey,
      autoSendSessionId: true,
      debug: true,
    );
  }

  static void _setupLocators() {
    GetIt.I.registerSingleton(PageStore());
    GetIt.I.registerSingleton(UserManagerStore());
    GetIt.I.registerSingleton(CategoryStore());
  }

  static Future<void> initialize() async {
    await _setupParseServer();
    _setupLocators();
  }
}
