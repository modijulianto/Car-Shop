// import 'package:carshop/main.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import './home.dart';

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {

  TextEditingController controllerNama = new TextEditingController();
  TextEditingController controllerMerk = new TextEditingController();
  TextEditingController controllerHarga = new TextEditingController();
  TextEditingController controllerTanggal = new TextEditingController();
  final format=DateFormat('yyyy-MM-dd');

  void addData(){
    var url="http://192.168.43.58/apicarshop/penjualan/save";

    http.post(url, body: {
      "nama": controllerNama.text,
      "merk": controllerMerk.text,
      "harga": controllerHarga.text,
      "tanggal": controllerTanggal.text,
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
                  controller: controllerNama,
                  decoration: new InputDecoration(
                    hintText: "Nama",
                    labelText: "Nama Pembeli"
                  )
                ),
                new TextField(
                  controller: controllerMerk,
                  decoration: new InputDecoration(
                    hintText: "Mobil",
                    labelText: "Nama Mobil"
                  )
                ),
                new TextField(
                  controller: controllerHarga,
                  decoration: new InputDecoration(
                    hintText: "Harga",
                    labelText: "Harga"
                  )
                ),
                new DateTimeField(
                  controller: controllerTanggal,
                  format: format, 
                  onShowPicker: (context, currentValue){
                    return showDatePicker(
                      context: context, 
                      initialDate: currentValue??DateTime.now(), 
                      firstDate: DateTime(2020), 
                      lastDate: DateTime(2045)
                    );
                  },
                  decoration: new InputDecoration(
                    hintText: "Tanggal",
                    labelText: "Tanggal pembelian"
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
                        builder: (BuildContext context)=> new Home()
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