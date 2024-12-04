import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addData(String collection, Map<String, dynamic> data) async {
    try {
      await _db.collection(collection).add(data);
    } catch (e) {
      print("Failed to add data: $e");
    }
  }

  /// Fetch data from Firestore and cache it in SharedPreferences.
  Future<Map<String, dynamic>> fetchData({
    required String collection,
    required String documentId,
    required String cacheKey,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    String? cachedData = prefs.getString(cacheKey);

    // Return cached data if available
    if (cachedData != null) {
      return json.decode(cachedData);
    } else {
      final data = await fetchDataFromFirestore(
        collection: collection,
        documentId: documentId,
      );

      // Cache the fetched data
      prefs.setString(cacheKey, json.encode(data));
      return data;
    }
  }

  /// Fetch data directly from Firestore.
  Future<Map<String, dynamic>> fetchDataFromFirestore({
    required String collection,
    required String documentId,
  }) async {
    try {
      final DocumentSnapshot documentSnapshot =
      await _db.collection(collection).doc(documentId).get();

      if (documentSnapshot.exists) {
        final data = documentSnapshot.data() as Map<String, dynamic>;
        print("Fetched data: $data");
        return data;
      } else {
        throw Exception('Document not found in Firestore');
      }
    } catch (e) {
      print("Error fetching Firestore data: $e");
      throw e;
    }
  }
}
