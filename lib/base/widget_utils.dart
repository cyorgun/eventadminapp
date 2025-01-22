import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'color_data.dart';
import 'constant.dart';

Widget getVerSpace(double verSpace) {
  return SizedBox(
    height: verSpace,
  );
}

Widget getAssetImage(String image,
    {double? width,
    double? height,
    Color? color,
    BoxFit boxFit = BoxFit.contain}) {
  return Image.asset(
    Constant.assetImagePath + image,
    color: color,
    width: width,
    height: height,
    fit: boxFit,
  );
}


getColorStatusBar(Color? color) {
  return AppBar(
    backgroundColor: color,
    toolbarHeight: 0,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
        systemNavigationBarColor: color, statusBarColor: color),
  );
}

Widget getSvgImage(String image,
    {double? width,
    double? height,
    Color? color,
    BoxFit boxFit = BoxFit.contain}) {
  return SvgPicture.asset(
    Constant.assetImagePath + image,
    color: color,
    width: width,
    height: height,
    fit: boxFit,
  );
}
Widget getSvg(String image,
    {double? width,
    double? height,
    Color? color,
    BoxFit boxFit = BoxFit.contain}) {
  return SvgPicture.asset(
    Constant.assetSvgPath + image,
    color: color,
    width: width,
    height: height,
    fit: boxFit,
  );
}

Widget getPaddingWidget(EdgeInsets edgeInsets, Widget widget) {
  return Padding(
    padding: edgeInsets,
    child: widget,
  );
}

Widget getCustomFont(String text, double fontSize, Color fontColor, int maxLine,
    {String fontFamily = Constant.fontsFamily,
    TextOverflow overflow = TextOverflow.ellipsis,
    TextDecoration decoration = TextDecoration.none,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.start,
    txtHeight}) {
  return Text(
    text,
    overflow: overflow,
    style: TextStyle(
        decoration: decoration,
        fontSize: fontSize,
        fontStyle: FontStyle.normal,
        color: fontColor,
        fontFamily: fontFamily,
        height: txtHeight,
        fontWeight: fontWeight),
    maxLines: maxLine,
    softWrap: true,
    textAlign: textAlign,
  );
}

Widget getMultilineCustomFont(String text, double fontSize, Color fontColor,
    {String fontFamily = Constant.fontsFamily,
    TextOverflow overflow = TextOverflow.ellipsis,
    TextDecoration decoration = TextDecoration.none,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.start,
    txtHeight = 1.0}) {
  return Text(
    text,
    style: TextStyle(
        decoration: decoration,
        fontSize: fontSize,
        fontStyle: FontStyle.normal,
        color: fontColor,
        fontFamily: fontFamily,
        height: txtHeight,
        fontWeight: fontWeight),
    textAlign: textAlign,
  );
}

BoxDecoration getButtonDecoration(Color bgColor,
    {BorderRadius? borderRadius,
    Border? border,
    List<BoxShadow> shadow = const [],
    DecorationImage? image}) {
  return BoxDecoration(
      color: bgColor,
      borderRadius: borderRadius,
      border: border,
      boxShadow: shadow,
      image: image);
}

setStatusBarColor(Color color) {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: color));
}

Widget getDivider(Color color, double thickness) {
  return Divider(
    color: color,
    thickness: thickness,
  );
}

Widget getButton(BuildContext context, Color bgColor, String text,
    Color textColor, Function function, double fontsize,
    {bool isBorder = false,
    EdgeInsetsGeometry? insetsGeometry,
    borderColor = Colors.transparent,
    FontWeight weight = FontWeight.bold,
    bool isIcon = false,
    String? image,
    Color? imageColor,
    double? imageWidth,
    double? imageHeight,
    bool smallFont = false,
    double? buttonHeight,
    double? buttonWidth,
    List<BoxShadow> boxShadow = const [],
    EdgeInsetsGeometry? insetsGeometrypadding,
    BorderRadius? borderRadius,
    double? borderWidth}) {
  return InkWell(
    onTap: () {
      function();
    },
    child: Container(
      margin: insetsGeometry,
      padding: insetsGeometrypadding,
      width: buttonWidth,
      height: buttonHeight,
      decoration: getButtonDecoration(
        bgColor,
        borderRadius: borderRadius,
        shadow: boxShadow,
        border: (isBorder)
            ? Border.all(color: borderColor, width: borderWidth!)
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (isIcon) ? getSvgImage(image!) : getHorSpace(0),
          (isIcon) ? getHorSpace(12  ) : getHorSpace(0),
          getCustomFont(text, fontsize, textColor, 1,
              textAlign: TextAlign.center,
              fontWeight: weight,
              fontFamily: Constant.fontsFamily)
        ],
      ),
    ),
  );
}

Widget getHorSpace(double verSpace) {
  return SizedBox(
    width: verSpace,
  );
}

Widget getDefaultTextFiledWithLabel(
    BuildContext context, String s, TextEditingController textEditingController,
    {bool withSufix = false,
    bool minLines = false,
    bool isPass = false,
    bool isEnable = true,
    bool isprefix = false,
    Widget? prefix,
    double? height,
    String? suffiximage,
    Function? imagefunction,
    List<TextInputFormatter>? inputFormatters,
    FormFieldValidator<String>? validator,
    BoxConstraints? constraint,
    ValueChanged<String>? onChanged,
    double vertical = 20,
    double horizontal = 18,
    int? length,
    String obscuringCharacter = '•',
    GestureTapCallback? onTap,bool isReadonly = false}) {
  return StatefulBuilder(
    builder: (context, setState) {
      return TextFormField(
        readOnly: isReadonly,
        onTap: onTap,
        onChanged: onChanged,
        validator: validator,
        enabled: true,
        inputFormatters: inputFormatters,
        maxLines: (minLines) ? null : 1,
        controller: textEditingController,
        obscuringCharacter: obscuringCharacter,
        autofocus: false,
        obscureText: isPass,
        showCursor: true,
        cursorColor: accentColor,
        maxLength: length,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 16,
            fontFamily: Constant.fontsFamily),
        decoration: InputDecoration(
            counter: Container(),
            contentPadding: EdgeInsets.symmetric(
                vertical: vertical  , horizontal: horizontal  ),
            isDense: true,
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22  ),
                borderSide: BorderSide(color: borderColor, width: 1  )),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22  ),
                borderSide: BorderSide(color: borderColor, width: 1  )),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22  ),
                borderSide: BorderSide(color: accentColor, width: 1  )),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22  ),
                borderSide: BorderSide(color: errorColor, width: 1  )),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22  ),
                borderSide: BorderSide(color: errorColor, width: 1  )),
            errorStyle: TextStyle(
                color: errorColor,
                fontSize: 13  ,
                fontWeight: FontWeight.w500,
                height: 1.5  ,
                fontFamily: Constant.fontsFamily),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22  ),
                borderSide: BorderSide(color: borderColor, width: 1  )),
            suffixIconConstraints: BoxConstraints(
              maxHeight: 24  ,
            ),
            suffixIcon: withSufix == true
                ? GestureDetector(
                    onTap: () {
                      imagefunction;
                    },
                    child: getPaddingWidget(
                      EdgeInsets.only(right: 18  ),
                      getSvgImage(suffiximage.toString(),
                          width: 24  , height: 24  ),
                    ))
                : null,
            prefixIconConstraints: constraint,
            prefixIcon: isprefix == true ? prefix : null,
            hintText: s,
            hintStyle: TextStyle(
                color: greyColor,
                fontWeight: FontWeight.w500,
                fontSize: 16  ,
                fontFamily: Constant.fontsFamily)),
      );
    },
  );
}

Widget getCountryTextField(BuildContext context, String s,
    TextEditingController textEditingController, String code,
    {bool withprefix = false,
    bool withSufix = false,
    bool minLines = false,
    EdgeInsetsGeometry margin = EdgeInsets.zero,
    bool isPass = false,
    bool isEnable = true,
    double? height,
    String? image,
    required Function function,
    Function? imagefunction}) {
  FocusNode myFocusNode = FocusNode();
  Color color = borderColor;
  return StatefulBuilder(
    builder: (context, setState) {
      return AbsorbPointer(
        absorbing: isEnable,
        child: Focus(
          onFocusChange: (hasFocus) {
            if (hasFocus) {
              setState(() {
                color = accentColor;
                myFocusNode.canRequestFocus = true;
              });
            } else {
              setState(() {
                color = borderColor;
                myFocusNode.canRequestFocus = false;
              });
            }
          },
          child: Container(
            height: height,
            margin: margin,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: color, width: 1  ),
                borderRadius: BorderRadius.circular(22  )),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getHorSpace(20  ),
                getAssetImage(image!, width: 24  , height: 24  ),
                getHorSpace(12  ),
                getCustomFont(code, 16  , greyColor, 1,
                    fontWeight: FontWeight.w500),
                getHorSpace(5  ),
                getSvgImage("arrow_down.svg", width: 24  , height: 24  ),
                getHorSpace(12  ),
                Expanded(
                  child: TextField(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLines: (minLines) ? null : 1,
                    controller: textEditingController,
                    obscuringCharacter: "*",
                    autofocus: false,
                    focusNode: myFocusNode,
                    obscureText: isPass,
                    showCursor: false,
                    onTap: () {
                      function();
                    },
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16  ,
                        fontFamily: Constant.fontsFamily),
                    decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        hintText: s,
                        hintStyle: TextStyle(
                            color: greyColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16  ,
                            fontFamily: Constant.fontsFamily)),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget getRichText(
    String firstText,
    Color firstColor,
    FontWeight firstWeight,
    double firstSize,
    String secondText,
    Color secondColor,
    FontWeight secondWeight,
    double secondSize,
    {TextAlign textAlign = TextAlign.center,
    double? txtHeight}) {
  return RichText(
    textAlign: textAlign,
    text: TextSpan(
        text: firstText,
        style: TextStyle(
          color: firstColor,
          fontWeight: firstWeight,
          fontFamily: Constant.fontsFamily,
          fontSize: firstSize,
          height: txtHeight,
        ),
        children: [
          TextSpan(
              text: secondText,
              style: TextStyle(
                  color: secondColor,
                  fontWeight: secondWeight,
                  fontFamily: Constant.fontsFamily,
                  fontSize: secondSize,
                  height: txtHeight))
        ]),
  );
}

AppBar getToolBar(Function function, {Widget? title, bool leading = true}) {
  return AppBar(
    toolbarHeight: 73  ,
    title: title,
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    leading: leading == true
        ? getPaddingWidget(
            EdgeInsets.only(top: 26  , bottom: 23  ),
            GestureDetector(
                onTap: () {
                  function();
                },
                child:
                   Icon(Icons.arrow_back_ios_rounded,size: 24.0,color: Colors.black,)))
        : null,
  );
}

AppBar getToolBarWithIcon(Function function,
    {Widget? title, List<Widget>? action, Widget? leading}) {
  return AppBar(
    toolbarHeight: 66  ,
    title: title,
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    leading: leading,
    actions: action,
  );
}

Widget settingContainer(Function function, String title, String image) {
  return GestureDetector(
    onTap: () {
      function();
    },
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22  ),
          boxShadow: [
            BoxShadow(
                color: shadowColor, offset: const Offset(0, 8), blurRadius: 27)
          ]),
      padding: EdgeInsets.only(bottom: 3  , left: 3  , top: 3  , right: 18  ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 54  ,
                width: 54  ,
                decoration: BoxDecoration(
                    color: dividerColor,
                    borderRadius: BorderRadius.circular(22  )),
                padding: EdgeInsets.all(15  ),
                child: getSvgImage(image, width: 24  , height: 24  ,color: accentColor),
              ),
              getHorSpace(16  ),
              getCustomFont(title, 16  , Colors.black, 1,
                  fontWeight: FontWeight.w500)
            ],
          ),
          getSvgImage("arrow_right.svg", height: 24  , width: 24  )
        ],
      ),
    ),
  );
}
