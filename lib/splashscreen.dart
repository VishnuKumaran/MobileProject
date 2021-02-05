import 'package:flutter/material.dart';
import 'package:dp_project/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dream Petals',
      home: Scaffold(
        backgroundColor: Colors.pink[100],
        body: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(),
            Image.asset("assets/images/logo.png",
                height: 300.0, fit: BoxFit.fill),
            Text(
              "Welcome to Deram Petals !!!",
              style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            new ProgressIndicator(),
          ],
        )),
      ),
    );
  }
}

class ProgressIndicator extends StatefulWidget {
  ProgressIndicator({Key key}) : super(key: key);

  @override
  _ProgressIndicatorState createState() => _ProgressIndicatorState();
}

class _ProgressIndicatorState extends State<ProgressIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() { 
          if (animation.value > 0.99) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext context) => Login()));
          }
        });
      });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      value: animation.value,
      valueColor: new AlwaysStoppedAnimation<Color>(Colors.pink),
    );
  }
}
