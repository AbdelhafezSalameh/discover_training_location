// FirebaseStorageService.dart
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> uploadProfileImage(File file, String userId) async {
    try {
      final Reference storageReference =
          _storage.ref().child('profile_images/$userId/${DateTime.now()}.jpg');

      final UploadTask uploadTask = storageReference.putFile(file);

      final TaskSnapshot snapshot = await uploadTask;

      final String downloadUrl = await snapshot.ref.getDownloadURL();

      // Store profile image URL in Firestore
      await _firestore.collection('users').doc(userId).update({
        'profileImage': downloadUrl,
      });

      return downloadUrl;
    } catch (e) {
      // ignore: avoid_print
      print('Error uploading profile image: $e');
      return null;
    }
  }

  Future<String?> fetchProfileImage(String userId) async {
    try {
      final DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(userId).get();

      if (snapshot.exists) {
        return snapshot.get('profileImage');
      } else {
        return null;
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching profile image: $e');
      return null;
    }
  }

  
}
