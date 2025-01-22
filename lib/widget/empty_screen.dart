import 'package:flutter/material.dart';
import '../../base/color_data.dart';
import '../../base/widget_utils.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
                  child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 
                     Container(
                              decoration: BoxDecoration(
                                  color: lightColor,
                                  borderRadius: BorderRadius.circular(187  )),
                              padding: EdgeInsets.all(27  ),
                              child: getAssetImage("onBoarding3.png",
                                   width: 214,boxFit: BoxFit.cover),
                            ),
                            getCustomFont(
                                "Item Empty", 20  , Colors.black, 1,
                                fontWeight: FontWeight.w700, txtHeight: 1.5  ),
                            getVerSpace(8  ),
                            getMultilineCustomFont(
                                "Sorry, we couldn't find any results for your item.",
                                16  ,
                                Colors.black,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.center,
                                txtHeight: 1.5  )
              ],
            ),
                );
  }
}