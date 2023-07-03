import "package:flutter/material.dart";
import 'package:app/themes/styles.dart';

class PesananScreen extends StatefulWidget {
  @override
  _PesananScreenState createState() => _PesananScreenState();
}

class _PesananScreenState extends State<PesananScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Palette.green,
        title: Text(
          'Riwayat Pesanan',
          style: TextStyle(color: Palette.white),
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: <Widget>[
            Container(
              color: Palette.green,
              constraints: BoxConstraints.expand(height: 50),
              child: TabBar(
                  indicatorColor: Palette.white,
                  labelColor: Palette.white,
                  unselectedLabelColor: Palette.white.withOpacity(0.9),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    fontFamily: 'PTSans',
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    fontFamily: 'PTSans',
                  ),
                  tabs: [
                    Tab(text: "Dalam Proses"),
                    Tab(text: "Selesai"),
                    Tab(text: "Dibatalkan"),
                  ]),
            ),
            Expanded(
              child: Container(
                child: TabBarView(children: <Widget>[
                  ListView(children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Order #478299',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Rp. 500.000',
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '12:46   Proses pengemasan',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Detail Pembelian',
                                style: TextStyle(
                                    color: Palette.green, fontSize: 14),
                              ),
                            ),
                          ]),
                    )
                  ]),
                  ListView(children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Order #832877',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Rp. 140.000',
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '12:46   Pesanan dibatalkan',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Detail Pembelian',
                                style: TextStyle(
                                    color: Palette.green, fontSize: 14),
                              ),
                            ),
                          ]),
                    )
                  ]),
                  
                  ListView(children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Order #700122',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Rp. 75.000',
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '07:00   Pesanan diterima',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Detail Pembelian',
                                style: TextStyle(
                                    color: Palette.green, fontSize: 14),
                              ),
                            ),
                          ]),
                    )
                  ]),
                  
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
