import 'package:flutter/material.dart';
import 'Penjualan/home.dart' as jual;
import 'New_Car/home.dart' as newCar;

class TemplateCrud extends StatefulWidget {
  @override
  _TemplateCrudState createState() => _TemplateCrudState();
}

class _TemplateCrudState extends State<TemplateCrud> with SingleTickerProviderStateMixin {

  TabController controller;

  @override
  void initState() {
    controller = new TabController(length: 2, vsync: this);
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
      appBar: new AppBar(
         title: new Text("Daftar Mobil"),

         bottom: new  TabBar(
           controller: controller,
           tabs: <Widget>[
             new Tab(icon: Icon(Icons.shopping_cart), text: "Penjualan",),
             new Tab(icon: Icon(Icons.directions_car), text: "Tambah Mobil",),
           ],
         ),
      ),

      body: new TabBarView(
        controller: controller,
        children: <Widget>[
          new jual.Home(),
          new newCar.HomeCar(),
        ],
      ),
    );
  }
}

