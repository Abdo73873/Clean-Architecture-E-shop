import 'package:flutter/material.dart';
import 'package:mena/persentation/resources/langauge_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';


const String PREFS_KEY_LANG='PREFS_KEY_LANG';
const String PREFS_KEY_ONBOARDING_SCREEN_VIEWED='PREFS_KEY_ONBOARDING_SCREEN_VIEWED';
const String PREFS_KEY_IS_USER_LOGGED_IN='PREFS_KEY_IS_USER_LOGGED_IN';
class AppPreferences{
  final SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);
  Future<String> getAppLanguage() async {
    String? language=_sharedPreferences.getString(PREFS_KEY_LANG);
    if(language!=null&&language.isNotEmpty){
      return language;
    }else{
      return LanguageType.english.getValue();
    }
  }
  Future<void> changeAppLanguage() async {
    String currentLanguage=await getAppLanguage();
    if(currentLanguage==LanguageType.english.getValue()){
      _sharedPreferences.setString(PREFS_KEY_LANG, LanguageType.arabic.getValue());
    }else{
      _sharedPreferences.setString(PREFS_KEY_LANG, LanguageType.english.getValue());

    }
  }
  Future<Locale> getLocal() async {
    String currentLanguage=await getAppLanguage();
    if(currentLanguage==LanguageType.english.getValue()){
     return ARABIC_LOCALE;
    }else{
      return ENGLISH_LOCALE;

    }
  }

  Future<void> setOnBoardingScreenViewed()async{
    _sharedPreferences.setBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED, true);
  }
  Future<bool> getOnBoardingScreenViewed()async{
    return  _sharedPreferences.getBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED)??false;
  }
  Future<void> setUserLoggedIn()async{
    _sharedPreferences.setBool(PREFS_KEY_IS_USER_LOGGED_IN, true);
  }
  Future<bool> getUserLoggedIn()async{
    return  _sharedPreferences.getBool(PREFS_KEY_IS_USER_LOGGED_IN)??false;
  }
  Future<void> logOut()async{
      _sharedPreferences.remove(PREFS_KEY_IS_USER_LOGGED_IN);
  }

}