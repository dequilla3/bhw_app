import 'package:bhw_app/provider/app_provider.dart';

abstract class ServiceBase {
  final AppProvider appProvider = AppProvider();

  getLocalStoreCollections(String collection) async {
    return await appProvider.db.collection(collection).get();
  }
}
