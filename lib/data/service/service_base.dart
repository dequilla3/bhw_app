import 'package:localstore/localstore.dart';

abstract class ServiceBase {
  final Localstore db = Localstore.instance;

  getLocalStoreCollections(String collection) async {
    return await db.collection(collection).get();
  }
}
