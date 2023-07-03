import 'package:app/screens/mitra/home/home.dart';
import 'package:app/screens/mitra/message/message.dart';
import 'package:app/screens/mitra/pesanan/pesanan.dart';
import 'package:app/screens/mitra/profile/profile.dart';
import 'package:flutter/material.dart';
import 'components/bottombar_component.dart';
import 'package:app/screens/mitra/models/tabIcon_model.dart';

class MitraFoundation extends StatefulWidget {
  @override
  _MitraFoundationState createState() => _MitraFoundationState();
}

class _MitraFoundationState extends State<MitraFoundation>
    with TickerProviderStateMixin {
  AnimationController animationController;

  List<TabIconDataMitra> tabIconsList = TabIconDataMitra.tabIconsList;

  Widget tabBody = Container(
    color: Colors.white,
  );

  @override
  void initState() {
    tabIconsList.forEach((TabIconDataMitra tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;
    tabBody = HomeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  tabBody,
                  bottomBar(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarComponent(
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (int index) {
            if (index == 0) {
              if (!mounted) {
                return;
              }
              setState(() {
                tabBody = HomeScreen();
              });
            } else if (index == 1) {
              if (!mounted) {
                return;
              }
              setState(() {
                tabBody = PesananScreen();
              });
            } else if (index == 2) {
              if (!mounted) {
                return;
              }
              setState(() {
                tabBody = MessageScreen();
              });
            } else if (index == 3) {
              if (!mounted) {
                return;
              }
              setState(() {
                tabBody = ProfileScreen();
              });
            }
          },
        ),
      ],
    );
  }
}
