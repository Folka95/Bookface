import 'package:flutter/foundation.dart';

void safePrint(String text){

  if(kDebugMode){
    print("---------------safePrint---------------");
    print(text);
    print("---------------safePrint---------------");
}
}