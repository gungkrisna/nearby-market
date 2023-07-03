import 'package:app/screens/authentication/authentication.dart';
import 'package:app/screens/models/authentication.dart';
import 'package:app/screens/mitra/message/message_depth.dart';
import 'package:app/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String myEmail;
  List<Autentikasi> myAccount;
  bool isLoading;

  var rupiahIDR = new NumberFormat.currency(
    locale: "id_ID",
    symbol: "Rp. ",
  );

  @override
  void initState() {
    super.initState();
    cekLogin();
  }
  
  void cekLogin() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    myEmail = prefs.getString('email');
    var cekAkun = autentikasi.firstWhere(
        (element) => element.email.contains(myEmail),
        orElse: () => null);
    if (cekAkun != null || cekAkun.status != 'PENGGUNA') {
      myAccount = [
        Autentikasi(
          email: cekAkun.email,
          password: cekAkun.password,
          nama: cekAkun.nama,
          saldo: cekAkun.saldo,
          status: cekAkun.status,
        )
      ];
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return Authentication();
      }));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading)
      return Center(
          child: Container(
              color: Colors.white,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Palette.green),
              )));

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Palette.green,
        title: Text(
          'Profil',
          style: TextStyle(color: Palette.white),
        ),
      ),
      body: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 60),
        height: MediaQuery.of(context).size.height,
        child: ListView(scrollDirection: Axis.vertical, children: <Widget>[
          Container(
            padding: EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: new BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  /* child: Padding(
                    padding: EdgeInsets.fromLTRB(6, 5, 10, 2),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child:
                          Image.asset('assets/images/compass_arrow_light.png'),
                    ),
                  ), */
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        myAccount.first.status,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'HelveticaLight',
                        ),
                      ),
                      Text(
                        myAccount.first.nama,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'HelveticaLight',
                        ),
                      ),
                    ]),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Text(
              "AKUN SAYA",
              style: TextStyle(
                color: Palette.brown.withOpacity(0.6),
                fontSize: 12,
                fontWeight: FontWeight.normal,
                fontFamily: 'Helvetica',
              ),
            ),
          ),
          ListTile(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => MessageDepthScreen())),
            title: Text("Saldo"),
            trailing: Text(rupiahIDR.format(myAccount.first.saldo),
                style: TextStyle(color: Palette.green)),
          ),
          ListTile(
              onTap: () {},
              title: Text("Deposit"),
              trailing: Icon(Icons.arrow_forward_ios)),
          ListTile(
              onTap: () {},
              title: Text("Tarik dana"),
              trailing: Icon(Icons.arrow_forward_ios)),
          ListTile(
            onTap: () {},
            title: Text("Riwayat Pesanan"),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Text(
              "UMUM",
              style: TextStyle(
                color: Palette.brown.withOpacity(0.6),
                fontSize: 12,
                fontWeight: FontWeight.normal,
                fontFamily: 'Helvetica',
              ),
            ),
          ),
          ListTile(
            onTap: () {},
            title: Text("Kebijakan Privasi"),
          ),
          ListTile(
            onTap: () {},
            title: Text("Ketentuan Layanan"),
          ),
          ListTile(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('email');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Authentication()));
            },
            title: Text("Keluar", style: TextStyle(color: Colors.red)),
          )
        ]),
      ),
    );
  }
}
