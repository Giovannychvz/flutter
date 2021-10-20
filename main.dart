import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tienda/models/productos_model.dart';
import 'package:tienda/pages/otra_pagina.dart';
import 'package:tienda/pages/crear_productos.dart';
import 'package:tienda/pages/pedido_lista.dart';
import 'package:tienda/services/firebase_services.dart';
import 'package:tienda/widgets/header.dart';

void main() {
  runApp(MyApp());
}

//SHA1: 0B:68:06:01:EF:CD:34:79:59:E6:95:75:16:3C:5C:14:F0:28:52:99

/*
MD5: 8E:47:F2:33:39:C6:29:0A:A3:D6:F6:1B:42:9E:2D:75
SHA1: 0B:68:06:01:EF:CD:34:79:59:E6:95:75:16:3C:5C:14:F0:28:52:99
SHA256: 3E:B3:89:24:9D:62:42:BE:05:06:7F:74:8A:40:BB:7E:13:F6:E9:7B:40:43:31:D0:58:F1:97:C0:C5:94:18:BA
*/

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //title: 'Flutter Demo',
      theme: ThemeData(
        //primarySwatch: Colors.yellow,
        primaryColor: Colors.yellow[800],
      ),
      home: MyHomePage(title: 'RETO SAN JOSE CHAPARRAL'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ProductosModel> _productosModel = List<ProductosModel>();

  List<ProductosModel> _listaCarro = [];

  FirebaseService db = new FirebaseService();

  StreamSubscription<QuerySnapshot> productSub;

  @override
  void initState() {
    super.initState();

    _productosModel = new List();

    productSub?.cancel();
    productSub = db.getProductList().listen((QuerySnapshot snapshot) {
      final List<ProductosModel> products = snapshot.documents
          .map((documentSnapshot) =>
              ProductosModel.fromMap(documentSnapshot.data))
          .toList();

      setState(() {
        this._productosModel = products;
      });
    });
  }

  @override
  void dispose() {
    productSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16.0, top: 8.0),
              child: GestureDetector(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Icon(
                      Icons.shopping_cart,
                      size: 38,
                    ),
                    if (_listaCarro.length > 0)
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: CircleAvatar(
                          radius: 8.0,
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          child: Text(
                            _listaCarro.length.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12.0),
                          ),
                        ),
                      ),
                  ],
                ),
                onTap: () {
                  if (_listaCarro.isNotEmpty)
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Cart(_listaCarro),
                      ),
                    );
                },
              ),
            )
          ],
        ),
        drawer: Container(
          width: 170.0,
          child: Drawer(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              //color: Colors.black, //color de menu principal
              color: Colors.yellow[800],
              child: new ListView(
                padding: EdgeInsets.only(top: 30.0),
                children: <Widget>[
                  Container(
                    height: 120,
                    child: new UserAccountsDrawerHeader(
                      accountName: new Text(''),
                      accountEmail: new Text(''),
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/food1x.png'),
                        ),
                      ),
                    ),
                  ),
                  /*new Divider(),
                  new ListTile(
                    title: new Text(
                      'TIENDA',
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    ),
                    trailing: new Icon(
                      Icons.home,
                      size: 30.0,
                      color: Colors.red,
                    ),
                    onTap: () =>
                        Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => OtraPagina(),
                    )),
                  ),*/
                  /*new Divider(),
                  new ListTile(
                    title: new Text(
                      'Cupones',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: new Icon(
                      Icons.card_giftcard,
                      size: 30.0,
                      color: Colors.white,
                    ),
                    onTap: () =>
                        Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => OtraPagina(),
                    )),
                  ),*/
                  /* new Divider(),
                  new ListTile(
                    title: new Text(
                      'Tiendas',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: new Icon(
                      Icons.place,
                      size: 30.0,
                      color: Colors.white,
                    ),
                    onTap: () =>
                        Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => OtraPagina(),
                    )),
                  ),*/
                  new Divider(),
                  new ListTile(
                    title: new Text(
                      'productos',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: new Icon(
                      Icons.fastfood,
                      size: 30.0,
                      color: Colors.white,
                    ),
                    onTap: () =>
                        Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => CrearProductos(),
                    )),
                  ),
                  /*  new Divider(),
                  new ListTile(
                    title: new Text(
                      'QR Code',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: new FaIcon(
                      FontAwesomeIcons.qrcode,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    onTap: () =>
                        Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => OtraPagina(),
                    )),
                  ),*/
                  new Divider(),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    WaveClip(),
                    Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.only(left: 24, top: 48),
                        height: 170,
                        child: ListView.builder(
                          itemCount: _productosModel.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Row(
                              children: <Widget>[
                                Container(
                                  height: 300,
                                  padding: new EdgeInsets.only(
                                      left: 10.0, bottom: 10.0),
                                  child: Card(
                                    elevation: 7.0,
                                    clipBehavior: Clip.antiAlias,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(24)),
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: CachedNetworkImage(
                                          imageUrl:
                                              '${_productosModel[index].image}' +
                                                  '?alt=media',
                                          fit: BoxFit.cover,
                                          placeholder: (_, __) {
                                            return Center(
                                                child:
                                                    CupertinoActivityIndicator(
                                              radius: 15,
                                            ));
                                          }),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ))
                  ],
                ),
                Container(height: 3.0, color: Colors.grey),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                    color: Colors.grey[300],
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: GridView.builder(
                      padding: const EdgeInsets.all(4.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemCount: _productosModel.length,
                      itemBuilder: (context, index) {
                        final String imagen = _productosModel[index].image;
                        var item = _productosModel[index];
                        return InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => ImageScreen(
                                url: '${_productosModel[index].image}' +
                                    '?alt=media',
                              ),
                            ),
                          ),
                          child: Expanded(
                            child: CachedNetworkImage(
                              imageUrl: '${_productosModel[index].image}' +
                                  '?alt=media',
                              fit: BoxFit.cover,
                              placeholder: (_, __) {
                                return Center(
                                  child: CupertinoActivityIndicator(
                                    radius: 15,
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    )),
              ],
            ),
          )),
        ));
  }
}
