import 'package:flutter/material.dart';
import 'package:vizmo_employee_management_app/app/app.dart';
import 'package:vizmo_employee_management_app/app/app_routes.dart';

class InternetIssueScreen extends StatelessWidget {
  const InternetIssueScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.signal_wifi_off,
            size: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Internet is not connected !",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22
                ),
              ),
              TextButton(
                onPressed: ()=>App().setNavigation(context, AppRoutes.splashScreen),
                child: const Text(
                  "Refresh",
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
