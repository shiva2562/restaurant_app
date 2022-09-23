import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/cubit/manage_menu/manage_menu_cubit.dart';
import 'package:restaurant/model/item_model.dart';

class AddButton extends StatefulWidget {
  const AddButton(this.currentItem, {Key? key}) : super(key: key);
  final ItemModel currentItem;
  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  int count = 0;
  Widget getAddButton() {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<ManageMenuCubit>(context)
            .updateTotal(widget.currentItem.price);
        BlocProvider.of<ManageMenuCubit>(context).addOrder(widget.currentItem);
        setState(() {
          count += 1;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 25.0),
        child: Container(
          width: 70,
          height: 30,
          decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: const Center(
              child: Text(
            "Add",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          )),
        ),
      ),
    );
  }

  Widget getcounterRow() {
    return Container(
      width: 110,
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                BlocProvider.of<ManageMenuCubit>(context)
                    .updateTotal(widget.currentItem.price * -1);
                BlocProvider.of<ManageMenuCubit>(context)
                    .removeOrder(widget.currentItem);
                setState(() {
                  count -= 1;
                });
              },
              icon: const Icon(Icons.remove)),
          Text(count.toString()),
          IconButton(
              onPressed: () {
                BlocProvider.of<ManageMenuCubit>(context)
                    .updateTotal(widget.currentItem.price);
                BlocProvider.of<ManageMenuCubit>(context)
                    .addOrder(widget.currentItem);
                setState(() {
                  count += 1;
                });
              },
              icon: const Icon(Icons.add))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return count == 0 ? getAddButton() : getcounterRow();
  }
}
