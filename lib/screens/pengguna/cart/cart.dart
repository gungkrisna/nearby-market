import 'package:app/screens/pengguna/message/message_depth.dart';
import 'package:badges/badges.dart';
import "package:flutter/material.dart";
import 'package:app/themes/styles.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:intl/intl.dart';
import 'package:app/screens/pengguna/nearby/addtocard_model.dart';

String kGoogleApiKey = 'AIzaSyBjK6yC3p6eci95AxuJcUJX587IvyOj884';
final places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var rupiahIDR = new NumberFormat.currency(
    locale: "id_ID",
    symbol: "Rp. ",
  );
  String kategori = 'pasar';
  String myLocation = 'Mencari lokasi...';
  int totalHarga;

  @override
  void initState() {
    super.initState();
    areYouOkay();
    _myLocation();
    _hitungHarga();
  }

  void areYouOkay() {
    if (keranjang.length == 0) {
      Navigator.pop(context);
    }
  }

  void _hitungHarga() {
    var sum = [];
    if (keranjang.isNotEmpty) {
      keranjang.forEach((element) {
        sum.add(element.hargaproduk * element.jumlah);
      });
      setState(() {
        totalHarga = sum.fold(0, (prev, element) => prev + element);
      });
    } else
      Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Palette.green,
        title: Text(
          'Keranjang',
          style: TextStyle(color: Palette.white),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            child: getProdukNearby(),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                width: double.maxFinite,
                child: FlatButton(
                    padding: EdgeInsets.all(16),
                    onPressed: () {},
                    color: Palette.green,
                    child: Text("ORDER",
                        style: TextStyle(
                          color: Palette.white,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Helvetica',
                        ))),
              )),
        ],
      ),
    );
  }

  Widget getProdukNearby() {
    return SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => {},
                    child: Container(
                      padding: EdgeInsets.only(right:10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.white,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            FlatButton(
                                padding: EdgeInsets.zero,
                                shape: CircleBorder(),
                                color: Palette.green,
                                child:
                                    Icon(Icons.navigation, color: Colors.white),
                                onPressed: () => _myLocation()),
                            Expanded(
                              child: TextFormField(
                                textAlignVertical: TextAlignVertical.center,
                                maxLines: 3,
                                initialValue: myLocation,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  fontFamily: 'PTSans',
                                ),
                                decoration: InputDecoration(
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
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    ' PRODUK',
                    style: TextStyle(
                      color: Palette.brown.withOpacity(0.7),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Helvetica',
                    ),
                  ),
                  ListView.builder(
                      padding: EdgeInsets.only(top: 5, bottom: 20),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: keranjang.length,
                      itemBuilder: (BuildContext context, int index) {
                        return penjualTerpilih(index);
                      }),
                  Text(
                    ' DETAIL PEMBAYARAN',
                    style: TextStyle(
                      color: Palette.brown.withOpacity(0.7),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Helvetica',
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.white,
                      ),
                      child: Column(children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text('Harga (estimasi)'),
                              Text(rupiahIDR.format(totalHarga)),
                            ]),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text('Biaya pengiriman'),
                              Text('Rp. 15.000,00'),
                            ]),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Total pembayaran',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                rupiahIDR.format(totalHarga + 15000),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ]),
                      ]))
                ],
              )),
          SizedBox(
            height: 50,
          )
        ]));
  }

  String buildPhotoURL(String photoReference) {
    return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoReference&key=$kGoogleApiKey";
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

  penjualTerpilih(index) {
    return GestureDetector(
      onTap: () {
        _actionButton(
          context,
          keranjang[index].id,
          keranjang[index].penjual,
          keranjang[index].fotopenjual,
          keranjang[index].namaproduk,
          keranjang[index].hargaproduk,
        );
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: Badge(
          badgeColor: Palette.green,
          badgeContent: Text(
            keranjang[index].jumlah.toString(),
            style: TextStyle(color: Colors.white),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.white,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: keranjang[index].gambarproduk != null
                      ? ClipRRect(
                          child: AspectRatio(
                            aspectRatio: 1 / 1,
                            child: Container(
                              color: Colors.black,
                              child: Image.network(
                                keranjang[index].gambarproduk,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        )
                      : Container(),
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          keranjang[index].namaproduk,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        keranjang[index].penjual != null
                            ? Text(
                                keranjang[index].penjual,
                                maxLines: 1,
                                softWrap: true,
                              )
                            : Container(),
                        Text(
                          rupiahIDR.format(keranjang[index].jumlah *
                              keranjang[index].hargaproduk),
                          style: TextStyle(
                            color: Palette.darkgreen,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Helvetica',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _actionButton(context, id, nama, photo, namaproduk, hargaproduk) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    title: Text(
                      'Kirim pesan',
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  MessageDepthScreen(
                                    nama: nama,
                                    photo: photo,
                                  )));
                    }),
                ListTile(
                    title: Text(
                      'Hapus produk',
                    ),
                    onTap: () => _hapus(id)),
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Update jumlah'),
                      Row(
                        children: <Widget>[
                          IconButton(
                              icon: Icon(
                                Icons.remove,
                              ),
                              onPressed: () => _kurang(id)),
                          IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () => _tambah(id))
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  _hapus(String id) {
    setState(() {
      keranjang.removeWhere((element) => element.id.contains(id));
    });
    Navigator.pop(context);
    areYouOkay();
    _hitungHarga();
  }

  _tambah(String id) {
    var cart = keranjang.firstWhere((element) => element.id.contains(id));
    setState(() {
      cart.jumlah = cart.jumlah + int.parse('1');
    });
    _hitungHarga();
  }

  _kurang(String id) {
    var cart = keranjang.firstWhere((element) => element.id.contains(id));
    setState(() {
      cart.jumlah = cart.jumlah != 1 ? cart.jumlah - 1 : 1;
    });
    _hitungHarga();
  }
}
