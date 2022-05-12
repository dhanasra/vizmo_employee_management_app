import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vizmo_employee_management_app/app/app.dart';
import 'package:vizmo_employee_management_app/app/app_routes.dart';
import 'package:vizmo_employee_management_app/models/employee_model.dart';
import 'package:vizmo_employee_management_app/utils/app_colors.dart';
import 'package:vizmo_employee_management_app/view_models/employee_view_model.dart';

class EmployeeItem extends StatelessWidget {
  final EmployeeModel employee;
  const EmployeeItem({
    Key? key,
    required this.employee
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(5),
      child: InkWell(
        onTap: (){
          EmployeeViewModel.employee = employee;
          App().setNavigation(context, AppRoutes.employeeDetailsScreen);
        },
        child: Container(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(employee.avatar),
                ),
                const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      employee.name,
                      style: TextStyle(
                        color: AppColors.titleTxtColor,
                        fontSize: 16,
                        fontFamily: GoogleFonts.lato().fontFamily,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Text(
                      employee.email,
                      style: TextStyle(
                          color: AppColors.subTitleTxtColor,
                          fontSize: 12,
                          fontFamily: GoogleFonts.lato().fontFamily
                      ),
                    )
                  ],
                )
              ],
            )
        ),
      )
    );
  }
}
