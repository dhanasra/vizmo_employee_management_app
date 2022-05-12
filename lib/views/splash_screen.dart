import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:vizmo_employee_management_app/app/app.dart';
import 'package:vizmo_employee_management_app/app/app_routes.dart';
import 'package:vizmo_employee_management_app/view_models/splash_view_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashViewModel viewModel;
  late StreamSubscription subscription;

  @override
  void initState() {
    viewModel = SplashViewModel();
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        App().setNavigation(context, AppRoutes.networkIssueScreen);
      } else{
        App().setNavigation(context, AppRoutes.splashScreen);
      }
    });

    Timer(const Duration(seconds: 3), ()=>{
      App().setNavigation(context, AppRoutes.homeScreen)
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/logo.png"),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }
}
