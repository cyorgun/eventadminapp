
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:evente_mobile_admin_app/Screen/Login_Screen.dart';
import 'package:evente_mobile_admin_app/Screen/tab/Create_Event_Screen.dart';
import 'package:evente_mobile_admin_app/Screen/tab/Dashboard.dart';
import 'package:evente_mobile_admin_app/Screen/tab/Event_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '../../../base/appBar/bar.dart';
// import '../../../base/appBar/item.dart';
import '../../../base/color_data.dart';
import '../../../base/constant.dart';
import '../../../base/widget_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void backClick() {
    Constant.closeApp();
  }

  @override
  void initState() {
    // TODO: implement initState
    getFromSharedPreferences();
    super.initState();
  }

  void getFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      role = prefs.getString("role");
    });
  }

  String? role;

  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Widget> _widgetOptions = [
     Dashboard(),
    CreateEventScreen(),
     EventScreen(),
    //  AddNotificationScreen(),
    //  DataMapScreen()
  ];

  @override
  Widget build(BuildContext context) {
    
    setStatusBarColor(Colors.white);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        bottomNavigationBar: _buildBottomBar(),
        body: _widgetOptions[_currentIndex]);
  }

  Widget _buildBottomBar() {
    return ConvexAppBar(
      items: [
        TabItem(
            icon: getSvg("home.svg", height: 24  , width: 24  ),
            activeIcon: getSvg("home2.svg",
                height: 24  , width: 24  , color: accentColor)),
        TabItem(
             icon: Icon(Icons.add, size: 50  , color: Colors.white70),
            activeIcon:  Icon(Icons.add, size: 50  , color: Colors.white),),
        TabItem(
               icon:  Icon(Icons.assistant_outlined, size: 26  , color: Colors.black54),
            activeIcon: Icon(Icons.assistant, size: 26  , color: accentColor),),
        // TabItem(
        //      icon: getSvg("home.svg", height: 24  , width: 24  ),
        //     activeIcon: getSvg("home2.svg",
        //         height: 24  , width: 24  , color: accentColor)),
        // TabItem(
        //        icon: getSvg("home.svg", height: 24  , width: 24  ),
        //     activeIcon: getSvg("home2.svg",
        //         height: 24  , width: 24  , color: accentColor)),
      ],
      height: 50  ,
      elevation: 5,
      color: accentColor,
      top: -38  ,
      curveSize: 0  ,
      activeColor: accentColor,
      style: TabStyle.fixedCircle,
      backgroundColor: Colors.white,
      initialActiveIndex: _currentIndex,
      onTap: onTabTapped,
    );
  }
}
