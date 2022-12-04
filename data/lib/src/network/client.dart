import 'package:parse_server_sdk/parse_server_sdk.dart';

class DataClient {
  DataClient._();

  static Future<void> init() async {
    await Parse().initialize(
      "NcOzkfWlmC70WG4RrqCtWaqfI1AU8xAUJrBBWhPq",
      "https://parseapi.back4app.com/",
      clientKey: '2Eat3K2mZTXnvRpbJ7JOPakB9hB7g2S1TjkXWxfB',
      coreStore: await CoreStoreSembastImp.getInstance("/data"),
      autoSendSessionId: true,
    );
  }
}
