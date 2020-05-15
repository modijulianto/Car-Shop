import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class Akun extends StatefulWidget {
  @override
  _AkunState createState() => _AkunState();
}

class _AkunState extends State<Akun> {
  String id, nama, email, photo;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: new Text("Akun"),
      ),

      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height - 75.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
              ),
              Positioned(
                top: 75.0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(45.0),
                      topRight: Radius.circular(45.0),
                      
                    ),
                    color: Colors.white,
                  ),
                  
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width, //BoxDecoration
                )
              ),

              Positioned(
                top: 10.0,
                left: (MediaQuery.of(context).size.width /2) - 100.0,
                child: Hero(
                  tag: CircleAvatar,
                  child: Container(
                    child: CircleAvatar(
                      radius: 100.0,
                      backgroundImage: NetworkImage('http://192.168.43.58/apicarshop/media/photo/$photo'),
                    ),
                  )
                ),
              ),
              Positioned(
                top: 250.0,
                left: 25.0,
                right: 25.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.account_circle, color: Colors.blue,),
                        Padding(padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Nama",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                              ),
                            ),
                            Text("Putu Modi Julianto",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                        
                      ],
                    ),
                    
                    Padding(padding: EdgeInsets.all(10.0),),

                    Row(
                      children: <Widget>[
                        Icon(Icons.email, color: Colors.blue,),
                        Padding(padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("E-mail",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                              ),
                            ),
                            Text("modi@undiksha.ac.id",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        )
                        
                      ],
                    ),
                    Padding(padding: EdgeInsets.all(10.0),),

                    Row(
                      children: <Widget>[
                        Icon(Icons.phone_android, color: Colors.blue,),
                        Padding(padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Telepon",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                              ),
                            ),
                            Text("+62 812-3682-9877",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        )
                        
                      ],
                    ),
                  ],
                )
              )
          ],)

      ],),


    );



    // return Scaffold(
    //   appBar: new AppBar(
    //     title: new Text("Detail Akun"),
    //   ),

    //   body: new Container(
    //     color: Colors.white,
    //     child: ListView(
    //       children: <Widget>[
    //         new Padding(
    //           padding: EdgeInsets.all(80.0),
    //           child: CircleAvatar(
    //             radius: 100.0,
    //             backgroundImage: AssetImage("assets/appimages/modi.JPG"),
    //           ),
    //         ),

    //         Container(
    //           color: Colors.lightBlue[100],
    //           padding: const EdgeInsets.all(10),

    //           child: Row(
    //             children: [
    //               Expanded(
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Text(
    //                       'NAMA',
    //                       style: TextStyle(
    //                         fontWeight: FontWeight.bold, fontSize: 18
    //                       ),
    //                     ),
    //                     Text(
    //                       'Putu Modi Julianto',
    //                       style: TextStyle(
    //                         color: Colors.black54,
    //                       )
    //                     )
    //                   ],
    //                 ),
    //               )
    //             ]
    //           ),
    //         ),
    //         Padding(padding: EdgeInsets.fromLTRB(0, 3, 0, 3),),
    //         Container(
    //           color: Colors.lightBlue[100],
    //           padding: const EdgeInsets.all(10),

    //           child: Row(
    //             children: [
    //               Expanded(
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Text(
    //                       'E-MAIL',
    //                       style: TextStyle(
    //                         fontWeight: FontWeight.bold, fontSize: 18
    //                       ),
    //                     ),
    //                     Text(
    //                       'modi@undiksha.ac.id',
    //                       style: TextStyle(
    //                         color: Colors.black54,
    //                       )
    //                     )
    //                   ],
    //                 ),
    //               )
    //             ]
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}