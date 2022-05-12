import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vizmo_employee_management_app/utils/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.secondaryColor,
        title: Text(
          "My Profile",
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
        Container(
          padding: const EdgeInsets.all(20),
          color: AppColors.secondaryColor,
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Admin",
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.lato().fontFamily
                ),
              ),
              const CircleAvatar(
                radius: 30,
                child: Text('A'),
                backgroundColor: AppColors.accentColor,
              ),
            ],
          ),
        ),
        const SizedBox(height: 30,),
        profileOptions(Icons.settings_outlined, "Settings"),
        profileOptions(Icons.language_rounded, "Change Language"),
        profileOptions(Icons.color_lens_outlined, "Theme"),
        profileOptions(Icons.help_outline, "Help & Knowledgebase"),
        profileOptions(Icons.privacy_tip_outlined, "Privacy Policy"),
        profileOptions(Icons.logout, "Logout"),
      ],
    );
  }

  Widget profileOptions(IconData icon, String option){
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 20,bottom: 20),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.subTitleTxtColor,
          ),
          const SizedBox(width: 10,),
          Expanded(
            child: Text(
              option,
              style: TextStyle(
                  color: AppColors.titleTxtColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: GoogleFonts.lato().fontFamily
              ),
            ),
          ),
          const SizedBox(width: 10,),
          const Icon(
            Icons.arrow_right,
            color: AppColors.subTitleTxtColor,
          ),
        ],
      ),
    );
  }
}
