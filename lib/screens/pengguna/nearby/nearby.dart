import 'package:app/screens/pengguna/cart/cart.dart';
import "package:flutter/material.dart";
import 'package:app/themes/styles.dart';
import 'produk_list.dart';
import 'package:intl/intl.dart';
import 'produk_nearby.dart';

class NearbyScreen extends StatefulWidget {
  final String title;
  final bool triggerSearch;

  NearbyScreen(this.title, this.triggerSearch);
  @override
  _NearbyScreenState createState() => _NearbyScreenState();
}

class _NearbyScreenState extends State<NearbyScreen>
    with SingleTickerProviderStateMixin {
  List<Produk> _resultList;
  String keranjangSaya = '0';
  String _fixedQuery;
  Widget appBarTitle;
  Icon actionIcon = Icon(Icons.search, color: Colors.white);
  Widget appBarLeading;
  var rupiahIDR = new NumberFormat.currency(
    locale: "id_ID",
    symbol: "Rp. ",
  );

  void initState() {
    super.initState();
    appBarLeading = GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Icon(Icons.arrow_back),
    );
    appBarTitle = widget.triggerSearch
        ? TextField(
            autofocus: true,
            onChanged: (value) {
              value != null ? _onCategory(value) : _onCategory(widget.title);
            },
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 16,
              fontFamily: 'PTSans',
            ),
            decoration: InputDecoration(
              hintText: 'Ketik nama produk',
              hintStyle: TextStyle(
                color: Palette.white,
                fontWeight: FontWeight.normal,
                fontFamily: 'HelveticaLight',
                fontSize: 18,
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              )),
              contentPadding: EdgeInsets.all(0),
            ),
          )
        : Text(
            widget.title,
            style: TextStyle(
              color: Palette.white,
              fontWeight: FontWeight.normal,
              fontFamily: 'HelveticaLight',
              fontSize: 18,
            ),
          );
    _onCategory(widget.title);
  }

  void _onCategory(category) {
    var temp = category != 'Semua Produk'
        ? wholeProduct
            .where((element) =>
                element.kategori
                    .toLowerCase()
                    .contains(category.toLowerCase()) ||
                element.nama.toLowerCase().contains(category.toLowerCase()))
            .toList()
        : wholeProduct.toList();
    setState(() {
      _resultList = temp;
      _fixedQuery = category;
    });
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      leading: appBarLeading,
      elevation: 0,
      backgroundColor: Palette.green,
      title: appBarTitle,
      actions: <Widget>[
        new IconButton(
          icon: actionIcon,
          onPressed: () {
            setState(() {
              if (actionIcon.icon == Icons.search) {
                appBarLeading = Icon(Icons.search);
                actionIcon = Icon(Icons.close);
                appBarTitle = TextField(
                  autofocus: true,
                  onChanged: (value) {
                    value != null
                        ? _onCategory(value)
                        : _onCategory(widget.title);
                  },
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    fontFamily: 'PTSans',
                  ),
                  decoration: InputDecoration(
                    hintText: 'Ketik nama produk',
                    hintStyle: TextStyle(
                      color: Palette.white,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'HelveticaLight',
                      fontSize: 18,
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    )),
                    contentPadding: EdgeInsets.all(0),
                  ),
                );
              } else {
                appBarLeading = GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(Icons.arrow_back),
                );
                actionIcon = new Icon(Icons.search);
                appBarTitle = Text(
                  _fixedQuery != null ? _fixedQuery : widget.title,
                  style: TextStyle(
                    color: Palette.white,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'HelveticaLight',
                    fontSize: 18,
                  ),
                );
              }
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: _buildAppBar(context),
      body: Container(
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: (3 / 5)),
            physics: ScrollPhysics(),
            padding: EdgeInsets.all(10),
            itemCount: _resultList.length,
            itemBuilder: (BuildContext context, int index) {
              return _produkList(index);
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => CartScreen())),
        child: Icon(Icons.shopping_cart),
        backgroundColor: Palette.green,
      ),
    );
  }

  _produkList(index) {
    return GestureDetector(
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
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                      width: double.infinity,
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
        ));
  }
}
