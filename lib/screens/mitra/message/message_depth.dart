import 'package:app/themes/styles.dart';
import 'package:flutter/material.dart';

class MessageDepthScreen extends StatefulWidget {
  MessageDepthScreen({Key key, this.nama, this.photo}) : super(key: key);

  final String nama;
  final String photo;

  @override
  _MessageDepthScreen createState() => new _MessageDepthScreen();
}

class _MessageDepthScreen extends State<MessageDepthScreen> {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();
  String hintText = 'Ketik pesan';

  @override
  void initState() {
    _handleInit("Halo, bisa dipesan sekarang?");
    super.initState();
  }

  void _handleInit(String text) {
    ChatMessage message = new ChatMessage(
        text: text,
        name: widget.nama,
        photo: widget.photo,
        type: false,
        widget: true);
    setState(() {
      _messages.insert(0, message);
    });
  }

  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
        child: new Column(children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                width: 20,
              ),
              new Flexible(
                child: new TextField(
                  controller: _textController,
                  onSubmitted: _handleSubmitted,
                  decoration: new InputDecoration.collapsed(hintText: hintText),
                ),
              ),
              Material(
                color: Colors.white,
                child: InkWell(
                  child: Container(
                      margin: new EdgeInsets.all(7),
                      child: IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Palette.green,
                          ),
                          onPressed: () =>
                              _handleSubmitted(_textController.text))),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = new ChatMessage(
      text: text,
      type: true,
      widget: false,
    );
    setState(() {
      _messages.insert(0, message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(
          widget.nama,
          style: TextStyle(fontSize: 15),
        ),
        backgroundColor: Palette.green,
      ),
      body: new Column(children: <Widget>[
        new Flexible(
            child: new ListView.builder(
          padding: new EdgeInsets.all(8.0),
          reverse: true,
          itemBuilder: (_, int index) => _messages[index],
          itemCount: _messages.length,
        )),
        new Divider(height: 1.0),
        new Container(
          decoration: new BoxDecoration(color: Colors.white),
          child: _buildTextComposer(),
        ),
      ]),
    );
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.name, this.type, this.photo, this.widget});

  final String text;
  final String name;
  final String photo;
  final bool type;
  final bool widget;

  List<Widget> otherMessage(context) {
    return <Widget>[
      new Container(
        margin: const EdgeInsets.only(right: 10.0, left: 5),
        child: new CircleAvatar(
          backgroundImage: NetworkImage(photo),
        ),
      ),
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(name, style: new TextStyle(fontWeight: FontWeight.bold)),
            this.widget
                ? Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * .6),
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            text,
                            style: TextStyle(
                              fontFamily: 'HelveticaLight',
                              fontWeight: FontWeight.w100,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * .6),
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                      ),
                      child: new Text(
                        text,
                        style: TextStyle(
                          fontFamily: 'HelveticaLight',
                          fontWeight: FontWeight.w100,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    ];
  }

  List<Widget> myMessage(context) {
    return <Widget>[
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 5.0),
              child: Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * .6),
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Palette.green,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                ),
                child: Text(
                  text,
                  style: TextStyle(
                    fontFamily: 'HelveticaLight',
                    fontWeight: FontWeight.w100,
                    fontSize: 14,
                    color: Colors.grey[100],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.type ? myMessage(context) : otherMessage(context),
      ),
    );
  }
}
