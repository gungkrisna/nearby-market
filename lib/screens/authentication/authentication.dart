import 'package:app/screens/mitra/foundation.dart';
import 'package:app/screens/pengguna/foundation.dart';
import 'package:app/themes/styles.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:app/screens/models/authentication.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void initState() {
    super.initState();
    cekLogin();
  }

  void cekLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String myEmail = prefs.getString('email');
    var cekAkun = autentikasi.firstWhere((element) => element.email == myEmail,
        orElse: () => null);
    if (myEmail != null && cekAkun.status == 'PENGGUNA') {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return PenggunaFoundation();
      }));
    } else if (myEmail != null && cekAkun.status == 'PEDAGANG') {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return MitraFoundation();
      })); 
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Palette.white,
        body: LayoutBuilder(builder: (context, constraint) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraint.maxHeight,
              ),
              child: IntrinsicHeight(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                    SizedBox(
                      height: 20 + MediaQuery.of(context).padding.top,
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: new BoxDecoration(
                            color: Palette.green,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(6, 5, 10, 2),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Image.asset(
                                  'assets/images/compass_arrow_light.png'),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "NearbyMarket",
                          style: TextStyle(
                            color: Palette.green,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Helvetica',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.width * 0.7,
                              child: Image(
                                image: AssetImage(
                                    'assets/images/auth_illustration.png'),
                              ),
                            ),
                          ),
                          Text(
                            "Autentikasi",
                            style: TextStyle(
                              color: Palette.green,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Helvetica',
                            ),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            cursorColor: Palette.green,
                            controller: emailController,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              fontFamily: 'PTSans',
                            ),
                            decoration: InputDecoration(
                              hintText: 'E-mail',
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                fontFamily: 'PTSans',
                              ),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  )),
                              fillColor: Colors.grey[200],
                              filled: true,
                              prefixIcon: Icon(
                                Icons.email,
                                color: Palette.green,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            cursorColor: Palette.green,
                            controller: passwordController,
                            obscureText: true,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              fontFamily: 'PTSans',
                            ),
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                fontFamily: 'PTSans',
                              ),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  )),
                              fillColor: Colors.grey[200],
                              filled: true,
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Palette.green,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: FlatButton(
                                padding: EdgeInsets.all(20),
                                onPressed: () => _login(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    context: context),
                                color: Palette.green,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(style: BorderStyle.none),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  "Masuk",
                                  style: TextStyle(
                                    color: Palette.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Helvetica',
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ])),
            ),
          );
        }),
      ),
    );
  }

  void _login({String email, String password, BuildContext context}) async {
    var cekAkun = autentikasi.firstWhere(
        (element) => element.email == email && element.password == password,
        orElse: () => null);
    if (cekAkun != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', email);
      if (cekAkun.status == 'PENGGUNA') {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return PenggunaFoundation();
        }));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
         return MitraFoundation();
        })); 
      }
    } else {
      Flushbar(
        message: 'Kredensial tidak cocok',
        duration: Duration(milliseconds: 1500),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Color(0xFFFF5C83),
      )..show(context);
    }
  }
}
