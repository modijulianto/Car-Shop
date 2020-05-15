import 'package:carshop/ui/berandaadmin.dart';
import 'package:carshop/ui/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carshop/akun.dart';


class BerandaUser extends StatefulWidget {
  @override
  _BerandaUserState createState() => _BerandaUserState();
}

class _BerandaUserState extends State<BerandaUser> {

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

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("level", 0);
    });
    Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext context)=>Login()
    ));
  }

  static final List<String> imgSlider = [
    'Audi R8.jpg',
    'BMW M5.jpg',
    'Honda Civic Type R.jpg',
    'Mercedes Benz CLS-Class.jpg',
    'Toyota GR Supra.jpg',
    'beranda.jpg'
  ];

  final CarouselSlider autoPlayImage = CarouselSlider(
    items: imgSlider.map((fileImage){
      var clipRect = ClipRect(
        
        // BorderRadius.all(Radius.circular(10)),
        child: Image.asset(
          'assets/slider/$fileImage',
          width: 10000,
          fit: BoxFit.cover,
        ),
      );
      return Container(
        margin: EdgeInsets.all(5.0),
        child: clipRect,
      );
    }).toList(),
    height: 150,
    autoPlay: true,
    enlargeCenterPage: true,
    aspectRatio: 2.0,
  );

  @override
  void initState() {
    super.initState();
    getPref();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blue,
        title:
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Text(
            "CARSHOP", 
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ]),

        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print('Click search');
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications_active), 
            onPressed: () {
              print('Click start');
            },
          ),
        ],
      ),

      //DRAWER
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text('$nama'), 
              accountEmail: new Text("$email"),
              currentAccountPicture: new GestureDetector(
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => Akun(),
                  ));
                },
                child: new CircleAvatar(
                  backgroundImage: NetworkImage('http://192.168.43.58/apicarshop/media/photo/$photo'),
                  // child: new Image.asset('assets/appimages/modi.JPG'),
                ),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/appimages/bg.jpeg'),
                  fit: BoxFit.cover
                ),
              ),
            ),

            new ListTile(
              title: new Text('Notifications'),
              trailing: new Icon(Icons.notifications_none),
            ),

            new ListTile(
              title: new Text('Wishlist'),
              trailing: new Icon(Icons.bookmark_border),
            ),
            
            new GestureDetector(
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => Akun(),
                ));
              },

              child: new ListTile(
                title: new Text('Akun'),
              trailing: new Icon(Icons.verified_user),
              )
            ),
            
            Divider(height: 2,),
            new ListTile(
              title: new Text('Setting'),
              trailing: new Icon(Icons.settings),
            ),

            new GestureDetector(
              onTap: () {
                signOut();
              },

              child: new ListTile(
                title: new Text('Logout'),
                trailing: new Icon(Icons.exit_to_app),
              )
            ),
          ],
        )
      ),
      //END DRAWER

      body: new Column(
        children: <Widget>[
          // Image.asset("assets/appimages/beranda.jpg"),
          Padding(padding: EdgeInsets.all(5.0),),
          autoPlayImage,
          Padding(padding: EdgeInsets.all(5.0),),
          Container(
            color: Colors.blueAccent[100],
            padding: const EdgeInsets.all(10),

            child: Row(
              children: [
                // Padding(padding: EdgeInsets.all(3),),
                
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CarShop',
                        style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20
                        ),
                      ),
                      Text(
                        'Singarja, Buleleng, Bali - Indonesia',
                        style: TextStyle(
                          color: Colors.black,
                        )
                      )
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.all(3),),
              ]
            ),
          ),
          Padding(padding: EdgeInsets.all(15.0),),
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Theme.of(context).dividerColor)
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.phone),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: Text(
                        "CALL",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    )
                  ],
                ),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.near_me),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: Text(
                        "ROUTE",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    )
                  ],
                ),
                
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.share),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: Text(
                        "SHARE",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    )
                  ],
                ),
              ]
            ),
          ),
          Padding(padding: EdgeInsets.all(10.0),),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              '       CarShop merupakan sebuah platform jual beli mobil baru maupun bekas yang berkualitas. Berlokasi di kota Singarja Provinsi Bali kami menjual mobil baru maupun bekas dengan harga yang bervariasi dan pastinya mobil-mobil yang kami perjual belikan adalah mobil-mobil yang berkualitas tinggi.',
              style: new TextStyle(fontSize: 15.0),
              textAlign: TextAlign.justify,
              softWrap: true,
            ),
          ),

          
        ],
      ),
    );

  }
}