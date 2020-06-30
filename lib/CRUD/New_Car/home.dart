import 'package:carshop/CRUD/New_Car/add_newCar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import './add_newCar.dart';
import './detailCar.dart';
// import './addData.dart';

class HomeCar extends StatefulWidget {
  @override
  _HomeCarState createState() => _HomeCarState();
}

class _HomeCarState extends State<HomeCar> {
  // List penjualanList;
  // int count=0;
  Future<List> getData() async{
    final response= await http.get("http://192.168.43.58/apicarshop/Carshop/getProduk");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      // appBar: new AppBar(
      //   title: new Text("PENJUALAN MOBIL"),
      // ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: (){
          Navigator.of(context)
          .push(MaterialPageRoute(
            builder: (BuildContext context) => AddNewCar()))
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
                builder: (BuildContext context)=> new DetailCar(list: list, index: i,)
              )
            ),
            child: new Card(
              child: new ListTile(
                title: new Text("${list[i]['nama_mobil']}"),
                leading: new Icon(Icons.directions_car),
                subtitle: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(list[i]['deskripsi']),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Rp. " + list[i]['harga'], 
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.yellow[600]
                          ),
                        ),
                        Text("   |   "),
                        Text(
                          list[i]['kondisi'],
                          style: TextStyle(
                            color: Colors.blue
                          ),
                        )
                      ],
                    ),
                  ],
                ),

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
}