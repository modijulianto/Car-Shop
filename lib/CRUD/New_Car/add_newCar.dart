// import 'package:carshop/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './home.dart';
import './add_newCar.dart';

class AddNewCar extends StatefulWidget {
  @override
  _AddNewCarState createState() => _AddNewCarState();
}

class _AddNewCarState extends State<AddNewCar> {

  TextEditingController controllerIdMerk = new TextEditingController();
  TextEditingController controllerNama = new TextEditingController();
  TextEditingController controllerDeskripsi = new TextEditingController();
  TextEditingController controllerKondisi = new TextEditingController();
  TextEditingController controllerHarga = new TextEditingController();
  TextEditingController controllerBintang = new TextEditingController();

  void addData(){
    var url="http://192.168.43.58/apicarshop/Carshop/saveCar";

    http.post(url, body: {
      "id_merk": controllerIdMerk.text,
      "nama_mobil": controllerNama.text,
      "deskripsi": controllerDeskripsi.text,
      "kondisi": controllerKondisi.text,
      "harga": controllerHarga.text,
      "bintang": controllerBintang.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("ADD DATA"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                new TextField(
                  controller: controllerIdMerk,
                  decoration: new InputDecoration(
                    hintText: "ID Merk",
                    labelText: "ID Merk"
                  )
                ),
                new TextField(
                  controller: controllerNama,
                  decoration: new InputDecoration(
                    hintText: "Mobil",
                    labelText: "Nama Mobil"
                  )
                ),
                new TextField(
                  controller: controllerDeskripsi,
                  decoration: new InputDecoration(
                    hintText: "Deskripsi",
                    labelText: "Deskripsi Mobil"
                  )
                ),
                new TextField(
                  controller: controllerKondisi,
                  decoration: new InputDecoration(
                    hintText: "Kondisi",
                    labelText: "Kondisi Mobil"
                  )
                ),
                new TextField(
                  controller: controllerHarga,
                  decoration: new InputDecoration(
                    hintText: "Harga",
                    labelText: "Harga"
                  )
                ),
                new TextField(
                  controller: controllerBintang,
                  decoration: new InputDecoration(
                    hintText: "Bintang",
                    labelText: "Bintang"
                  )
                ),
                

                new Padding(padding: const EdgeInsets.all(10.0),),

                new RaisedButton(
                  child: new Text("ADD DATA"),
                  color: Colors.lightBlueAccent,
                  onPressed: (){
                    addData();
                    Navigator.of(context).pop(
                      new MaterialPageRoute(
                        builder: (BuildContext context)=> new HomeCar()
                      )
                    );
                  },
                )
              ],
            ),
          ],
        ),
      )
    );
  }
}