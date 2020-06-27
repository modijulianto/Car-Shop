// import 'package:carshop/main.dart';
import 'package:flutter/material.dart';
import './editCar.dart';
import 'package:http/http.dart' as http;
import 'home.dart';

class DetailCar extends StatefulWidget {
  List list;
  int index;
  DetailCar({this.index,this.list});
  @override
  _DetailCarState createState() => _DetailCarState();
}

class _DetailCarState extends State<DetailCar> {

  // void deleteData(id){
  //   var url="http://192.168.43.58/apicarshop/penjualan/delete";
  //   http.post(url, body:{
  //     'id': widget.list[widget.index]['id']
  //   });
  // }

  void confirm (id){
    AlertDialog alertDialog = new AlertDialog(
      content: new Text("Are you sure want to delete '${widget.list[widget.index]['nama_mobil']}' with '${widget.list[widget.index]['merk']}'"),
      actions: <Widget>[
        new RaisedButton(
          child: new Text("OK Delete!"),
          color: Colors.red[400],
          onPressed: (){
            deletePenjualan(id);
            Navigator.of(context).pushReplacement(
              new MaterialPageRoute(
                builder: (BuildContext context)=>new HomeCar(),
              )
            );
          },
        ),
        new RaisedButton(
          child: new Text("Cancel!"),
          color: Colors.lightBlueAccent,
          onPressed: ()=>Navigator.pop(context),
        ),
      ],
    );

    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("${widget.list[widget.index]['nama_mobil']}"),),
      body: new Container(
        height: 300.0,
        padding: const EdgeInsets.all(20.0),
        child: new Card(
          child: new Center(
            child: new Column(
              children: <Widget>[
                new Padding(padding: const EdgeInsets.only(top: 30.0),),
                new Text(widget.list[widget.index]['nama_mobil'], style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                new Text("Merk : ${widget.list[widget.index]['merk']}", style: new TextStyle(fontSize: 18.0),),
                new Text("${widget.list[widget.index]['deskripsi']}", style: new TextStyle(fontSize: 18.0),),
                new Text("Harga : ${widget.list[widget.index]['harga']}", style: new TextStyle(fontSize: 18.0),),
                new Text("Kondisi : ${widget.list[widget.index]['kondisi']}", style: new TextStyle(fontSize: 18.0),),
                new Text("Bintang : ${widget.list[widget.index]['bintang']}", style: new TextStyle(fontSize: 18.0),),
                new Padding(padding: const EdgeInsets.only(top: 30.0),),

                new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new RaisedButton(
                      child: new Text("Edit"),
                      color: Colors.lightBlueAccent,
                      onPressed: ()=>Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (BuildContext context)=>new EditCar(list: widget.list, index: widget.index,),
                        )
                      ),
                    ),
                    Padding(padding: const EdgeInsets.all(10.0)),
                    new RaisedButton(
                      child: new Text("Delete"),
                      color: Colors.red[400],
                      onPressed: ()=>confirm(widget.list[widget.index]['id_mobil']),
                    ),
                  ],
                )
              ],
            )
          ),
        )
      ),
    );
  }

  Future<http.Response> deletePenjualan(id) async {
    final http.Response response= await http.delete("http://192.168.43.58/apicarshop/Carshop/deleteCar/$id");

    return response;
  }
}