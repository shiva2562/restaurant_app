import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/cubit/manage_menu/manage_menu_cubit.dart';
import 'package:restaurant/model/item_model.dart';

class OrderPlaced extends StatefulWidget {
  const OrderPlaced({Key? key}) : super(key: key);

  @override
  State<OrderPlaced> createState() => _OrderPlacedState();
}

class _OrderPlacedState extends State<OrderPlaced> {
  var values;
  @override
  void initState() {
    values = BlocProvider.of<ManageMenuCubit>(context).selectedItems;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Order Placed'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 18.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: values.length,
                itemBuilder: (BuildContext context, int index) {
                  ItemModel key = values.keys.elementAt(index);
                  return ListTile(
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(key.name,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w700)),
                        const SizedBox(
                          width: 10,
                        ),
                        Text("x${values[key]}")
                      ],
                    ),
                    trailing: Text("₹${key.price * values[key]}"),
                  );
                },
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14.0, right: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total:",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w900)),
                  Text(
                    '₹${BlocProvider.of<ManageMenuCubit>(context).total.toString()}',
                    style: const TextStyle(
                        color: Colors.green, fontWeight: FontWeight.w700),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
