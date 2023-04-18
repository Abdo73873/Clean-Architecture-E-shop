import 'package:flutter/cupertino.dart';

import 'constants.dart';

extension NonNullString on String?{
  String orEmpty(){
    if(this==null){
      return Constants.empty;
    }else{
      return this!;
    }
  }
}

extension NonNullInt on int?{
  int orZero(){
    if(this==null){
      return Constants.zero;
    }else{
      return this!;
    }
  }
}

extension EmptPadding on num{
  SizedBox get sh=> SizedBox(height: toDouble(),);
  SizedBox get sw=> SizedBox(height: toDouble(),);
}
