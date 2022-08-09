class UserModel {
  String? name;
  String? id;
  String? email;
  String ?photoUrl;
  String ?phone;

  UserModel({this.name, this.id, this.email,this.photoUrl,this.phone});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    id = json['id'];
    email = json['email'];
    photoUrl = json['photoUrl'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['id'] = this.id;
    data['email'] = this.email;
    data['photoUrl'] = this.photoUrl;
    return data;
  }
}

