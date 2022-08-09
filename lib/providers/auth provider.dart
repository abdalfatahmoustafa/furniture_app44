import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:furniture_app/models/driver%20model.dart';
import 'package:furniture_app/models/user%20model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AuthProvider with ChangeNotifier{
  XFile ?image;
  ImagePicker imagePicker = ImagePicker();
  UserModel user=UserModel();
  pickImage(String choice)async{
    if(choice == "cam"){
      image = await imagePicker.pickImage(source: ImageSource.camera);
    }else{
      image = await imagePicker.pickImage(source: ImageSource.gallery);
    }
    notifyListeners();
  }

  registerUserWithEmailAndPassword(UserModel userModel,String password)async{
    try {
      user = userModel;
      //print(":ssssssssssssssssssssssssssssssssssssssssssssssssssss:");
     // print(user.toJson());
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email!,
        password: password,
      );
      user.id = credential.user!.uid;
      //print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n ${user.toJson()}");
      await FirebaseStorage.instance.ref().child('users').child("${user.id}.jpj").putFile(File(image!.path));
      String photoUrl = await FirebaseStorage.instance.ref().child('users').child("${user.id}.jpj").getDownloadURL();
      user.photoUrl = photoUrl;
      await FirebaseFirestore.instance.collection('users').doc(credential.user!.uid).set(user.toJson());
notifyListeners();
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
    notifyListeners();
  }
  userSignIn(String email,String password)async{
      try{
      UserCredential userCredential =await
      FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      print(000000000000000000000000000000000000000000000000000000);
      print(userCredential);
      if(userCredential!= null){

        var userFromFS = await FirebaseFirestore.instance.collection("users").doc(userCredential.user!.uid).get();
        user = UserModel.fromJson(userFromFS.data()!);
      }

    }on FirebaseAuthException catch(e){
      print(e.code);
      return e.code;
    }

  }

   getCurrentUser() async{
    User u = await FirebaseAuth.instance.currentUser!;
    print(u);
   }
   signOut()async{
    await FirebaseAuth.instance.signOut();
   }
}