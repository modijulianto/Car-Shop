import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DetailProduk extends StatefulWidget{
  DetailProduk({
    Key key, 
    this.name, 
    this.kondisi, 
    this.transmisi, 
    this.warna, 
    this.tahun, 
    this.idmobil, 
    this.description, 
    this.price, 
    this.image, 
    this.lokasi, 
    this.star, 
    this.merknya
    })
    : super(key: key);

  final String idmobil;
  final String merknya;
  final String name;
  final String description;
  final String price;
  final String image;
  final String kondisi;
  final String transmisi;
  final String warna;
  final String tahun;
  final String lokasi;
  final int star;

  @override
  _DetailProdukState createState() => _DetailProdukState();
}

class _DetailProdukState extends State<DetailProduk>{

  String id, nama, email, photo, icon;
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

  void addToCart(){
    var url="http://192.168.43.58/apicarshop/Carshop/addToCart";

    http.post(url, body: {
      "id_mobil": "${widget.idmobil}",
      "id": "$id",
    });
  }

  final childrenstar = <Widget>[];
  @override

  Widget build(BuildContext context){
    for (var i = 0; i < widget.star; i++){
      childrenstar.add(
        new Icon(
          Icons.star,
          size: 15,
          color: Colors.yellow,
        )
      );
    }

    return Scaffold(
      appBar: new AppBar(
        title:
        Row(mainAxisAlignment: MainAxisAlignment.center, 
          children: <Widget>[
            Text(
              "${widget.name}", 
              style: TextStyle(
                fontSize: 15.0
              ),
            ),
          ]
        ),
        
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_shopping_cart), 
            onPressed: () {
              addToCart();
              print('Add To Cart');
            },
          ),
        ],
      ),

      body: new Container(
        color: Colors.blue[50],
        width: double.infinity,
        child: new ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                new Image.asset("assets/Cars/" + widget.merknya + "/" + widget.image)
              ],
            ),
            Container(
              decoration: new BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [const Color(0xff3164bd), const Color(0xff295cb5)],
                ),
              ),

              padding: EdgeInsets.all(10),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: childrenstar,
                  ),

                  new Container(
                    child: new Text("Rp. " +
                      this.widget.price.toString(),
                      style: new TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: "NeoSansBold"
                      ),
                    ),
                  )
                ]
              ),
            ),
            Padding(padding: EdgeInsets.all(10.0)),

            new Card(
              child: ListTile(
                title: Text("Description:"),
                subtitle: Text(widget.description),
              ),
            ),
            new Card(
              child: ListTile(
                title: Text("Spesifikasi:"),
                contentPadding: EdgeInsets.all(10.0),
                subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text("Lokasi")
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text("Merk")
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text("Kondisi")
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text("Tahun")
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text("Transmisi")
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text("Warna")
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(" : ")
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(" : ")
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(" : ")
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(" : ")
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(" : ")
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(" : ")
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(widget.lokasi)
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(widget.merknya)
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(widget.kondisi)
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(widget.tahun)
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(widget.transmisi)
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(widget.warna)
                          ],
                        ),
                      ],
                    ),
                    
                  ],
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new RaisedButton(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // new Icon(Icons.verified_user),
                      new Text("CALL THE SELLER")
                    ],
                  ),
                  color: Colors.lightBlue,
                  splashColor: Colors.cyan,
                  onPressed: (){
                    Navigator.of(context).push(new MaterialPageRoute(
                    // builder: (BuildContext context) => Register(),
                    ));
                  },
                ),
              ],
            ),
          ],
        )
      )
    );
  }
}