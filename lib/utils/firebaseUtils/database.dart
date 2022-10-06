import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetest/utils/Models/member.dart';
import 'package:firebasetest/utils/Models/appointment.dart';
import 'package:firebasetest/utils/shared/allCollections.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference myCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference termineCollection =
      FirebaseFirestore.instance.collection("termine");

  Future<Member> getCustomUserDataFromFireBase() async {

    var jsonDoc = await FirebaseFirestore.instance
        .collection(AllCollections.users)
        .doc(uid)
        .get();

    return Member.fromJson(jsonDoc.data()!);
  }

  Stream<Member> get userData {
    return FirebaseFirestore.instance
        .collection(AllCollections.users)
        .doc(uid)
        .snapshots()
        .map(
          (snapshot) => Member.fromJson(snapshot.data()!),
        );
  }
}
