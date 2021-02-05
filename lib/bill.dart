import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'user.dart';

class BillScreen extends StatefulWidget {
  final User user;
  

  const BillScreen({Key key, this.user}) : super(key: key);

  @override
  _BillScreenState createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.purple[200],
        appBar: AppBar(
          centerTitle: true,
          title: Text('Your Bill Payment'),
          backgroundColor: Colors.purple[300],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: WebView(
               
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },
              ),
            )
          ],
        ));
  }
}
