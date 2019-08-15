import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_template/core/models/item.dart';
import 'package:flutter_firebase_template/core/models/user_data.dart';
import 'package:flutter_firebase_template/core/services/database_service.dart';

class DatabaseServiceImpl extends DatabaseService {
  Firestore _db = Firestore.instance;
  final String userCollection = 'users';
  final String itemCollection = 'items';

  @override
  Future<UserData> readUserData(String uid) async {
    DocumentSnapshot doc =
        await _db.collection(userCollection).document(uid).get();
    return UserData.fromMap(doc.data, doc.documentID);
  }

  @override
  Future createItem(Item item) async {
    await _db.collection(itemCollection).add(item.toJson());
  }

  @override
  Future<Item> readItem(String itemId) async {
    DocumentSnapshot doc =
        await _db.collection(userCollection).document(itemId).get();
    return Item.fromMap(doc.data, doc.documentID);
  }

  @override
  Future updateItem(Item item) {
    // TODO: implement updateItem
    return null;
  }

  @override
  Future deleteItem(String itemId) {
    return _db.collection(itemCollection).document(itemId).delete();
  }

  @override
  Future<List<Item>> readItems() async {
    QuerySnapshot snapshot = await _db.collection(itemCollection).getDocuments();
    return snapshot.documents.map((doc) => Item.fromMap(doc.data, doc.documentID)).toList();
  }
}