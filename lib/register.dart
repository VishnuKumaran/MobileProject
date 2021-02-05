import 'package:flutter/material.dart';
import 'package:dp_project/login.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _namacontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();
  final TextEditingController _passcontroller = TextEditingController();
  final TextEditingController _wordcontroller = TextEditingController();
  String _email = "";
  String _password = "";
  String _name = "";
  String _phone = "";
  bool _rememberMe = false;
  //SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink[100],
        appBar: AppBar(
          centerTitle: true,
          title: Text('User Registration'),
          backgroundColor: Colors.purple[300],
        ),
        body: new Container(
          padding: EdgeInsets.all(25),
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Center(),
              Image.asset(
                'assets/images/user.png',
                scale: 2,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                  controller: _namacontroller,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      labelText: 'Name', icon: Icon(Icons.person))),
              TextField(
                  controller: _emailcontroller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: 'Email', icon: Icon(Icons.email))),
              TextField(
                  controller: _phonecontroller,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      labelText: 'Mobile', icon: Icon(Icons.phone))),
              TextField(
                controller: _passcontroller,
                decoration: InputDecoration(
                  labelText: 'Password',
                  icon: Icon(Icons.lock),
                ),
              ),
              TextField(
                  controller: _wordcontroller,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      labelText: 'Confirm Password', icon: Icon(Icons.lock))),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                    value: _rememberMe,
                    onChanged: (bool value) {
                      _onChange(value);
                    },
                  ),
                  Text('Remember Me', style: TextStyle(fontSize: 16))
                ],
              ),
              SizedBox(height: 10),
              Wrap(
                children: [
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    minWidth: 10,
                    height: 50,
                    child: Text('Create Account'),
                    color: Colors.purple[300],
                    textColor: Colors.black,
                    elevation: 15,
                    onPressed: _onCreate,
                  ),
                  Padding(
                    padding: new EdgeInsets.all(10.0),
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    minWidth: 10,
                    height: 50,
                    child: Text('Clear'),
                    color: Colors.purple[300],
                    textColor: Colors.black,
                    elevation: 15,
                    onPressed: _onClear,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                  onTap: _onBack,
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text('Back to Login =>',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)))),
            ]),
          ),
        ));
  }

  void _onCreate() {
    _name = _namacontroller.text;
    _email = _emailcontroller.text;
    _password = _wordcontroller.text;
    _phone = _phonecontroller.text;

    http.post("https://jarfp.com/dreampetals/php/user_register.php", body: {
      "name": _name,
      "email": _email,
      "phone": _phone,
      "password": _password,
    }).then((res) {
      if (res.body == "success") {
        Toast.show(
          "Registration success",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
        );
        if (_rememberMe) {
          savepref();
                  }
                  _onLogin();
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
                  
                    void _onBack() {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (BuildContext context) => Login()));
                    }
                  
                    void _onClear() {
                      setState(() {
                        _namacontroller.clear();
                        _emailcontroller.clear();
                        _phonecontroller.clear();
                        _passcontroller.clear();
                        _wordcontroller.clear();
                      });
                    }
                  
                    void _onChange(bool value) {
                      setState(() {
                        _rememberMe = value;
                      });
                    }
                  
                    void _onLogin() {
                       Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => Login()));
                    }
          
           void savepref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _email = _emailcontroller.text;
    _password = _passcontroller.text;
    await prefs.setString('email', _email);
    await prefs.setString('password', _password);
    await prefs.setBool('rememberme', true);
  }
}
