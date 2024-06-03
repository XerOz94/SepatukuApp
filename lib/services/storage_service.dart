import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  
 final FirebaseStorage _storage = FirebaseStorage.instanceFor(
    bucket: 'gs://sepatukuapp.appspot.com', // Sesuaikan dengan URL bucket proyek Anda
  );
  Future<String> uploadImageToStorage(Uint8List image, String userId) async {
    Reference ref = _storage.ref().child('profile_images').child(userId);

    UploadTask uploadTask = ref.putData(image);

    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }
}
