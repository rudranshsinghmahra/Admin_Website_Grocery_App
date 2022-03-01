import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices{
  Future<DocumentSnapshot> getAdminCredentials(id) async{
    var result = await FirebaseFirestore.instance.collection('admin').doc(id).get();
    return result;
  }
}