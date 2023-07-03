import 'package:flutter/material.dart';

class TabIconDataMitra {
  TabIconDataMitra({
    this.icon,
    this.index = 0,
    this.isSelected = false,
    this.animationController,
  });

  bool isSelected;
  int index;
  String icon;

  AnimationController animationController;

  static List<TabIconDataMitra> tabIconsList = <TabIconDataMitra>[
    TabIconDataMitra(
      icon: 'assets/icons/home.svg',
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconDataMitra(
      icon: 'assets/icons/receipt.svg',
      index: 1,
      isSelected: false,
      animationController: null,
    ),
    TabIconDataMitra(
      icon: 'assets/icons/message.svg',
      index: 2,
      isSelected: false,
      animationController: null,
    ),
    TabIconDataMitra(
      icon: 'assets/icons/account_circle.svg',
      index: 3,
      isSelected: false,
      animationController: null,
    ),
  ];
}
