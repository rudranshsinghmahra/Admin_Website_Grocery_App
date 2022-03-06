import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseServices{

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference banners = FirebaseFirestore.instance.collection('slider');
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<DocumentSnapshot> getAdminCredentials(id) async{
    var result = await FirebaseFirestore.instance.collection('admin').doc(id).get();
    return result;
  }

  Future<String> uploadBannerImageToDatabase(url) async {
    String downloadUrl = await storage.ref(url).getDownloadURL();
    if(downloadUrl!=null){
      firebaseFirestore.collection('slider').add({
        'images': downloadUrl,

      });
    }
    return downloadUrl;
  }

  deleteBannerImageFromDatabase(id) async {
    firebaseFirestore.collection('slider').doc(id).delete();
  }
}