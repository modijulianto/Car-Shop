import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'detailProduk.dart';

class WishList extends StatefulWidget {
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {

  String id, nama, email, photo;
  int level=0;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      level = preferences.getInt("level");
      id = preferences.getString("id");
      nama = preferences.getString("nama");
      email = preferences.getString("email");
      photo = preferences.getString("photo");
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  Future<List> getData() async{
    final response= await http.get("http://192.168.43.58/apicarshop/Carshop/getCartById/$id");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("WISHLIST"),
      ),
      
      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot){
          if(snapshot.hasError) print(snapshot.error);

          return snapshot.hasData 
          ? new ItemList(listCart: snapshot.data, id: '$id')
          : new Center(child: new CircularProgressIndicator(),);
        }
      ),

      
    );
  }
}
class ItemList extends StatelessWidget {

  ItemList({this.listCart,this.id});
  final List listCart;
  final String id;

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: listCart == null ? 0 : listCart.length,
      itemBuilder: (context, i) {
        if (listCart[i]['id'] == id) {
          return new Container(
            child: new ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
              children: <Widget>[
                Column(
                  children: <Widget>[
                    new GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => DetailProduk(
                            idmobil: listCart[i]['id_mobil'],
                            name: listCart[i]['nama_mobil'],
                            description: "${listCart[i]['deskripsi']}",
                            merknya: "${listCart[i]['merk']}",
                            price: "${listCart[i]['harga']}",
                            kondisi: "${listCart[i]['kondisi']}",
                            transmisi: "${listCart[i]['transmisi']}",
                            lokasi: "${listCart[i]['lokasi']}",
                            warna: "${listCart[i]['warna']}",
                            tahun: "${listCart[i]['tahun']}",
                            image: listCart[i]['foto'],
                            star: 5,
                          )
                        ));
                      },
                      child: ProductBox(
                        name: "${listCart[i]['nama_mobil']}",
                        description: "${listCart[i]['deskripsi']}",
                        merknya: "${listCart[i]['merk']}",
                        price: "${listCart[i]['harga']}",
                        image: "${listCart[i]['foto']}",
                        star: 5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      }
    );
  }
}

class ProductBox extends StatelessWidget {
  ProductBox({
    Key key,
    this.name,
    this.description,
    this.price,
    this.image,
    this.star,
    this.merknya
  })
  : super(key: key);

  final String name;
  final String merknya;
  final String description;
  final String price;
  final String image;
  final int star;

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      height: 150,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.network(
              "http://192.168.43.58/apicarshop/media/Cars/" + merknya + "/" + image,
              width: 150,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      this.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(this.description),
                    Text(
                      "Price: " + this.price.toString(),
                      style: TextStyle(color: Colors.yellow),
                    ),
                    Row(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(Icons.star, size: 10, color: Colors.deepOrange),
                            Icon(Icons.star, size: 10, color: Colors.deepOrange),
                            Icon(Icons.star, size: 10, color: Colors.deepOrange),
                            Icon(Icons.star, size: 10, color: Colors.orange),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}