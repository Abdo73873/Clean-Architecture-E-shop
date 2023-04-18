
import 'package:flutter/material.dart';

enum LanguageType{english,arabic}

const String ARABIC ='ar';
const String English ='en';

const String ASSET_PATH_LOCALISATION ='assets/translations';
const Locale ARABIC_LOCALE =Locale("ar","SA");
const Locale ENGLISH_LOCALE =Locale("en","US");
extension LaguageExtension on LanguageType{
  String getValue(){
    switch(this){
      case LanguageType.english:
       return English;
      case LanguageType.arabic:
       return ARABIC;
    }
  }
}
class LanguageManager{

}