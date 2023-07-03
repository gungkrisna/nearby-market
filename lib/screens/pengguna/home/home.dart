import 'package:app/screens/authentication/authentication.dart';
import 'package:app/screens/models/authentication.dart';
import 'package:app/screens/pengguna/components/category_card.dart';
import 'package:app/screens/pengguna/nearby/nearby.dart';
import 'package:app/screens/pengguna/nearby/produk_nearby.dart';
import 'package:app/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app/screens/pengguna/nearby/produk_list.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoder/geocoder.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Produk> _resultList;
  String myEmail;
  List<Autentikasi> myAccount;
  bool isLoading;
  String myLocation = 'Mencari lokasi...';

  var rupiahIDR = new NumberFormat.currency(
    locale: "id_ID",
    symbol: "Rp. ",
  );

  @override
  void initState() {
    super.initState();
    _resultList = wholeProduct.toList();
    cekLogin();
    _myLocation();
  }

  void _myLocation() async {
    var currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    final coordinates =
        new Coordinates(currentLocation.latitude, currentLocation.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    setState(() {
      myLocation = first.addressLine;
    });
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

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        body: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            elevation: 20,
            backgroundColor: Colors.transparent,
            expandedHeight: 270,
            floating: false,
            pinned: true,
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(80),
                child: Container(
                  color: Palette.green,
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    NearbyScreen('Semua Produk', true)));
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: IgnorePointer(
                          child: TextField(
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              fontFamily: 'PTSans',
                            ),
                            decoration: InputDecoration(
                              hintText: 'Daging ayam, brokoli, sawi',
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
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding:
                                  EdgeInsets.only(top: 16, bottom: 12),
                              prefixIcon: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: SvgPicture.asset(
                                      'assets/icons/search.svg',
                                      color: Colors.black,
                                    )),
                              ),
                            ),
                          ),
                        ),
                      )),
                )),
            flexibleSpace: Container(
              color: Palette.green,
              padding: EdgeInsets.fromLTRB(
                  20, 20 + MediaQuery.of(context).padding.top, 20, 0),
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: FlatButton(
                                padding: EdgeInsets.zero,
                                shape: CircleBorder(),
                                color: Palette.white,
                                child:
                                    Icon(Icons.navigation, color: Palette.lightgreen),
                                onPressed: () => _myLocation()),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Lokasi saya",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'HelveticaLight',
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: Text(
                                    myLocation.replaceAll(',', ''),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'HelveticaLight',
                                    ),
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                  ),
                                ),
                              ])
                        ],
                      ),
                      Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: new BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Halo,",
                    style: TextStyle(
                      color: Palette.white,
                      fontSize: 32,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'HelveticaLight',
                    ),
                  ),
                  Text(
                    myAccount.first.nama,
                    style: TextStyle(
                      color: Palette.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'HelveticaLight',
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Mau masak apa hari ini?",
                    style: TextStyle(
                      color: Palette.white,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'HelveticaLight',
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "Kategori",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'HelveticaLight',
                      ),
                    ),
                  ),
                  GridView(
                    padding: EdgeInsets.all(20),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      NearbyScreen('Daging Ayam', false)));
                        },
                        child: CategoryCard(
                            category: 'Daging Ayam',
                            image: 'assets/images/Ayam icon.png'),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      NearbyScreen('Daging Sapi', false)));
                        },
                        child: CategoryCard(
                            category: 'Daging Sapi',
                            image: 'assets/images/Daging icon.png'),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      NearbyScreen('Aneka Ikan', false)));
                        },
                        child: CategoryCard(
                            category: 'Aneka Ikan',
                            image: 'assets/images/Ikan icon.png'),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      NearbyScreen('Sayuran', false)));
                        },
                        child: CategoryCard(
                            category: 'Sayuran',
                            image: 'assets/images/icon sayur sayuran.png'),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      NearbyScreen('Buah', false)));
                        },
                        child: CategoryCard(
                            category: 'Buah',
                            image: 'assets/images/Buah icon.png'),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      NearbyScreen('Aneka Bumbu', false)));
                        },
                        child: CategoryCard(
                            category: 'Aneka Bumbu',
                            image: 'assets/images/Anekah Bumbu icon.png'),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      NearbyScreen('Sembako', false)));
                        },
                        child: CategoryCard(
                            category: 'Sembako',
                            image: 'assets/images/Sembako icon.png'),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      NearbyScreen('Siap Santap', false)));
                        },
                        child: CategoryCard(
                            category: 'Siap Santap',
                            image: 'assets/images/Siap Santap Icon.png'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "Produk Pilihan",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'HelveticaLight',
                      ),
                    ),
                  ),
                  Container(
                    height: 300.0,
                    child: new ListView.builder(
                        padding: EdgeInsets.all(20),
                        scrollDirection: Axis.horizontal,
                        itemCount: 6,
                        itemBuilder: (BuildContext context, int index) {
                          return _produkList(index);
                        }),
                  ),
                  SizedBox(
                    height: 50,
                  )
                ]),
          ),
        ]),
      ),
    );
  }

  _produkList(index) {
    return Padding(
      padding: index != 7 ? EdgeInsets.only(right: 10) : EdgeInsets.zero,
      child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => ProdukNearbyScreen(
                        _resultList[index].idproduk,
                        _resultList[index].nama,
                        _resultList[index].gambar,
                        _resultList[index].harga,
                        index)));
          },
          child: Container(
            width: 180,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                        width: 180,
                        child: Hero(
                            tag: index,
                            child: Image.network(
                              _resultList[index].gambar,
                              fit: BoxFit.cover,
                            ))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _resultList[index].nama,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'HelveticaLight',
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Mulai dari",
                        style: TextStyle(
                          color: Palette.green,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'HelveticaLight',
                        ),
                      ),
                      Text(
                        rupiahIDR.format(_resultList[index].harga -
                            _resultList[index].harga * 0.1),
                        style: TextStyle(
                          color: Palette.darkgreen,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Helvetica',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
