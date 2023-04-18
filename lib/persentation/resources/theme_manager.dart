import 'package:flutter/material.dart';
import 'package:mena/persentation/resources/color_manager.dart';
import 'package:mena/persentation/resources/font_manager.dart';
import 'package:mena/persentation/resources/style_manager.dart';
import 'package:mena/persentation/resources/values_manager.dart';

ThemeData getAppTheme() {
  return ThemeData(
    //main color
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primaryLight,
    primaryColorDark: ColorManager.primaryDark,
    disabledColor: ColorManager.gray,
    splashColor: ColorManager.primaryLight,
    //cardView Theme
    cardTheme: const CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.gray,
      elevation: AppSize.s4,
    ),
    //appBar Theme
  appBarTheme:  AppBarTheme(
    color: ColorManager.primary,
    elevation: AppSize.s4,
    centerTitle: true,
    shadowColor: ColorManager.primaryLight,
    titleTextStyle:getRegularStyle(
        fontSize:16.0,
        color: ColorManager.white
    ),
  ),
    //button Theme
    buttonTheme: const ButtonThemeData(
      shape: StadiumBorder(),
      disabledColor: ColorManager.gray,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.primaryLight,
    ),
    //elevated ButtonTheme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(color: ColorManager.white,fontSize: FontSize.s17),
        backgroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
      )
    ),
    //text theme
    textTheme: TextTheme(
      headlineLarge: getSemiBoldStyle(color: ColorManager.darkGray,fontSize: FontSize.s16),
      labelLarge: getSemiBoldStyle(color: ColorManager.primary,fontSize: FontSize.s16),
      titleMedium:getMediumStyle(color: ColorManager.primary,fontSize:FontSize.s14 ),
      titleSmall:getRegularStyle(color: ColorManager.white,fontSize:FontSize.s16 ),
      headlineSmall:getRegularStyle(color: ColorManager.gray,fontSize:FontSize.s16 ),
      titleLarge:getMediumStyle(color: ColorManager.primary,fontSize:FontSize.s16 ),
      bodySmall: getRegularStyle(color: ColorManager.gray,fontSize: FontSize.s12),
      bodyMedium: getRegularStyle(color: ColorManager.darkGray,fontSize: FontSize.s17),
      displayLarge: getLightStyle(color: ColorManager.darkGray,fontSize: FontSize.s16),
      labelSmall: getBoldStyle(color: ColorManager.primary,fontSize: FontSize.s12),

    ),
    //Input decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      hintStyle: getRegularStyle(color: ColorManager.gray,fontSize: FontSize.s14),
      errorStyle: getRegularStyle(color: ColorManager.red,fontSize: FontSize.s14),
      labelStyle: getMediumStyle(color: Colors.grey,fontSize: FontSize.s14),
      enabledBorder:OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.s8),
        borderSide: const BorderSide(color: ColorManager.gray,width:AppSize.s1_5 ),
      ) ,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s8),
          borderSide: const BorderSide(color: ColorManager.primary,width:AppSize.s1_5 ),
        ) ,
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.s8),
        borderSide: const BorderSide(color: ColorManager.red,width:AppSize.s1_5 ),
      ) ,
      focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppSize.s8),
    borderSide: const BorderSide(color: ColorManager.red,width:AppSize.s1_5 ),
  ) ,
    ),
  );
}
