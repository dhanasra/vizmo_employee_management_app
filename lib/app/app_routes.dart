import 'package:flutter/material.dart';
import 'package:vizmo_employee_management_app/views/checkin_details_screen.dart';
import 'package:vizmo_employee_management_app/views/employee_analytics_screen.dart';
import 'package:vizmo_employee_management_app/views/employee_details_screen.dart';
import 'package:vizmo_employee_management_app/views/home_screen.dart';
import 'package:vizmo_employee_management_app/views/internet_issue_screen.dart';
import 'package:vizmo_employee_management_app/views/profile_screen.dart';
import 'package:vizmo_employee_management_app/views/splash_screen.dart';

class AppRoutes {

  static const String splashScreen = "/splash";
  static const String homeScreen = "/home";
  static const String profileScreen = "/profile";
  static const String employeeDetailsScreen = "/employee_details";
  static const String employeeAnalyticsScreen = "/employee_analytics_details";
  static const String checkInDetailsScreen = "/checkin_details";
  static const String networkIssueScreen = "/network_issue";

  Route getRoutes(RouteSettings routeSettings){
    switch(routeSettings.name) {
      case networkIssueScreen:
        {
          return MaterialPageRoute(
              settings: routeSettings,
              builder: (BuildContext context) => const InternetIssueScreen(),
              fullscreenDialog: true
          );
        }
      case profileScreen:
        {
          return MaterialPageRoute(
              settings: routeSettings,
              builder: (BuildContext context) => const ProfileScreen(),
              fullscreenDialog: true
          );
        }
      case checkInDetailsScreen:
        {
          return MaterialPageRoute(
              settings: routeSettings,
              builder: (BuildContext context) => const CheckinDetailsScreen(),
              fullscreenDialog: true
          );
        }
      case employeeAnalyticsScreen:
        {
          return MaterialPageRoute(
              settings: routeSettings,
              builder: (BuildContext context) => const EmployeeAnalyticsScreen(),
              fullscreenDialog: true
          );
        }
      case employeeDetailsScreen:
        {
          return MaterialPageRoute(
              settings: routeSettings,
              builder: (BuildContext context) => const EmployeeDetailsScreen(),
              fullscreenDialog: true
          );
        }
      case homeScreen:
        {
          return MaterialPageRoute(
              settings: routeSettings,
              builder: (BuildContext context) => const HomeScreen(),
              fullscreenDialog: true
          );
        }
      case splashScreen:
        {
          return MaterialPageRoute(
              settings: routeSettings,
              builder: (BuildContext context) => const SplashScreen(),
              fullscreenDialog: true
          );
        }
      default:
        {
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (BuildContext context) => Container(),
            fullscreenDialog: true
          );
        }
    }
  }

  Widget getWidget(BuildContext context, String routeName){
    switch(routeName){
      case networkIssueScreen:
        {
          return const InternetIssueScreen();
        }
      case profileScreen:
        {
          return const ProfileScreen();
        }
      case checkInDetailsScreen:
        {
          return const CheckinDetailsScreen();
        }
      case employeeAnalyticsScreen:
        {
          return const EmployeeAnalyticsScreen();
        }
      case employeeDetailsScreen:
        {
          return const EmployeeDetailsScreen();
        }
      case homeScreen:
        {
          return const HomeScreen();
        }
      case splashScreen:
        {
          return const SplashScreen();
        }
      default:
        {
          return Container();
        }
    }
  }

}