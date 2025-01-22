// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:evente_mobile_admin_app/Screen/Home_Screen.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import 'Login_Screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    afterSplash();
    // _getIsFirst();
  }
afterSplash(){
 
    Future.delayed(Duration(milliseconds: 2500)).then((value){
    gotoSignInPage();
    });
  }


  gotoSignInPage () {
       Navigator.of(context).pushReplacement(PageRouteBuilder(pageBuilder: (_,__,___)=>new HomeScreen()));
  }


  Future<PackageInfo> _getPackageInfo() {
    return PackageInfo.fromPlatform();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Stack(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 270.0,
                  height: 100.0,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/logoSplash.png'),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 60.0,left: 100),
                  child: Container(
                    height: 35.0,
                    width: 200.0,
                    color: Colors.white,
                    child: const Text("Admin Version",style: TextStyle(fontFamily: "Sofia",fontSize: 20.0,fontWeight: FontWeight.w600),)))
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height:300.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          FutureBuilder<PackageInfo>(
              future: _getPackageInfo(),
              builder: (context, snapshot) {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 300.0,
                    height: 45 * 2,
                    child: Center(
                      child: Text(
                        'Version ${snapshot.data?.version ?? ''}',
                      ),
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}
