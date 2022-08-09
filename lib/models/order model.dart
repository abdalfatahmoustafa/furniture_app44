import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture_app/models/item%20model.dart';

class Order {
  String ?id;
  num? price;
  bool? done;
  String? carType;
  String ?driverId;
  int? numberOfHelpers;
  int? numberOfItems;
  double? latFrom;
  double? latTo;
  double? longFrom;
  double? longTo;
  DateTime ?dateTime;
  List<ItemModel> items = [];
  Order(
      {this.price,
        this.done,
        this.carType,
        this.numberOfHelpers,
        this.driverId,
        this.id,
        this.numberOfItems,
        this.dateTime,
        required this.items
      });

  Order.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    latFrom = json['latFrom'];
    longFrom = json['longFrom'];
    latTo = json['latTo'];
    longTo = json['longTo'];
    id = json['id'];
    done = json['done'];
    carType = json['carType'];
    numberOfHelpers = json['numberOfHelpers'];
    numberOfItems = json['numberOfItems'];
    driverId = json['driverId'];
    dateTime = json['dateTime'].toDate();

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['latFrom'] = this.latFrom;
    data['latTo'] = this.latTo;
    data['longFrom'] = this.longFrom;
    data['longTo'] = this.longTo;
    data['id'] = this.id;
    data['done'] = this.done;
    data['carType'] = this.carType;
    data['numberOfHelpers'] = this.numberOfHelpers;
    data['numberOfItems'] = this.numberOfItems;
    data['driverId'] = this.driverId;
    data['dateTime'] = this.dateTime;

    return data;
  }
}