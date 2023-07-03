import 'dart:math';
import 'dart:async';
import 'package:app/screens/authentication/authentication.dart';
import 'package:app/screens/mitra/foundation.dart';
import 'package:app/screens/models/authentication.dart';
import 'package:app/screens/pengguna/foundation.dart';
import 'package:app/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpritePainter extends CustomPainter {
  final Animation<double> _animation;

  SpritePainter(this._animation) : super(repaint: _animation);

  void circle(Canvas canvas, Rect rect, double value) {
    double opacity = (1.0 - (value / 4.0)).clamp(0.0, 1.0);
    Color color = Palette.white.withOpacity(opacity);

    double size = rect.width / 1.5;
    double area = size * size;
    double radius = sqrt(area * value / 4);

    final Paint paint = new Paint()..color = color;
    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = new Rect.fromLTRB(0.0, 0.0, size.width, size.height);

    for (int wave = 3; wave >= 0; wave--) {
      circle(canvas, rect, wave + _animation.value);
    }
  }

  @override
  bool shouldRepaint(SpritePainter oldDelegate) {
    return true;
  }
}

class SpriteDemo extends StatefulWidget {
  @override
  SpriteDemoState createState() => new SpriteDemoState();
}

class SpriteDemoState extends State<SpriteDemo>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
    );
    _startAnimation();
    Future.delayed(Duration(seconds: 3), () => cekLogin());
  }

  cekLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String myEmail = prefs.getString('email');
    if (myEmail != null) {
      var cekAkun = autentikasi.firstWhere(
          (element) => element.email.contains(myEmail),
          orElse: () => null);
      if (cekAkun != null && cekAkun.status == 'PENGGUNA') {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return PenggunaFoundation();
        }));
      } else if (cekAkun != null && cekAkun.status == 'PEDAGANG') {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return MitraFoundation();
        }));
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Authentication(),
          ),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Authentication(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller.stop();
    _controller.reset();
    _controller.repeat(
      period: Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.green,
      body: Container(
          padding: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: CustomPaint(
                painter: SpritePainter(_controller),
                child: SizedBox(
                  width: 200.0,
                  height: 200.0,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 170.0,
                height: 170.0,
                decoration: new BoxDecoration(
                  color: Palette.white,
                  shape: BoxShape.circle,
                ),
                child: Image.asset('assets/images/logo.png'),
              ),
            ),
            Positioned.fill(
              top: MediaQuery.of(context).size.height * 0.65,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "NearbyMarket",
                      style: TextStyle(
                        color: Palette.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Helvetica',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      "One Stop Market Solutions",
                      style: TextStyle(
                        color: Palette.white,
                        fontSize: 12,
                        fontFamily: 'HelveticaLight',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ]),
            ),
          ])),
    );
  }
}

void main() {
  runApp(
    new MaterialApp(
      home: new SpriteDemo(),
    ),
  );
}
