import 'package:flutter/material.dart';

class BerandaAdmin extends StatefulWidget {
  @override
  _BerandaAdminState createState() => _BerandaAdminState();
}

class _BerandaAdminState extends State<BerandaAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Beranda Admin"),
      ),

      body: Center(
        child: Text("Ini Beranda Admin"),
      ),
    );
  }
}