
enum LanguageType{english,arabic}

const String ARABIC ='ar';
const String English ='en';
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