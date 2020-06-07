import 'package:flutter/material.dart';

class DetailProduk extends StatefulWidget{
  DetailProduk({Key key, this.name, this.description, this.price, this.image, this.star, this.merknya}): super(key: key);

  final String merknya;
  final String name;
  final String description;
  final String price;
  final String image;
  final int star;

  @override
  _DetailProdukState createState() => _DetailProdukState();
}

class _DetailProdukState extends State<DetailProduk>{
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
        title: new Text("${widget.name}"),
      ),

      body: new Container(
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
                    child: new Text(
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

            Container(
              padding: EdgeInsets.all(10),
              color: Colors.brown[50],
              width: double.infinity,
              height: double.maxFinite,
              child: new Text(widget.description),
            )
          ],
        )
      )
    );
  }
}