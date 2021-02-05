import 'dart:convert';
import 'package:dp_project/flowerdetails.dart';
import 'package:dp_project/shop.dart';
import 'user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'chart.dart';

class MainScreen extends StatefulWidget {
  final User user;

  const MainScreen({Key key, this.user}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List shopList;
  double screenWidth, screenHeight, height, width;

  String titlecenter = "Loading the shops...";
  @override
  void initState() {
    super.initState();
    _loadShop();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.purple[200],
      appBar: AppBar(
        centerTitle: true,
        title: Text('Flower Shops'),
        backgroundColor: Colors.purple[300],
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {
              _addchart();
            },
          )
        ],
      ),
      body: Column(
        children: [
          shopList == null
              ? Flexible(
                  child: Container(
                      child: Center(
                          child: Text(
                  titlecenter,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ))))
              : Flexible(
                  child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: (screenWidth / screenHeight) / 0.8,
                  children: List.generate(shopList.length, (index) {
                    return Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Card(
                        color: Colors.pink[100],
                        child: InkWell(
                          onTap: () => _loadFlowers(index),
                          child: Column(
                            children: [
                              Container(
                                  height: screenHeight / 3.8,
                                  width: screenWidth / 1.2,
                                  child: CachedNetworkImage(
                                    fit: BoxFit.fill,
                                    imageUrl:
                                        "https://jarfp.com/dreampetals/images/shopimages/${shopList[index]['shopimage']}.jpg",
                                    placeholder: (context, url) =>
                                        new CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        new Icon(
                                      Icons.error,
                                      size: screenWidth / 3,
                                    ),
                                  )),
                              SizedBox(height: 10),
                              Text(
                                shopList[index]['shopname'],
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text("Tel: " + shopList[index]['shopphone']),
                              Text("Loc: " + shopList[index]['shoplocation']),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ))
        ],
      ),
    );
  }

  void _loadShop() {
    print("load data here");
    http.post("https://jarfp.com/dreampetals/php/load_shop.php", body: {
      "location": "SUNGAI PETANI",
    }).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        shopList = null;
        setState(() {
          titlecenter = "We are sorry, Shop not Found";
        });
      } else {
        setState(() {
          var jsondata = json.decode(res.body);
          shopList = jsondata["shop"];
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  _loadFlowers(int index) {
    print(shopList[index]['shopname']);
    Shop shop = new Shop(
      shopid: shopList[index]['shopid'],
      shopname: shopList[index]['shopname'],
      shopphone: shopList[index]['shopphone'],
      shoplocation: shopList[index]['shoplocation'],
      shopimage: shopList[index]['shopimage'],
    );
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => FlowerDetails(shop: shop,user: widget.user,)));

  }

  void _addchart() {
     Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => ChartScreen(
                  user:widget.user,
                )));
  }
}
