
class DriverModel {
  String? name;
  String? id;
  String? email;
  String? phone;
  String? photoUrl;
  String? carType;
  int? carNumber;
  bool? available;
  num? pricePerKilo;

  DriverModel(
      {this.name,
        this.id,
        this.email,
        this.phone,
        this.photoUrl,
        this.carType,
        this.carNumber,
        this.available,this.pricePerKilo});

  DriverModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    email = json['email'];
    phone = json['phone'];
    photoUrl = json['photoUrl'];
    carType = json['carType'];
    carNumber = json['carNumber'];
    available = json['available'];
    pricePerKilo = json['pricePerKilo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['photoUrl'] = this.photoUrl;
    data['carType'] = this.carType;
    data['carNumber'] = this.carNumber;
    data['available'] = this.available;
    data['pricePerKilo'] = this.pricePerKilo;
    return data;
  }
}