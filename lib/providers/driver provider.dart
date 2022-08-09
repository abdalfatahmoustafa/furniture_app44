import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:furniture_app/models/driver%20model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class DriverProvider with ChangeNotifier {
  XFile ?image;
  ImagePicker imagePicker = ImagePicker();
  DriverModel driver = DriverModel();

  get driverModel => null;

  pickImage(String choice) async {
    if (choice == "cam") {
      image = await imagePicker.pickImage(source: ImageSource.camera);
    } else {
      image = await imagePicker.pickImage(source: ImageSource.gallery);
    }
    notifyListeners();
  }

  registerDriverWithEmailAndPassword(DriverModel driverModel,
      String password) async {
    try {
      driver = driverModel;
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: driver.email!,
        password: password,
      );
      driver.id = credential.user!.uid;
      await FirebaseStorage.instance.ref().child('drivers').child(
          "${driver.id}.jpj").putFile(File(image!.path));
      String photoUrl = await FirebaseStorage.instance.ref()
          .child('drivers')
          .child("${driver.id}.jpj")
          .getDownloadURL();
      driver.photoUrl = photoUrl;
      await FirebaseFirestore.instance.collection('drivers').doc(
          credential.user!.uid).set(driver.toJson());
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return e.code;
    } catch (e) {
      print(e);
    }
  }


  driverSignIn(String email, String password) async {
    try {
      UserCredential userCredential = await
      FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);
      print(000000000000000000000000000000000000000000000000000000);
      print(userCredential);
      if (userCredential != null) {
        var userFromFS = await FirebaseFirestore.instance.collection("drivers")
            .doc(userCredential.user!.uid)
            .get();
        driver = driverModel.fromJson(userFromFS.data()!);
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      return e.code;
    }
  }

  getCurrentUser() async {
    User u = await FirebaseAuth.instance.currentUser!;
    print(u);
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}


