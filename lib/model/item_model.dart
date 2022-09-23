class ItemModel {
  late String name;
  late int price;
  late bool instock;
  int totalorders = 0;
  ItemModel({
    required this.name,
    required this.price,
    required this.instock,
  });

  ItemModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    instock = json['instock'];
  }
}
