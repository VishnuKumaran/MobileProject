import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:toast/toast.dart';
import 'flower.dart';
import 'package:http/http.dart' as http;
import 'shop.dart';
import 'user.dart';

class FlowerScreen extends StatefulWidget {
  final Flower flower;
  final Shop shop; 
  final User user;
  const FlowerScreen({Key key, this.flower, this.shop, this.user}) : super(key: key);
  @override
  _FlowerScreenState createState() => _FlowerScreenState();
}

class _FlowerScreenState extends State<FlowerScreen> {
  double screenWidth, screenHeight, height, width;
  int selectedQty;
  final TextEditingController _markcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var flowerQty =
        Iterable<int>.generate(int.parse(widget.flower.flowerqty) + 1).toList();
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.pink[100],
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.flower.flowername),
          backgroundColor: Colors.purple[300],
        ),
        body: Container(
            child: Padding(
                padding: EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(children: [
                    Container(
                        height: screenHeight / 3,
                        width: screenWidth / 0.7,
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl:
                              "https://jarfp.com/dreampetals/images/flowerimages/${widget.flower.flowerid}.jpg",
                          placeholder: (context, url) =>
                              new CircularProgressIndicator(),
                          errorWidget: (context, url, error) => new Icon(
                            Icons.error,
                            size: screenWidth / 5,
                          ),
                        )),
                    SizedBox(height: 10),
                    Container(
                        height: 40,
                        child: DropdownButton(
                          hint: Text("Quantity",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          value: selectedQty,
                          onChanged: (newValue) {
                            setState(() {
                              selectedQty = newValue;
                              print(selectedQty);
                            });
                          },
                          items: flowerQty.map((selectedQty) {
                            return DropdownMenuItem(
                              child: new Text(selectedQty.toString(),
                                  style: TextStyle(color: Colors.black)),
                              value: selectedQty,
                            );
                          }).toList(),
                        )),
                        SizedBox(height: 20),
                    TextField(
                        controller: _markcontroller,
                        keyboardType: TextInputType.text,
                        maxLines: 5,
                        decoration: InputDecoration(
                          labelText: 'YOUR REMARKS SECTION',
                          border: OutlineInputBorder(),
                          icon: Icon(Icons.notes),
                        )),
                    SizedBox(height: 40),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      minWidth: 10,
                      height: 50,
                      child: Text('Confirm Order',style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),),
                      color: Colors.purple[300],
                      textColor: Colors.black,
                      elevation: 15,
                      onPressed: _onOrder,
                    ),
                  ]),
                ))));
  }

  void _onOrder() {
     http.post("https://jarfp.com/dreampetals/php/insert_order.php", body: {
      "flowerid": widget.flower.flowerid,
      "email": widget.user.email,
      "quantity": selectedQty.toString(),
      "remarks": _markcontroller.text,
      "shopid": widget.shop.shopid
    }).then((res) {
      if (res.body == "success") {
        Toast.show(
          "Order success",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
        );
      } else {
        Toast.show(
          "Registration success",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
        );
      }
    }).catchError((err) {
      print(err);
    });
      
   
  }
}
