import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vizmo_employee_management_app/app/app_routes.dart';
import 'package:vizmo_employee_management_app/bloc/checkin/checkin_bloc.dart';
import 'package:vizmo_employee_management_app/bloc/employee/employee_bloc.dart';
import 'package:vizmo_employee_management_app/utils/app_style.dart';
import 'package:vizmo_employee_management_app/views/splash_screen.dart';

import '../services/app_api_client.dart';
import '../services/app_repository.dart';

class App extends StatelessWidget {

  static const App _instance = App._internal();
  const App._internal();
  factory App() {
    return _instance;
  }

  @override
  Widget build(BuildContext context) {
    return getMaterialApp(widget: const SplashScreen(), title: 'Employee Management App', context: context);
  }

  Widget getMaterialApp({required Widget widget, required String title, required BuildContext context}){

    var repository = AppRepository(apiClient: AppApiClient(httpClient: Client()));

    return MultiBlocProvider(
        providers: [
          BlocProvider<EmployeeBloc>(
            create: (BuildContext context) => EmployeeBloc(repository),
          ),
          BlocProvider<CheckinBloc>(
            create: (BuildContext context) => CheckinBloc(repository),
          ),
        ],
        child: MaterialApp(
          title: title,
          debugShowCheckedModeBanner: false,
          home: widget,
          theme: AppStyle.lightTheme(context),
          onGenerateRoute: getAppRoutes().getRoutes,
        )
    );
  }

  AppRoutes getAppRoutes(){
    return AppRoutes();
  }

  Future<dynamic> setNavigation(BuildContext context, String routeName) async {
    Future.delayed(const Duration(milliseconds: 10), () async {
      final navigator = await Navigator.push(
          context,
          PageTransition(
              child: getAppRoutes().getWidget(context, routeName),
              type: PageTransitionType.fade,
              settings: RouteSettings(name: routeName),
              duration: const Duration(microseconds: 0))
      );
      return navigator;
    });
  }

  void setBackNavigation(BuildContext context) {
    Navigator.pop(context, "true");
  }

  void closeApp() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else {
      exit(0);
    }
  }
}
