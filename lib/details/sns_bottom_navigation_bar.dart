// flutter
import 'package:flutter/material.dart';
// constants
import 'package:flutter_sns/constants/bottom_navigation_bar_elements.dart';
// model
import 'package:flutter_sns/models/sns_bottom_navigation_bar_model.dart';

class SNSBottomNavigationBar extends StatelessWidget {
  const SNSBottomNavigationBar(
      {Key? key, required this.snsBottomNavigationBarModel})
      : super(key: key);

  final SNSBottomNavigationBarModel snsBottomNavigationBarModel;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: bottomNavigationBarElements,
      currentIndex: snsBottomNavigationBarModel.currentIndex,
      onTap: (index) => snsBottomNavigationBarModel.onTabTapped(index: index),
    );
  }
}
