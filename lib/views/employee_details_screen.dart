import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:vizmo_employee_management_app/app/app.dart';
import 'package:vizmo_employee_management_app/app/app_routes.dart';
import 'package:vizmo_employee_management_app/bloc/checkin/checkin_bloc.dart';
import 'package:vizmo_employee_management_app/models/employee_model.dart';
import 'package:vizmo_employee_management_app/view_models/employee_view_model.dart';
import 'package:vizmo_employee_management_app/widgets/checkin_item.dart';

import '../bloc/employee/employee_bloc.dart';
import '../services/app_api_client.dart';
import '../services/app_repository.dart';
import '../utils/app_colors.dart';

class EmployeeDetailsScreen extends StatefulWidget {
  const EmployeeDetailsScreen({Key? key}) : super(key: key);

  @override
  _EmployeeDetailsScreenState createState() => _EmployeeDetailsScreenState();
}

class _EmployeeDetailsScreenState extends State<EmployeeDetailsScreen> {
  late EmployeeViewModel viewModel;
  late AppRepository repository;
  late EmployeeBloc employeeBloc;
  late CheckinBloc checkinBloc;

  @override
  void initState() {
    viewModel = EmployeeViewModel();
    repository = AppRepository(apiClient: AppApiClient(httpClient: Client()));
    employeeBloc = EmployeeBloc(repository);
    checkinBloc = CheckinBloc(repository);
    employeeBloc.add(GetEmployeeEvent(id: EmployeeViewModel.employee!.id));
    checkinBloc.add(GetAllCheckinsEvent(employeeId: EmployeeViewModel.employee!.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        elevation: 0,
        actions: [
          IconButton(onPressed: (){
            App().setNavigation(context, AppRoutes.employeeAnalyticsScreen);
          }, icon: const Icon(Icons.show_chart),splashRadius: 20,),
        ],
      ),
      body: BlocBuilder<EmployeeBloc,EmployeeState>(
        bloc: employeeBloc,
        builder: (context, state){
          if(state is EmployeeLoading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else if(state is EmployeeFetched){
            return body(state.data);
          }else{
            return const Center(
              child: Text(
                "Sorry! Not Found",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget body(EmployeeModel employee){
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        Row(
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
                      fontSize: 14,
                      fontFamily: GoogleFonts.lato().fontFamily
                  ),
                )
              ],
            )
          ],
        ),
        const SizedBox(height: 20,),
        employeeItemDetail(Icons.phone_outlined, "Phone", employee.phone),
        employeeItemDetail(Icons.cake_outlined, "Birth day", viewModel.formatDate(employee.birthday, "dd MMM, yyyy")),
        employeeItemDetail(Icons.map_outlined,"Country", employee.country),
        employeeItemDetail(Icons.create_outlined,"Created At", viewModel.formatDate(employee.createdAt, "dd MMM, yyyy")),
        employeeItemDetail(Icons.work_outline_rounded,"Department", employee.department.join(", ")),
        const Divider(height: 30,thickness: 4,color: Colors.black12,),
        tagText(Icons.login, "Checkins"),
        const SizedBox(height: 10,),
        checkinsList()
      ],
    );
  }

  Widget checkinsList(){
    return BlocBuilder<CheckinBloc,CheckinState>(
      bloc: checkinBloc,
      builder: (context, state){
        if(state is CheckinLoading){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }else if(state is CheckinFetched){

          EmployeeViewModel.checkIns = state.data;

          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.data.length,
              itemBuilder: (BuildContext context, index){
                return CheckinItem(checkIn: state.data[index]);
              },
          );
        }else{
          return Container(
            child: Text("No Checkins Found"),
          );
        }
      },
    );
  }

  Widget employeeItemDetail(IconData icon,String tag, String value){
    return Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            tagText(icon, tag),
            const SizedBox(height: 10,),
            Text(
              value,
              style: TextStyle(
                  color: AppColors.titleTxtColor,
                  fontSize: 16,
                  fontFamily: GoogleFonts.lato().fontFamily
              ),
            ),
          ],
        )
    );
  }

  Widget tagText(IconData icon, String tag){
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.subTitleTxtColor,
        ),
        const SizedBox(width: 10,),
        SizedBox(
          width: 100,
          child: Text(
            tag,
            style: TextStyle(
                color: AppColors.subTitleTxtColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: GoogleFonts.lato().fontFamily
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    employeeBloc.close();
    checkinBloc.close();
    super.dispose();
  }
}
