import 'package:restaurant/model/item_model.dart';

class CategoryModel {
  String name;
  List<ItemModel> items;
  CategoryModel({required this.name, required this.items});
}
