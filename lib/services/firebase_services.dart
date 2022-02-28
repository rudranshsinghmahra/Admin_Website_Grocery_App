import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices{
  Future<QuerySnapshot> getAdminCredentials() async{
    var result = await FirebaseFirestore.instance.collection('admin').get();
    return result;
  }
}