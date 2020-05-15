import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import './detail.dart';
import './addData.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // List penjualanList;
  // int count=0;
  Future<List> getData() async{
    final response= await http.get("http://192.168.43.58/apicarshop/penjualan");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("PENJUALAN MOBIL"),
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: (){
          Navigator.of(context)
          .push(MaterialPageRoute(
            builder: (BuildContext context) => AddData()))
            .then((value) => {setState(() {})});
        },
      ),
      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot){
          if(snapshot.hasError) print(snapshot.error);

          return snapshot.hasData 
          ? new ItemList(list: snapshot.data,)
          : new Center(child: new CircularProgressIndicator(),);
        }
      ),
    );
  }
}
class ItemList extends StatelessWidget {

  final List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list==null ? 0 : list.length,
      itemBuilder: (context, i){
        // return new Text(list[i]['nama']);
        return new Container(
          padding: const EdgeInsets.all(3.0),
          child: new GestureDetector(
            onTap: ()=>Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (BuildContext context)=> new Detail(list: list, index: i,)
              )
            ),
            child: new Card(
              child: new ListTile(
                title: new Text(list[i]['nama']),
                leading: new Icon(Icons.widgets),
                subtitle: new Text("Mobil : ${list[i]['merk']}"),

                // trailing: GestureDetector(
                //   child: Icon(Icons.delete, color: Colors.red,),
                //   onTap: (){},
                // ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Future <http.Response> deletePenjualan(id) async {
  //   final http.Response response=await http.delete("http://192.168.43.58/apicarshop/penjualan/delete/$id");
  //   Future<List> ItemList=getData();
  //   ItemList.then((ItemList){
  //     setState((){
  //       this.
  //     })
  //   })

  // }
}