import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vizmo_employee_management_app/app/app.dart';
import 'package:vizmo_employee_management_app/app/app_routes.dart';
import 'package:vizmo_employee_management_app/models/checkin_model.dart';
import 'package:vizmo_employee_management_app/utils/app_colors.dart';
import 'package:vizmo_employee_management_app/view_models/employee_view_model.dart';

class CheckinItem extends StatelessWidget {
  final CheckInModel checkIn;
  const CheckinItem({
    Key? key,
    required this.checkIn
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        child: InkWell(
          onTap: (){
            EmployeeViewModel.checkIn = checkIn;
            App().setNavigation(context, AppRoutes.checkInDetailsScreen);
          },
          child: Container(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: Text(checkIn.location.substring(0,1)),
                    backgroundColor: AppColors.accentColor,
                  ),
                  const SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        checkIn.location,
                        maxLines: 3,
                        style: TextStyle(
                            color: AppColors.titleTxtColor,
                            fontSize: 16,
                            fontFamily: GoogleFonts.lato().fontFamily,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Text(
                        checkIn.checkin,
                        maxLines: 3,
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
