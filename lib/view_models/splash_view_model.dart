import 'package:flutter/services.dart';

class SplashViewModel {

  static late SplashViewModel _instance;
  factory SplashViewModel() {
    _instance = SplashViewModel._internal();
    return _instance;
  }
  SplashViewModel._internal() {
    init();
  }

  void init(){

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

  }

}