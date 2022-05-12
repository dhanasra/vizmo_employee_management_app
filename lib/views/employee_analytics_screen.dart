import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vizmo_employee_management_app/view_models/employee_view_model.dart';
import 'package:vizmo_employee_management_app/widgets/employee_chart.dart';

import '../utils/app_colors.dart';

class EmployeeAnalyticsScreen extends StatefulWidget {
  const EmployeeAnalyticsScreen({Key? key}) : super(key: key);

  @override
  _EmployeeAnalyticsScreenState createState() => _EmployeeAnalyticsScreenState();
}

class _EmployeeAnalyticsScreenState extends State<EmployeeAnalyticsScreen> {
  late EmployeeViewModel viewModel;

  @override
  void initState() {
    viewModel = EmployeeViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        title: Text(
          "Analytics",
          style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 20,
              fontFamily: GoogleFonts.lato().fontFamily,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: body(),
    );
  }

  Widget body(){
    return Column(
      children: [
        const SizedBox(height: 50,),
        Text(
          "Date vs CheckIn Time",
          style: TextStyle(
              color: AppColors.subTitleTxtColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: GoogleFonts.lato().fontFamily
          ),
        ),
        const SizedBox(height: 20,),
        Container(
          height: 500,
          padding: const EdgeInsets.all(15),
          child: EmployeeChart(),
        )
      ],
    );
  }
}
