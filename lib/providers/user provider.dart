import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:furniture_app/models/item%20model.dart';
import 'package:furniture_app/models/order%20model.dart';

class UserProvider with ChangeNotifier {
  User? user;
  bool getOrders = false;
  List<Order> orders = [];
  UserProvider() {
    if (user == null) {
      getCurrentUser();
    }
  }
  Order order =Order(items: []);

  getCurrentUser() async {
    user = await FirebaseAuth.instance.currentUser!;
     getAllOrders();
  }

  getAllOrders() async {
    orders = [];
    getOrders = false;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection("orders").get();

      querySnapshot.docs.forEach((element) async {
        order=Order(items: []);


      QuerySnapshot itemsSnapShot = await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .collection("orders").doc(element.id).collection("items").get();
      itemsSnapShot.docs.forEach((element) async {
        order.items.add(ItemModel.fromJson(element.data()as Map<String,dynamic>) );
      });
        order = Order.fromJson(element.data() as Map<String, dynamic>);
      orders.add(order);
        sortingOrders();
      notifyListeners();
    });

    getOrders = true;
    sortingOrders();
    notifyListeners();
  }
  //[5,3,2,9]
  //[3,5,2,9]
  sortingOrders(){
    for(int i = 0 ; i < orders.length ; i++){
      for(int j = i+1 ; j < orders.length ; j++){
        if(orders[i].dateTime!.isBefore(orders[j].dateTime!)){
          Order temp = Order(items: []);
          temp = orders[i];
          orders[i] = orders[j];
          orders[j] = temp;
        }
      }
    }
    orders.forEach((element) {
      print("ssssssssssssssss");
      print(element.toJson());});
    notifyListeners();
  }

  void deleteOrder(int index)async {
    await FirebaseFirestore.instance.collection("users").doc(user!.uid).collection("orders").doc(orders[index].id).delete();
    getAllOrders();
  }
}
