import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tourism_host/Models/owner_model.dart';
import 'package:tourism_host/Models/property_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addOwner(Owner owner) async {
    await _db.collection('owners').doc(owner.id).set(owner.toMap());
  }

  Future<void> addProperty(Property property) async {
    await _db.collection('properties').doc(property.id).set(property.toMap());
  }

  Future<void> addPackage(Map<String, dynamic> packageData, String packageId) async {
    await _db.collection('packages').doc(packageId).set(packageData);
  }
}
