import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:restaurant/model/item_model.dart';

part 'manage_menu_state.dart';

class ManageMenuCubit extends Cubit<int> {
  ManageMenuCubit() : super(0);
  int total = 0;
  Map<ItemModel, int> selectedItems = {};
  updateTotal(int newPrice) {
    total = total + newPrice;
    emit(total);
  }

  addOrder(ItemModel item) {
    if (selectedItems.containsKey(item)) {
      selectedItems[item] = selectedItems[item]! + 1;
    } else {
      selectedItems[item] = 1;
    }
  }

  reset() {
    total = 0;
    selectedItems = {};
    emit(0);
  }

  removeOrder(ItemModel item) {
    if (selectedItems.containsKey(item)) {
      if (selectedItems[item]! > 1) {
        selectedItems[item] = selectedItems[item]! - 1;
      } else {
        selectedItems.remove(item);
      }
    }
  }
}
