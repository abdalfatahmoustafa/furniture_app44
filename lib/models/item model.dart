class ItemModel {
  String? item;
  String? size;
  int? number;
  num? price;
  String?id;

  ItemModel({this.item, this.size, this.number, this.price,this.id});

  ItemModel.fromJson(Map<String, dynamic> json) {
    item = json['item'];
    size = json['size'];
    number = json['number'];
    price = json['price'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item'] = this.item;
    data['size'] = this.size;
    data['number'] = this.number;
    data['price'] = this.price;
    data['id'] = this.id;
    return data;
  }
}