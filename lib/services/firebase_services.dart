import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseServices{

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference banners = FirebaseFirestore.instance.collection('slider');
  CollectionReference vendors = FirebaseFirestore.instance.collection('vendors');
  CollectionReference category = FirebaseFirestore.instance.collection('category');
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

  Future<String> uploadCategoryToDatabase(url,categoryName) async {
    String downloadUrl = await storage.ref(url).getDownloadURL();
    if(downloadUrl!=null){
      category.doc(categoryName).set({
        'images': downloadUrl,
        'name':categoryName,
      });
    }
    return downloadUrl;
  }
}