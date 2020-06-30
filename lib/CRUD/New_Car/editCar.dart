import 'package:carshop/CRUD/template.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import './home.dart';

class EditCar extends StatefulWidget {

  final List list;
  final int index;

  EditCar({this.list, this.index});

  @override
  _EditCarState createState() => _EditCarState();
}

class _EditCarState extends State<EditCar> {


  TextEditingController controllerIdMerk;
  TextEditingController controllerNama;
  TextEditingController controllerDeskripsi;
  TextEditingController controllerKondisi;
  TextEditingController controllerHarga;
  TextEditingController controllerBintang;
  TextEditingController controllerLokasi;
  TextEditingController controllerTransmisi;
  TextEditingController controllerWarna;
  TextEditingController controllerTahun;

  void editData(){
    var url="http://192.168.43.58/apicarshop/Carshop/save_updateCar";
    http.post(url,body:{
      "id_mobil": widget.list[widget.index]['id_mobil'],
      "id_merk": controllerIdMerk.text,
      "nama_mobil": controllerNama.text,
      "deskripsi": controllerDeskripsi.text,
      "lokasi": controllerLokasi.text,
      "kondisi": controllerKondisi.text,
      "transmisi": controllerTransmisi.text,
      "warna": controllerWarna.text,
      "tahun": controllerTahun.text,
      "harga": controllerHarga.text,
      "bintang": controllerBintang.text,
    });
  }

  @override
  void initState() {
    controllerIdMerk= new TextEditingController(text: widget.list[widget.index]['id_merk']);
    controllerNama= new TextEditingController(text: widget.list[widget.index]['nama_mobil']);
    controllerDeskripsi= new TextEditingController(text: widget.list[widget.index]['deskripsi']);
    controllerKondisi= new TextEditingController(text: widget.list[widget.index]['kondisi']);
    controllerHarga= new TextEditingController(text: widget.list[widget.index]['harga']);
    controllerBintang= new TextEditingController(text: widget.list[widget.index]['bintang']);
    controllerTahun= new TextEditingController(text: widget.list[widget.index]['tahun']);
    controllerWarna= new TextEditingController(text: widget.list[widget.index]['warna']);
    controllerTransmisi= new TextEditingController(text: widget.list[widget.index]['transmisi']);
    controllerLokasi= new TextEditingController(text: widget.list[widget.index]['lokasi']);
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
                  controller: controllerHarga,
                  decoration: new InputDecoration(
                    hintText: "Harga",
                    labelText: "Harga"
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
                  controller: controllerLokasi,
                  decoration: new InputDecoration(
                    hintText: "Lokasi",
                    labelText: "Lokasi Mobil"
                  )
                ),
                new TextField(
                  controller: controllerTransmisi,
                  decoration: new InputDecoration(
                    hintText: "Transmisi",
                    labelText: "Transmisi Mobil"
                  )
                ),
                new TextField(
                  controller: controllerWarna,
                  decoration: new InputDecoration(
                    hintText: "Warna",
                    labelText: "Warna Mobil"
                  )
                ),
                new TextField(
                  controller: controllerTahun,
                  decoration: new InputDecoration(
                    hintText: "Tahun",
                    labelText: "Tahun Mobil"
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
                  child: new Text("EDIT DATA"),
                  color: Colors.lightBlueAccent,
                  onPressed: (){
                    editData();
                    Navigator.of(context).pushReplacement(
                      new MaterialPageRoute(
                        builder: (BuildContext context)=>new TemplateCrud()
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