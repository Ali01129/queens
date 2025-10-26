import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

import 'package:supabase_flutter/supabase_flutter.dart';

class sendImage {

  Future<String?> uploadImageToSStorage(File imageFile, String uid) async {
    try {
      // Get file extension (e.g., .jpg, .png)
      final String extension = path.extension(imageFile.path);

      // Combine uid and extension for the storage path
      final String fileName = '$uid$extension';

      // Upload the image
      final response = await Supabase.instance.client.storage
          .from('images')
          .upload(fileName, imageFile);

      if (response.isEmpty) {
        print('Upload failed');
        return null;
      }

      // Get the public URL
      final String publicUrl = Supabase.instance.client.storage
          .from('images')
          .getPublicUrl(fileName);

      return publicUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<void> saveImageUrlToFirestore(String uid, String imageUrl) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'imageUrl': imageUrl,
      });
    } catch (e) {
      print('Error saving image URL: $e');
    }
  }
}