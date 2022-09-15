import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../res/icon_broken.dart';
import '../../../res/widget_shared.dart';
import '../../../view/Modules/home_screen/home_screem.dart';
import '../view/Modules/News/news.dart';
import '../view/Modules/Settings/settings.dart';

String baseUrl='https://workshop.orangedigitalcenteregypt.com/api/v1/';
String loginEndPoint='login';
String registerEndPoint='register';
String sectionsEndPoint='sections';
String examsEndPoint='exams';
String termsEndPoint='terms';
String faqEndPoint='faq';
String universityEndPoint='university';
String gradeEndPoint='grade';
String lecturesEndPoint='lectures';
String token='';
Color orangeColor=HexColor("#E8720C");


String setImage({required String url}){
  return 'assets/images/$url';
}

List<Widget>navBarScreens=[
  const HomeScreen(),
  News(),
  Settings(),
];

Color navBarActiveColorPrimary=Colors.grey.withOpacity(0.1);
Color navBarInactiveColor=CupertinoColors.black;
Color navBarActiveColorSecondary=orangeColor;
var textStyle=const TextStyle(
    fontWeight: FontWeight.bold,
);
List<BottomNavyBarItem> navBarsItems2=[
  BottomNavyBarItem(
    icon: const Icon(IconBroken.Home),
    title: myText(text: "Home",fontSize: 16,fontWeight: FontWeight.bold,color: orangeColor),
    activeColor: orangeColor,
    inactiveColor:  navBarInactiveColor,
    textAlign: TextAlign.center,
  ),
  BottomNavyBarItem(
    icon: const Icon(Icons.newspaper),
    title: const Text("News"),
    activeColor: orangeColor,
    inactiveColor:  navBarInactiveColor,
    textAlign: TextAlign.center,
  ),
  BottomNavyBarItem(
    icon: const Icon(IconBroken.Setting),
    title: const Text("Setting"),
    activeColor: orangeColor,
    inactiveColor:  navBarInactiveColor,
    textAlign: TextAlign.center,
  ),
];



