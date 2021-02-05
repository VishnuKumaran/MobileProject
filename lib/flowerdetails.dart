import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dp_project/flowerscreen.dart';
import 'package:dp_project/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'flower.dart';
import 'shop.dart';

class FlowerDetails extends StatefulWidget {
  final Shop shop;
  final Flower flower;
  final User user;

  const FlowerDetails({Key key, this.shop, this.flower, this.user}) : super(key: key);
  @override
  _FlowerDetailsState createState() => _FlowerDetailsState();
}

class _FlowerDetailsState extends State<FlowerDetails> {
  List flowerList;
  double screenWidth, screenHeight, height, width;

  String titlecenter = "Loading the flowers...";
  @override
  void initState() {
    super.initState();
    _loadFlowers();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.purple[200],
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.shop.shopname),
        backgroundColor: Colors.purple[300],
      ),
      body: Center(
        child: Column(children: [
          Container(
              height: screenHeight / 3,
              width: screenWidth / 0.7,
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl:
                    "https://jarfp.com/dreampetals/images/shopimages/${widget.shop.shopimage}.jpg",
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) => new Icon(
                  Icons.error,
                  size: screenWidth / 5,
                ),
              )),
          flowerList == null
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
                  crossAxisCount: 1,
                  childAspectRatio: (screenWidth / screenHeight) / 0.6,
                  children: List.generate(flowerList.length, (index) {
                    return Padding(
                      padding: EdgeInsets.all(45.0),
                      child: Card(
                        color: Colors.pink[100],
                        child: InkWell(
                          onTap: () => _loadFlowerdetails(index),
                          child: Column(
                            children: [
                              Container(
                                  height: screenHeight / 3,
                                  width: screenWidth / 1,
                                  child: CachedNetworkImage(
                                    fit: BoxFit.fill,
                                    imageUrl:
                                        "https://jarfp.com/dreampetals/images/flowerimages/${flowerList[index]['flowerid']}.jpg",
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
                                flowerList[index]['flowername'],
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text("RM " +
                                  flowerList[index]['flowerprice'] +
                                  ".00"),
                              Text("Balance: " +
                                  flowerList[index]['flowerqty'] +
                                  " items"),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ))
        ]),
      ),
    );
  }

  void _loadFlowers() {
    print("load data here");
    http.post("https://jarfp.com/dreampetals/php/load_flower.php", body: {
      "shopid": widget.shop.shopid,
    }).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        flowerList = null;
        setState(() {
          titlecenter = "We are sorry, Shop not Found";
        });
      } else {
        setState(() {
          var jsondata = json.decode(res.body);
          flowerList = jsondata["flower"];
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  _loadFlowerdetails(int index) {
    print(flowerList[index]['shopname']);
    Flower flower = new Flower(
        flowerid: flowerList[index]['flowerid'],
        flowername: flowerList[index]['flowername'],
        flowerprice: flowerList[index]['flowerprice'],
        flowerqty: flowerList[index]['flowerqty'],
        flowerimg: flowerList[index]['image'],
        shopid: widget.shop.shopid);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => FlowerScreen(flower: flower, shop: widget.shop, user: widget.user,)));
  }
}
