import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StorageService {
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

///to uploading images//
  Future<void> uploadImage(String inputSource, BuildContext context) async {
    final picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(
        source:
            inputSource == 'camera' ? ImageSource.camera : ImageSource.gallery);
    if (pickedImage == null) {
      return;
    }
    String fileName = pickedImage.name;
    File imageFile = File(pickedImage.path);
    try {
      await firebaseStorage.ref(fileName).putFile(imageFile);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Successfully Uploaded')));
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }


// /to retrive or show image in UI from firebase storage//
  Future<List> loadImages() async {
    List<Map> files = [];
    final ListResult result = await firebaseStorage.ref().listAll();
    final List<Reference> allFiles = result.items;
    await Future.forEach(allFiles, (Reference file) async {
      final String fileUrl = await file.getDownloadURL();
      files.add({
        "url":fileUrl,
        "path":file.fullPath,
      });
    });
    return files;
  }


}
