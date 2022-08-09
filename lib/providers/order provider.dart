import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/models/driver%20model.dart';
import 'package:furniture_app/models/item%20model.dart';
import 'package:furniture_app/models/order%20model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class OrderProvider with ChangeNotifier {
  //These variables are responsible for detect origin and destination of order.
  GoogleMapController? googleMapController;
  double lat = 37.42796133580664, long = -122.085749655962;
  Set<Marker> myMarkers = {};
  Location currentLocation = Location();
  Location distinationLocation = Location();
  LocationData? origin;
  LocationData? distination;
  Dio dio = Dio();
  List<DriverModel> allDrivers = [];
  Order order = Order(items: [], done: false, price: 0, numberOfItems: 0);
  int? selectedItem;
  String selectedItemValue = "";
  int numberOfSelectedItem = 0;
  List<ItemModel> selectedItems = [];
  User? currentUser;
  Marker? m1;
  Marker? m2;
  DriverModel? driver;
  getCurrentLocation() async {
    origin = await currentLocation.getLocation();

    m1 = Marker(
        markerId: MarkerId("location1"),
        position: LatLng(origin!.latitude!, origin!.longitude!));

    myMarkers.add(m1!);
    googleMapController!.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(origin!.latitude!, origin!.longitude!), zoom: 15)));
    order.latFrom = origin!.latitude;
    order.longFrom = origin!.longitude;

    //removeListener(() { });

    notifyListeners();
  }

  getDestination(LatLng latLng) async {
    distination = await distinationLocation.getLocation();

    m2 = Marker(
        markerId: MarkerId("location2"),
        position: LatLng(latLng.latitude, latLng.longitude));

    myMarkers.add(m2!);
    order.latTo = distination!.latitude;
    order.longTo = distination!.longitude;
    googleMapController!.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(latLng.latitude, latLng.longitude), zoom: 15)));

    notifyListeners();
  }

  getDrivers(String carType) async {
    allDrivers = [];
    order.carType = carType;
    QuerySnapshot<Map<String, dynamic>> drivers =
        await FirebaseFirestore.instance.collection("drivers").get();
    //print(carType);
    for (int i = 0; i < drivers.docs.length; i++) {
      Map<String, dynamic> driver = drivers.docs[i].data();
      //print(driver['carType']);
      if (driver['carType'] == carType) {
        allDrivers.add(DriverModel.fromJson(driver));
      }
      notifyListeners();
    }
    notifyListeners();
  }

  chooseDriver(int index) async {
    order.driverId = allDrivers[index].id;
    var driverFromFirebase = await FirebaseFirestore.instance
        .collection("drivers")
        .doc(order.driverId)
        .get();
    driver = DriverModel.fromJson(driverFromFirebase.data()!);
  }

  selectDateAndTime(DateTime dateTime, TimeOfDay timeOfDay) {
    dateTime = dateTime
        .add(Duration(minutes: (timeOfDay.hour * 60) + timeOfDay.minute));
    order.dateTime = dateTime;
  }

  chooseSizeOfSelectedItem(int selected, String val) {
    selectedItem = selected;
    selectedItemValue = val;
    notifyListeners();
  }

  incrementNumberOfSelectedItem() {
    numberOfSelectedItem++;
    notifyListeners();
  }

  decrementNumberOfSelectedItem() {
    if (numberOfSelectedItem >= 0) {
      numberOfSelectedItem--;
      notifyListeners();
    }
  }

  addToSelectedItems(ItemModel item) {
    //selectedItems.add(item);
    order.items.add(item);
    notifyListeners();
  }

  calcNumberOfItemsAndPrice() {
    order.items.forEach((element) {
      order.price = order.price! + (element.number! * element.price!);
      order.numberOfItems = order.numberOfItems! + element.number!;
    });
  }

  addOrderToFirebase() async {
    //calcNumberOfItemsAndPrice();
    User user = await FirebaseAuth.instance.currentUser!;
    String orderId = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .collection("orders")
        .doc()
        .id;
    order.items.forEach((element) async {
      element.id = FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .collection("orders")
          .doc(orderId)
          .collection("items")
          .doc()
          .id;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .collection("orders")
          .doc(orderId)
          .collection("items")
          .doc(element.id)
          .set(element.toJson());
    });
    order.id = orderId;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .collection("orders")
        .doc(orderId)
        .set(order.toJson());
  }

  deleteItem(int index) {
    order.items.removeAt(index);
    notifyListeners();
  }

  chooseNumberOfHelpers(int number, int price) {
    order.numberOfHelpers = number;
    order.price = order.price! + price;
  }

  clearOrder() {
    myMarkers.clear();
    myMarkers.remove(m1);
    myMarkers.remove(m2);
    googleMapController!.dispose();
    selectedItem = null;
    selectedItemValue = "";
    selectedItems = [];
    currentLocation = Location();
    distinationLocation = Location();
    origin = null;
    distination = null;
    order.items = [];
    order.price = 0;
    order.numberOfItems = 0;

    //Order(items: [], done: false, price: 0, numberOfItems: 0);
    print(myMarkers);
    notifyListeners();
  }
  // getDistanc()async{
  //   var response = await dio.get("https://maps.googleapis.com/maps/api/directions/json?",queryParameters: {
  //     'origin': '${origin!.latitude},${origin!.longitude}',
  //     'destination':'${distination!.latitude},${distination!.longitude}',
  //     'key': "AIzaSyANe6AvXKuwbLKyUK95ppCOBTHE2YNx_3A"
  //   });
  //   print("sssssssssssssssssssaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
  //   print(response.data);
  // }
}
