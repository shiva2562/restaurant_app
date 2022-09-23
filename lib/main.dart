import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/cubit/manage_menu/manage_menu_cubit.dart';
import 'package:restaurant/model/category_model.dart';
import 'package:restaurant/model/item_model.dart';
import 'package:restaurant/presentation/menu_list/menu_list.dart';
import 'package:restaurant/presentation/order_placed/order_placed.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ManageMenuCubit _manageMenuCubit = ManageMenuCubit();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/menu': (context) => BlocProvider.value(
              value: _manageMenuCubit,
              child: MenuList(),
            ),
        '/orderplaced': (context) => BlocProvider.value(
              value: _manageMenuCubit,
              child: OrderPlaced(),
            ),
      },
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/menu');
          },
          child: const Text('Go to menu'),
        ),
      ),
    );
  }
}
