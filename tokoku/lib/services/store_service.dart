import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tokoku/models/store_model.dart';

class StoreService {
  CollectionReference _storeCollection =
      FirebaseFirestore.instance.collection('stores');

  Future<List<StoreModel>> getStores() async {
    try {
      QuerySnapshot snapshot = await _storeCollection.get();
      List<StoreModel> stores = snapshot.docs
          .map((doc) =>
              StoreModel.fromJson(doc.id, doc.data() as Map<String, dynamic>))
          .toList();
      return stores;
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteStore(String id) async {
    try {
      await _storeCollection.doc(id).delete();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addStore(StoreModel store) async {
    try {
      await _storeCollection.add({
        'nama_toko': store.namaToko,
        'alamat': store.alamat,
      });
    } catch (e) {
      throw e;
    }
  }

  Future<void> editStore(StoreModel store) async {
    try {
      await _storeCollection.doc(store.id).update({
        'nama_toko': store.namaToko,
        'alamat': store.alamat,
      });
    } catch (e) {
      throw e;
    }
  }
}
