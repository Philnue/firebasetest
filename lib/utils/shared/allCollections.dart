import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasetest/utils/shared/constants.dart';

class AllCollections {
  static final String license = "license";
  static final String aemter = "aemter";
  static final String users = "users";
  static final String termine = "termine";

  static final licenseCollection =
      FirebaseFirestore.instance.collection(license);
  static final aemterCollection = FirebaseFirestore.instance.collection(aemter);
  static final usersCollection = FirebaseFirestore.instance.collection(users);
  static final termineCollection =
      FirebaseFirestore.instance.collection(termine);
}
