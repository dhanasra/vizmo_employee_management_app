

import 'package:flutter/material.dart';
import 'package:vizmo_employee_management_app/app/app.dart';
import 'package:vizmo_employee_management_app/utils/app_colors.dart';
import 'package:vizmo_employee_management_app/views/employees_screen.dart';
import 'package:vizmo_employee_management_app/views/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int currentIndex;
  late final List<Widget> homeScreens;

  @override
  void initState() {
    currentIndex = 0;
    homeScreens = [
      const EmployeesScreen(),
      const ProfileScreen()
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        App().closeApp();
        return true;
      },
      child: Scaffold(
        body: homeScreens[currentIndex],
        bottomNavigationBar: bottomNavigator(),
      ),
    );
  }

  Widget bottomNavigator(){

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.secondaryColor,
      unselectedItemColor: AppColors.accentColor,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      iconSize: 22,
      elevation: 16,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), label: "Profile"),
      ],
      currentIndex: currentIndex,
      onTap: (int index){
        setState(() {
          currentIndex = index;
        });
      },
    );

  }
}
