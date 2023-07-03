import 'package:app/screens/pengguna/message/message_depth.dart';
import "package:flutter/material.dart";
import 'package:app/themes/styles.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'addtocard_model.dart';
import 'package:app/screens/pengguna/cart/cart.dart';

String kGoogleApiKey = 'AIzaSyBjK6yC3p6eci95AxuJcUJX587IvyOj884';
final places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class ProdukNearbyScreen extends StatefulWidget {
  final int idproduk;
  final String nama;
  final String gambar;
  final int harga;
  final int index;

  ProdukNearbyScreen(
      this.idproduk, this.nama, this.gambar, this.harga, this.index);
  @override
  _ProdukNearbyScreenState createState() => _ProdukNearbyScreenState();
}

class _ProdukNearbyScreenState extends State<ProdukNearbyScreen>
    with SingleTickerProviderStateMixin {
  AnimationController colorAppBarAnimationController;
  Animation _colorTween, colorAppBarWidgetTween;
  var rupiahIDR = new NumberFormat.currency(
    locale: "id_ID",
    symbol: "Rp. ",
  );
  List<Pasar> nearbyPasar = [];
  bool isLoading = true;
  String kategori = 'pasar';
  int selected;

  @override
  void initState() {
    super.initState();
    colorAppBarAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));
    _colorTween = ColorTween(begin: Colors.transparent, end: Palette.green)
        .animate(colorAppBarAnimationController);
    colorAppBarWidgetTween = ColorTween(begin: Colors.white, end: Colors.white)
        .animate(colorAppBarAnimationController);
    _getLocation('pasar');
  }

  void _getLocation(keyword) async {
    setState(() {
      isLoading = true;
    });
    var currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    _getPasarList(
        Location(currentLocation.latitude, currentLocation.longitude), keyword);
  }

  /* int cekIsiSelectedKeranjang(namaproduk, nama) {
    final updateKeranjang = keranjang.firstWhere(
        (element) =>
            element.namaproduk == namaproduk && element.penjual == nama,
        orElse: () => null);
    if (updateKeranjang != null) {
      return updateKeranjang.jumlah;
    } else
      return 0;
  } */

  void _getPasarList(location, keyword) async {
    int length = nearbyPasar
        .where((element) => element.merchantCategories
            .toLowerCase()
            .contains(keyword.toLowerCase()))
        .length;
    if (length == 0) {
      PlacesSearchResponse res = await places.searchNearbyWithRadius(
        location,
        1000,
        keyword: keyword,
      );

      if (res.isOkay) {
        res.results.forEach((element) async {
          nearbyPasar.add(Pasar(
            merchantCategories: keyword,
            merchantName: element.name,
            merchantAddress: element.vicinity,
            merchantPicture: element.photos[0].photoReference,
            hargaProduk: (widget.harga -
                    (widget.harga *
                        (Random().nextInt(10) + 1) /
                        (Random().nextInt(200) + 70)))
                .toInt(),
            locationCoords: Location(
                element.geometry.location.lat, element.geometry.location.lng),
          ));
        });
      } else {
        print(res.errorMessage);
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  bool _scrollListener(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.axis == Axis.vertical) {
      colorAppBarAnimationController.animateTo(scrollInfo.metrics.pixels / 350);
      return true;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: _scrollListener,
            child: Container(
              height: double.infinity,
              child: Stack(
                children: <Widget>[
                  getProdukNearby(),
                  Container(
                    height: 80,
                    child: AnimatedBuilder(
                      animation: colorAppBarAnimationController,
                      builder: (context, child) => AppBar(
                        backgroundColor: _colorTween.value,
                        elevation: 0,
                        titleSpacing: 0.0,
                        iconTheme: IconThemeData(
                          color: colorAppBarWidgetTween.value,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: keranjang
                    .where((element) => element.namaproduk == widget.nama)
                    .toList()
                    .isNotEmpty
                ? true
                : false,
            child: Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SizedBox(
                  width: double.maxFinite,
                  child: FlatButton(
                      padding: EdgeInsets.all(16),
                      onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => CartScreen())),
                      color: Palette.green,
                      child: Text("LIHAT ORDER",
                          style: TextStyle(
                            color: Palette.white,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Helvetica',
                          ))),
                )),
          ),
        ],
      ),
    );
  }

  Widget getProdukNearby() {
    return SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          Hero(
            tag: widget.index,
            child: ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                ).createShader(Rect.fromLTRB(0, 0, rect.width,
                    rect.height + MediaQuery.of(context).size.height * 2));
              },
              blendMode: BlendMode.darken,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: Image.network(
                  widget.gambar,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.nama,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Helvetica',
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    rupiahIDR.format(widget.harga - widget.harga * 0.1),
                    style: TextStyle(
                      color: Palette.darkgreen,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Helvetica',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  keranjang
                          .where((element) => element.namaproduk == widget.nama)
                          .toList()
                          .isNotEmpty
                      ? Text(
                          "PENJUAL TERPILIH",
                          style: TextStyle(
                            color: Palette.green,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Helvetica',
                          ),
                        )
                      : Container(),
                  keranjang
                          .where((element) => element.namaproduk == widget.nama)
                          .toList()
                          .isNotEmpty
                      ? ListView.builder(
                          padding: EdgeInsets.only(top: 8, bottom: 20),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 1,
                          itemBuilder: (BuildContext context, int index) {
                            return penjualTerpilih(index);
                          })
                      : Container(),
                  GestureDetector(
                    onTap: () {
                      _filterPlaces(context);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          kategori.toUpperCase() + " TERDEKAT",
                          style: TextStyle(
                            color: Palette.brown,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Helvetica',
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Palette.brown.withOpacity(0.6),
                        ),
                      ],
                    ),
                  ),
                  isLoading
                      ? Container(
                          color: Colors.grey[200],
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          child: Center(
                              child: Container(
                                  color: Colors.grey[200],
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Palette.green),
                                  ))),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.only(top: 8),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: nearbyPasar.length,
                          itemBuilder: (BuildContext context, int index) {
                            return _nearbyPasarList(index);
                          }),
                ],
              )),
          Visibility(
              visible: keranjang
                      .where((element) => element.namaproduk == widget.nama)
                      .toList()
                      .isNotEmpty
                  ? true
                  : false,
              child: SizedBox(
                height: 50,
              )),
        ]));
  }

  String buildPhotoURL(String photoReference) {
    return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoReference&key=$kGoogleApiKey";
  }

  penjualTerpilih(index) {
    return GestureDetector(
      onTap: () {
        _actionButton(
          context,
          index,
          keranjang
              .where((element) => element.namaproduk == widget.nama)
              .toList()[index]
              .penjual,
          keranjang
              .where((element) => element.namaproduk == widget.nama)
              .toList()[index]
              .fotopenjual,
          keranjang
              .where((element) => element.namaproduk == widget.nama)
              .toList()[index]
              .alamat,
          keranjang
              .where((element) => element.namaproduk == widget.nama)
              .toList()[index]
              .namaproduk,
          keranjang
              .where((element) => element.namaproduk == widget.nama)
              .toList()[index]
              .hargaproduk,
          widget.gambar,
          true,
        );
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 8),
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
                child: keranjang
                            .where(
                                (element) => element.namaproduk == widget.nama)
                            .toList()[index]
                            .fotopenjual !=
                        null
                    ? ClipRRect(
                        child: AspectRatio(
                          aspectRatio: 1 / 1,
                          child: Container(
                            color: Colors.black,
                            child: Image.network(
                              keranjang
                                  .where((element) =>
                                      element.namaproduk == widget.nama)
                                  .toList()[index]
                                  .fotopenjual,
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
                        keranjang
                            .where(
                                (element) => element.namaproduk == widget.nama)
                            .toList()[index]
                            .namaproduk,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      keranjang
                                  .where((element) =>
                                      element.namaproduk == widget.nama)
                                  .toList()[index]
                                  .penjual !=
                              null
                          ? Text(
                              keranjang
                                  .where((element) =>
                                      element.namaproduk == widget.nama)
                                  .toList()[index]
                                  .penjual,
                              maxLines: 1,
                              softWrap: true,
                            )
                          : Container(),
                      Text(
                        /*   keranjang.where((element) => element.namaproduk == widget.nama).toList().length < 1
                            ? rupiahIDR
                                    .format(widget.harga - widget.harga * 0.1) +
                                "/pc"
                            : index == 1
                                ? rupiahIDR.format(
                                        widget.harga - widget.harga * 0.1) +
                                    "/pc"
                                : rupiahIDR.format(widget.harga -
                                        (widget.harga *
                                            index /
                                            (Random().nextInt(200) + 70))) +
                                    "/pc",
                                    */
                        rupiahIDR.format(keranjang
                            .where(
                                (element) => element.namaproduk == widget.nama)
                            .toList()[index]
                            .hargaproduk),
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
    );
  }

  _nearbyPasarList(index) {
    return GestureDetector(
      onTap: () {
        _actionButton(
            context,
            index,
            nearbyPasar[index].merchantName,
            buildPhotoURL(nearbyPasar[index].merchantPicture),
            nearbyPasar[index].merchantAddress,
            widget.nama,
            nearbyPasar[index].hargaProduk,
            widget.gambar,
            false);
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 8),
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
                child: nearbyPasar[index].merchantPicture != null
                    ? ClipRRect(
                        child: AspectRatio(
                          aspectRatio: 1 / 1,
                          child: Container(
                            color: Colors.black,
                            child: Image.network(
                              buildPhotoURL(nearbyPasar[index].merchantPicture),
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
                        nearbyPasar[index].merchantName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      nearbyPasar[index].merchantAddress != null
                          ? Text(
                              nearbyPasar[index].merchantAddress,
                              maxLines: 1,
                              softWrap: true,
                            )
                          : Container(),
                      Text(
                        /* nearbyPasar.length < 1
                            ? rupiahIDR
                                    .format(widget.harga - widget.harga * 0.1) +
                                "/pc"
                            : index == 1
                                ? rupiahIDR.format(
                                        widget.harga - widget.harga * 0.1) +
                                    "/pc"
                                : rupiahIDR.format(widget.harga -
                                        (widget.harga *
                                            index /
                                            (Random().nextInt(200) + 70))) +
                                    "/pc", */
                        rupiahIDR.format(nearbyPasar[index].hargaProduk),
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
    );
  }

  void _filterPlaces(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    title: Text(
                      'Pasar',
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      nearbyPasar.clear();
                      _getLocation('pasar');
                      setState(() {
                        kategori = 'pasar';
                      });
                    }),
                ListTile(
                    title: Text(
                      'Minimarket',
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      nearbyPasar.clear();
                      _getLocation('minimarket');
                      setState(() {
                        kategori = 'minimarket';
                      });
                    }),
                ListTile(
                    title: Text(
                      'Swalayan',
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      nearbyPasar.clear();
                      _getLocation('swalayan');
                      setState(() {
                        kategori = 'swalayan';
                      });
                    }),
              ],
            ),
          );
        });
  }

  void _actionButton(context, index, nama, photo, alamat, namaproduk,
      hargaproduk, gambarproduk, isSelected) {
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
                isSelected
                    ? ListTile(
                        title: Text(
                          keranjang
                                      .where((element) =>
                                          element.namaproduk == widget.nama)
                                      .toList() ==
                                  null
                              ? 'Tambah ke keranjang'
                              : 'Hapus dari keranjang',
                        ),
                        onTap: () {
                          _aturProduk(
                              index,
                              widget.idproduk.toString(),
                              photo,
                              alamat,
                              nama,
                              namaproduk,
                              hargaproduk,
                              gambarproduk,
                              false);
                        },
                        trailing: Icon(Icons.arrow_forward_ios),
                      )
                    : ListTile(
                        title: Text('Tambah ke keranjang'),
                        onTap: () {
                          _aturProduk(
                              index,
                              widget.idproduk.toString(),
                              photo,
                              alamat,
                              nama,
                              namaproduk,
                              hargaproduk,
                              gambarproduk,
                              true);
                        },
                        trailing: Icon(Icons.arrow_forward_ios),
                      )
              ],
            ),
          );
        });
  }

  _aturProduk(
      int index,
      String id,
      String fotopenjual,
      String alamat,
      String nama,
      String namaproduk,
      int hargaproduk,
      String gambarproduk,
      bool forced) {
    // cek apakah sudah ada di keranjang dgn id dari function ini
    final cekKeranjang = keranjang
        .firstWhere((element) => element.id.contains(id), orElse: () => null);
    // jika tidak ada, tambah ke keranjang
    if (cekKeranjang == null) {
      keranjang.add(Keranjang(
          id: id,
          namaproduk: namaproduk,
          hargaproduk: hargaproduk,
          penjual: nama,
          fotopenjual: fotopenjual,
          alamat: alamat,
          gambarproduk: gambarproduk,
          jumlah: 1));
      setState(() {
        selected = index;
      });
    }
    if (forced) {
      //hapus id karena sudah ada
      keranjang.removeWhere((element) => element.id == id);
      //ganti id ini
      keranjang.add(Keranjang(
          id: id,
          namaproduk: namaproduk,
          hargaproduk: hargaproduk,
          penjual: nama,
          fotopenjual: fotopenjual,
          alamat: alamat,
          gambarproduk: gambarproduk,
          jumlah: 1));
      setState(() {
        selected = index;
      });
    } else {
      //hapus produk karena sudah ada
      keranjang.removeWhere((element) => element.id == id);
      setState(() {
        selected = null;
      });
    }
    Navigator.pop(context);
  }
}

class Pasar {
  String merchantCategories;
  String merchantName;
  String merchantAddress;
  String merchantPicture;
  int hargaProduk;
  Location locationCoords;

  Pasar(
      {this.merchantName,
      this.merchantCategories,
      this.merchantAddress,
      this.hargaProduk,
      this.merchantPicture,
      this.locationCoords});
}
