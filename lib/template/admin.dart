import 'package:flutter/material.dart';
// import './detailproduk.dart';
// import './beranda.dart' as beranda;
import 'package:carshop/listMerk.dart' as listmerk;
import 'package:carshop/CRUD/template.dart' as crud;
import 'package:carshop/ui/beranda.dart' as user;

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState(){
    controller = new TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new TabBarView(
        controller: controller,
        children: <Widget>[
          new user.BerandaUser(),
          new listmerk.ListMerk(),
          new crud.TemplateCrud(),
        ],
      ),

      bottomNavigationBar: new Material(
        color: Colors.blue,
        child: new TabBar(
          controller: controller,
          tabs: <Widget>[
            new Tab(icon: new Icon(Icons.home)),
            new Tab(icon: new Icon(Icons.list)),
            new Tab(icon: new Icon(Icons.shopping_cart)),
          ],
        ),
      ),
    );
  }
}