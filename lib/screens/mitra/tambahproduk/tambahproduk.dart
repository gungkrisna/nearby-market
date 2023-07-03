import 'package:app/screens/mitra/nearby/produk_list.dart';
import 'package:app/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class TambahProdukScreen extends StatefulWidget {
  @override
  _TambahProdukScreenState createState() => _TambahProdukScreenState();
}

class _TambahProdukScreenState extends State<TambahProdukScreen> {
  List<DropdownMenuItem> produknya = [];
  String rangeHarga = '0';
  int rangeBawah;
  int rangeAtas;
  String selectedProduct = 'Semua produk';
  var rupiahIDR = new NumberFormat.currency(
    locale: "id_ID",
    symbol: "Rp. ",
  );

  @override
  void initState() {
    super.initState();
    listToSearch();
  }

  void listToSearch() {
    List theProduct = wholeProduct.toList();

    theProduct.forEach((element) {
      produknya.add(
          DropdownMenuItem(value: element.nama, child: Text(element.nama)));
    });
  }

  void cekHarga() {
    var produk = wholeProduct.firstWhere(
        (element) => element.nama == selectedProduct,
        orElse: () => null);
    if (produk != null) {
      setState(() {
        rangeHarga = rupiahIDR.format(produk.harga - produk.harga * 0.1) +
            ' - ' +
            rupiahIDR.format(produk.harga + produk.harga * 0.1);
        rangeBawah = (produk.harga - produk.harga * 0.1).toInt();
        rangeAtas = (produk.harga + produk.harga * 0.1).toInt();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Palette.green,
        title: Text(
          'Tambah Produk',
          style: TextStyle(color: Palette.white),
        ),
      ),
      body: Stack(children: <Widget>[
        Container(
          padding: EdgeInsets.all(15),
          height: MediaQuery.of(context).size.height,
          child: ListView(
              padding: EdgeInsets.only(top: 10),
              scrollDirection: Axis.vertical,
              children: <Widget>[
                SearchableDropdown.single(
                  items: produknya,
                  value: selectedProduct,
                  hint: "Pilih produk",
                  searchHint: "Pilih salah satu",
                  onChanged: (value) {
                    setState(() {
                      selectedProduct = value;
                      cekHarga();
                    });
                  },
                  isExpanded: true,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: rangeHarga,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10)),
                ),
              ]),
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              width: double.maxFinite,
              child: FlatButton(
                  padding: EdgeInsets.all(16),
                  onPressed: () => Navigator.pop(context),
                  color: Palette.green,
                  child: Text("Simpan",
                      style: TextStyle(
                        color: Palette.white,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Helvetica',
                      ))),
            )),
      ]),
    );
  }
}
