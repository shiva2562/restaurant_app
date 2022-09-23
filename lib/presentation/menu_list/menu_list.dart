import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/model/category_model.dart';
import 'package:restaurant/presentation/order_placed/order_placed.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../cubit/manage_menu/manage_menu_cubit.dart';
import '../../model/item_model.dart';
import 'add_button.dart';

class MenuList extends StatefulWidget {
  const MenuList({Key? key}) : super(key: key);
  @override
  State<MenuList> createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  List<bool> isOpens = [];
  @override
  void initState() {
    super.initState();
  }

  Future<List<CategoryModel>> readJson() async {
    List<ItemModel> cat1 = [];
    List<ItemModel> cat2 = [];
    List<ItemModel> cat3 = [];
    List<ItemModel> cat4 = [];
    List<ItemModel> cat5 = [];
    List<ItemModel> cat6 = [];

    List<CategoryModel> categories = [];
    CategoryModel popular = CategoryModel(name: "popular items", items: []);
    final prefs = await SharedPreferences.getInstance();
    final String response = await rootBundle.loadString('lib/asset/menu.json');
    final data = await json.decode(response);
    List<ItemModel> allItems = [];
    data['cat1'].forEach((v) {
      ItemModel item = ItemModel.fromJson(v);
      if (prefs.getInt(item.name) != null) {
        item.totalorders = prefs.getInt(item.name)!;
      } else {
        prefs.setInt(item.name, item.totalorders);
      }
      allItems.add(item);
      cat1.add(item);
    });
    data['cat2'].forEach((v) {
      ItemModel item = ItemModel.fromJson(v);
      if (prefs.getInt(item.name) != null) {
        item.totalorders = prefs.getInt(item.name)!;
      } else {
        prefs.setInt(item.name, item.totalorders);
      }
      allItems.add(item);
      cat2.add(ItemModel.fromJson(v));
    });
    data['cat3'].forEach((v) {
      ItemModel item = ItemModel.fromJson(v);
      if (prefs.getInt(item.name) != null) {
        item.totalorders = prefs.getInt(item.name)!;
      } else {
        prefs.setInt(item.name, item.totalorders);
      }
      allItems.add(item);
      cat3.add(ItemModel.fromJson(v));
    });
    data['cat4'].forEach((v) {
      ItemModel item = ItemModel.fromJson(v);
      if (prefs.getInt(item.name) != null) {
        item.totalorders = prefs.getInt(item.name)!;
      } else {
        prefs.setInt(item.name, item.totalorders);
      }
      allItems.add(item);
      cat4.add(ItemModel.fromJson(v));
    });
    data['cat5'].forEach((v) {
      ItemModel item = ItemModel.fromJson(v);
      if (prefs.getInt(item.name) != null) {
        item.totalorders = prefs.getInt(item.name)!;
      } else {
        prefs.setInt(item.name, item.totalorders);
      }
      allItems.add(item);
      cat5.add(ItemModel.fromJson(v));
    });
    data['cat6'].forEach((v) {
      ItemModel item = ItemModel.fromJson(v);
      if (prefs.getInt(item.name) != null) {
        item.totalorders = prefs.getInt(item.name)!;
      } else {
        prefs.setInt(item.name, item.totalorders);
      }
      allItems.add(item);
      cat6.add(ItemModel.fromJson(v));
    });

    allItems.sort((a, b) => b.totalorders.compareTo(a.totalorders));
    for (int i = 0; i < 3; i++) {
      if (allItems[i].totalorders != 0) {
        popular.items.add(allItems[i]);
        if (cat1.contains(allItems[i])) {
          cat1.remove(allItems[i]);
        } else if (cat2.contains(allItems[i])) {
          cat2.remove(allItems[i]);
        } else if (cat3.contains(allItems[i])) {
          cat3.remove(allItems[i]);
        } else if (cat4.contains(allItems[i])) {
          cat4.remove(allItems[i]);
        } else if (cat5.contains(allItems[i])) {
          cat5.remove(allItems[i]);
        } else if (cat6.contains(allItems[i])) {
          cat6.remove(allItems[i]);
        }
      }
    }
    categories.add(CategoryModel(name: 'cat1', items: cat1));
    categories.add(CategoryModel(name: 'cat2', items: cat2));
    categories.add(CategoryModel(name: 'cat3', items: cat3));
    categories.add(CategoryModel(name: 'cat4', items: cat4));
    categories.add(CategoryModel(name: 'cat5', items: cat5));
    categories.add(CategoryModel(name: 'cat6', items: cat6));
    if (popular.items.isNotEmpty) {
      categories.insert(0, popular);
    }

    return categories;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<ManageMenuCubit>(context).reset();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: const Text('Menu'), centerTitle: true),
          body: FutureBuilder(
              future: readJson(),
              builder: (context, AsyncSnapshot<List<CategoryModel>> snapshot) {
                if (snapshot.hasData) {
                  List<CategoryModel> categories = snapshot.data ?? [];
                  for (int i = 0; i < categories.length; i++) {
                    isOpens.add(true);
                  }
                  return SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 100),
                    child: ExpansionPanelList(
                      expansionCallback: (i, isOpen) => setState(() {
                        isOpens[i] = !isOpen;
                      }),
                      children: categories
                          .map((category) => ExpansionPanel(
                              canTapOnHeader: true,
                              isExpanded: isOpens[categories.indexOf(category)],
                              headerBuilder: (context, val) {
                                return Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Text(
                                        category.name,
                                        style: const TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ],
                                );
                              },
                              body: Column(
                                children: category.items
                                    .map((item) => ListTile(
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                item.name,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              (category.name ==
                                                          'popular items' &&
                                                      category.items
                                                              .indexOf(item) ==
                                                          0)
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15.0),
                                                      child: Container(
                                                        height: 20,
                                                        decoration: const BoxDecoration(
                                                            color:
                                                                Color.fromARGB(
                                                                    200,
                                                                    244,
                                                                    67,
                                                                    54),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                        child: const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 10.0,
                                                                  left: 10),
                                                          child: Center(
                                                              child: Text(
                                                            "Best Seller",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          )),
                                                        ),
                                                      ),
                                                    )
                                                  : Container()
                                            ],
                                          ),
                                          subtitle:
                                              Text('₹${item.price.toString()}'),
                                          trailing: item.instock
                                              ? AddButton(item)
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 25.0),
                                                  child: Container(
                                                    width: 70,
                                                    height: 30,
                                                    decoration: const BoxDecoration(
                                                        color: Color.fromARGB(
                                                            94, 33, 149, 243),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20))),
                                                    child: const Center(
                                                        child: Text(
                                                      "NA",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    )),
                                                  ),
                                                ),
                                        ))
                                    .toList(),
                              )))
                          .toList(),
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: BlocBuilder<ManageMenuCubit, int>(
            builder: (context, state) {
              if (state == 0) {
                return Container();
              }
              return Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 50,
                child: FloatingActionButton.extended(
                  label: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(),
                        const Text("Place Order",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w900)),
                        BlocBuilder<ManageMenuCubit, int>(
                          builder: (context, state) {
                            return Text(
                              '₹${state.toString()}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    BlocProvider.of<ManageMenuCubit>(context)
                        .selectedItems
                        .forEach((key, value) {
                      prefs.setInt(key.name, value + prefs.getInt(key.name)!);
                    });
                    Navigator.pushNamed(context, '/orderplaced');
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
