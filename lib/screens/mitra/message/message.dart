import 'package:app/screens/mitra/message/message_depth.dart';
import 'package:app/themes/styles.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Palette.green,
        title: Text(
          'Pesan',
          style: TextStyle(color: Palette.white),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(
            padding: EdgeInsets.only(top: 10),
            scrollDirection: Axis.vertical,
            children: <Widget>[
              ListTile(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => MessageDepthScreen(
                                nama: 'Shania',
                                photo:
                                    "https://randomuser.me/portraits/women/8.jpg",
                              ))),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://randomuser.me/portraits/women/8.jpg"),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Shania"),
                      SizedBox(
                        width: 16.0,
                      ),
                      Text(
                        "07:20",
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ],
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                      "Halo, bisa dipesan sekarang?",
                      maxLines: 2,
                      softWrap: true,
                    ),
                  )),
            ]),
      ),
    );
  }
}
