import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dp_project/flower.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'bill.dart';
import 'user.dart';

class ChartScreen extends StatefulWidget {
  final User user;
  final Flower flower;
  const ChartScreen({Key key, this.user, this.flower}) : super(key: key);
  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  List cartList;
  double screenWidth, screenHeight, height, width;

  String titlecenter = "Loading the cart...";
  final formatter = new NumberFormat("#,##");

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.purple[200],
      appBar: AppBar(
        centerTitle: true,
        title: Text('Your Cart Screen'),
        backgroundColor: Colors.purple[300],
      ),
      body: Column(
        children: [
          cartList == null
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
                  children: List.generate(cartList.length, (index) {
                    return Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Card(
                        color: Colors.pink[100],
                        child: InkWell(
                          //onTap: () => _loadFlowers(index),
                          child: Column(
                            children: [
                              Container(
                                  height: screenHeight / 5.0,
                                  width: screenWidth / 1.2,
                                  child: CachedNetworkImage(
                                    fit: BoxFit.fill,
                                    imageUrl:
                                        "https://jarfp.com/dreampetals/images/flowerimages/${cartList[index]['flowerid']}.jpg",
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
                                cartList[index]['shopname'],
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                cartList[index]['flowername'],
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text("Price: " +
                                  cartList[index]['flowerprice'] +
                                  ".00"),
                              Text("Quantity: " +
                                  cartList[index]['flowerqty'] +
                                  " items"),
                              Text("Total RM: " +
                                  (double.parse(
                                              cartList[index]['flowerprice']) *
                                          int.parse(
                                              cartList[index]['flowerqty']))
                                      .toStringAsFixed(2)),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                )),
          MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            minWidth: 10,
            height: 50,
            child: Text('Make Payment',style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),),
            color: Colors.purple[300],
            textColor: Colors.black,
            elevation: 15,
            onPressed: _onBill,
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }

  void _loadCart() {
    print("load data here");
    http.post("https://jarfp.com/dreampetals/php/load_cart.php", body: {
      "email": widget.user.email,
    }).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        cartList = null;
        setState(() {
          titlecenter = "We are sorry, Cart not Found";
        });
      } else {
        setState(() {
          var jsondata = json.decode(res.body);
          cartList = jsondata["cart"];
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  void _onBill() {
    
        Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => BillScreen()));
  }
}
