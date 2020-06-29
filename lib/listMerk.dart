import 'dart:convert';
// import 'package:carshop/listProduk2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './detailProduk.dart';
import 'dart:async';

class ListMerk extends StatefulWidget {
  @override
  _ListMerkState createState() => _ListMerkState();
}

class _ListMerkState extends State<ListMerk> {
  Future<List> getData() async {
    final response = await http.get("http://192.168.43.58/apicarshop/Carshop/merk");
    return json.decode(response.body.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LIST MERK"),
      ),
      resizeToAvoidBottomPadding: false,
      body: FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
          ? new ItemList(list: snapshot.data,)
          : new Center(child: new CircularProgressIndicator(),);
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});

  List<Container> daftarmerkmobil = new List();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        for (var j = 0; j < list.length; j++) {
          // new List(
          // daftarmerkmobil.add(
          return new Container(
            padding: new EdgeInsets.all(10.0),
            child: new Card(
              child: new Column(
                children: <Widget>[
                  new Hero(
                      tag: list[i]['merk'],
                      child: new Material(
                        child: new InkWell(
                          onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => new ListProduk(
                              idmerk: list[i]["id_merk"],
                              merk: list[i]["merk"],
                              logo: list[i]["logo"],
                            ),
                          )),
                          child: new Image.network(
                            'http://192.168.43.58/apicarshop/media/logo/${list[i]['logo']}',
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      )),
                  new Text(
                    list[i]['merk'],
                    style: new TextStyle(fontSize: 20.0),
                  )
                ],
              ),
            ),
          );
          // );
          // );
        }
      },
    );
  }
}

class ListProduk extends StatelessWidget {
  ListProduk({this.merk, this.logo, this.idmerk});

  final String idmerk;
  final String merk;
  final String logo;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new ListView(
      children: <Widget>[
        new Container(
          height: 630.0,
          child: new Hero(
            tag: merk,
            child: new Material(
              child: new InkWell(
              // child: new Image.asset("assets/logo/$logo"),
                child: new ListMobil(
                  merk: merk,
                  logo: logo,
                  idmerk: idmerk,
                ),
              )
            )
          ),
        ),

        // new ListCar(merk: merk, logo: logo,),
      ],
    ));
  }
}

// ===================================== LIST MOBIL =====================================
class ListMobil extends StatefulWidget {
  ListMobil({this.merk, this.logo, this.idmerk});
  final String merk;
  final String logo;
  final String idmerk;
  @override
  _ListMobilState createState() => _ListMobilState();
}

class _ListMobilState extends State<ListMobil> {
  Future<List> getData() async {
    final response =
    await http.get("http://192.168.43.58/apicarshop/Carshop/getProduk");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("List Mobil")),
      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? new ListCar(
                list: snapshot.data,
                merk: widget.merk,
                logo: widget.logo,
                idmerk: widget.idmerk,
              )
              : new Center(
                child: new CircularProgressIndicator(),
              );
        }
      ),
    );
  }
}

class ListCar extends StatefulWidget {
  ListCar({this.merk, this.logo, this.idmerk, this.list});

  final List list;
  final String idmerk;
  final String merk;
  final String logo;

  @override
  _ListCarState createState() => _ListCarState();
}

class _ListCarState extends State<ListCar> {
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: widget.list == null ? 0 : widget.list.length,
        itemBuilder: (context, i) {
          if (widget.list[i]['id_merk'] == "${widget.idmerk.toString()}") {
            return new Container(
              padding: const EdgeInsets.all(3.0),
              child: new ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
                children: <Widget>[
                  new GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => DetailProduk(
                                name: widget.list[i]['nama_mobil'],
                                description: "${widget.list[i]['deskripsi']}",
                                merknya: "${widget.list[i]['merk']}",
                                price: "${widget.list[i]['harga']}",
                                image: widget.list[i]['foto'],
                                star: widget.list[i]['bintang'],
                              )));
                    },
                    child: ProductBox(
                      name: widget.list[i]['nama_mobil'],
                      description: "${widget.list[i]['deskripsi']}",
                      merknya: "${widget.list[i]['merk']}",
                      price: "${widget.list[i]['harga']}",
                      image: widget.list[i]['foto'],
                      star: widget.list[i]['bintang'],
                    ),
                  )
                ],
              ),
            );
          }
        });
  }
}

// class ItemList2 extends StatelessWidget {

//   ItemList2({this.list,this.merk,this.logo,this.idmerk});
//   final List list;
//   final String merk;
//   final String logo;
//   final String idmerk;

//   @override
//   Widget build(BuildContext context) {
//     return new ListView.builder(
//       itemCount: list==null ? 0 : list.length,
//       itemBuilder: (context, i){
//         if(list[i]['id_merk'] == this.idmerk){
//           return new Container(
//             padding: const EdgeInsets.all(3.0),
//             child: new ListView(
//               shrinkWrap: true,
//               padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
//               children: <Widget>[
//                 new GestureDetector(
//                   onTap: () {
//                     Navigator.of(context).push(new MaterialPageRoute(
//                       builder: (BuildContext context) => DetailProduk(
//                         name: list[i]['nama_mobil'],
//                         description: "${list[i]['deskripsi']}",
//                         merknya: "${list[i]['merk']}",
//                         price: "${list[i]['harga']}",
//                         image: list[i]['foto'],
//                         star: list[i]['bintang'],
//                       )
//                     ));
//                   },

//                   child: ProductBox(
//                     name: list[i]['nama_mobil'],
//                     description: "${list[i]['deskripsi']}",
//                     merknya: "${list[i]['merk']}",
//                     price: "${list[i]['harga']}",
//                     image: list[i]['foto'],
//                     star: list[i]['bintang'],
//                   ),
//                 )
//               ],
//             ),
//           );
//         }
//       },
//     );
//   }
// }

class ProductBox extends StatelessWidget {
  ProductBox(
      {Key key,
      this.name,
      this.description,
      this.price,
      this.image,
      this.star,
      this.merknya})
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
      height: 120,
      child: Card(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.network(
            "192.168.43.58/media/Cars/" + this.merknya + "/" + image,
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
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
// ===================================== END LIST MOBIL =====================================
