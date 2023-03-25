
import 'package:flutter/material.dart';
import 'package:mena/persentation/resources/font_manager.dart';

TextStyle _getTextStyle(double fontSize, Color color, FontWeight fontWeight,)=>TextStyle(
  fontSize: fontSize,
  fontWeight: fontWeight,
  color: color,
  fontFamily: FontConstant.fontFamily,
);

//regular
TextStyle getRegularStyle({
  double fontSize=FontSize.s12,
  required Color color,
})=>_getTextStyle(fontSize, color, FontWrightManager.regular,);

//medium
TextStyle getMediumStyle({
  double fontSize=FontSize.s12,
  required Color color,
})=>_getTextStyle(fontSize, color, FontWrightManager.medium,);


//bold
TextStyle getBoldStyle({
  double fontSize=FontSize.s12,
  required Color color,
})=>_getTextStyle(fontSize, color, FontWrightManager.bold,);

//SemiBold
TextStyle getSemiBoldStyle({
  double fontSize=FontSize.s12,
  required Color color,
})=>_getTextStyle(fontSize, color, FontWrightManager.semiBold,);

//Light
TextStyle getLightStyle({
  double fontSize=FontSize.s12,
  required Color color,
})=>_getTextStyle(fontSize, color, FontWrightManager.light,);


