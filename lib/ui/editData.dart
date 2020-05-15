import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import './home.dart';

class EditData extends StatefulWidget {

  final List list;
  final int index;

  EditData({this.list, this.index});

  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {


  TextEditingController controllerNama;
  TextEditingController controllerMerk;
  TextEditingController controllerHarga;
  TextEditingController controllerTanggal;
  final format=DateFormat('yyyy-MM-dd');

  void editData(){
    var url="http://192.168.43.58/apicarshop/penjualan/save_update";
    http.post(url,body:{
      "id": widget.list[widget.index]['id'],
      "nama": controllerNama.text,
      "merk": controllerMerk.text,
      "harga": controllerHarga.text,
      "tanggal": controllerTanggal.text,
    });
  }

  @override
  void initState() {
    controllerNama= new TextEditingController(text: widget.list[widget.index]['nama']);
    controllerMerk= new TextEditingController(text: widget.list[widget.index]['merk']);
    controllerHarga= new TextEditingController(text: widget.list[widget.index]['harga']);
    controllerTanggal= new TextEditingController(text: widget.list[widget.index]['tanggal']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: new Text("EDIT DATA"),),
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
                  child: new Text("EDIT DATA"),
                  color: Colors.lightBlueAccent,
                  onPressed: (){
                    editData();
                    Navigator.of(context).pushReplacement(
                      new MaterialPageRoute(
                        builder: (BuildContext context)=>new Home()
                      )
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}