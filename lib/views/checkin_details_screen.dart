
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:vizmo_employee_management_app/bloc/checkin/checkin_bloc.dart';
import 'package:vizmo_employee_management_app/models/checkin_model.dart';
import 'package:vizmo_employee_management_app/services/app_api_client.dart';
import 'package:vizmo_employee_management_app/services/app_repository.dart';
import 'package:vizmo_employee_management_app/view_models/employee_view_model.dart';
import 'package:vizmo_employee_management_app/widgets/checkin_map.dart';

import '../utils/app_colors.dart';

class CheckinDetailsScreen extends StatefulWidget {
  const CheckinDetailsScreen({Key? key}) : super(key: key);

  @override
  _CheckinDetailsScreenState createState() => _CheckinDetailsScreenState();
}

class _CheckinDetailsScreenState extends State<CheckinDetailsScreen> {
  late AppRepository repository;
  late CheckinBloc bloc;
  late EmployeeViewModel viewModel;

  @override
  void initState() {
    repository = AppRepository(apiClient: AppApiClient(httpClient: Client()));
    bloc = CheckinBloc(repository);
    viewModel = EmployeeViewModel();
    bloc.add(GetCheckinByIdEvent(employeeId: EmployeeViewModel.employee!.id, id: EmployeeViewModel.checkIn!.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        elevation: 0,
      ),
      body: BlocBuilder<CheckinBloc,CheckinState>(
        bloc: bloc,
        builder: (context, state){
          if(state is CheckinLoading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else if(state is CheckinFetched){
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

  Widget body(CheckInModel checkIn){
    return ListView(
      children: [
        Container(
          height: 200,
          color: Colors.white24,
          child: CheckinMap(address: checkIn.location)
        ),
        checkInItemDetail("CheckIn", viewModel.formatDate(checkIn.checkin, "dd MMM yyyy, hh:mm a")),
        checkInItemDetail("Location", checkIn.location),
        checkInItemDetail("Purpose", checkIn.purpose),
      ],
    );
  }

  Widget checkInItemDetail(String tag, String value){
    return Padding(
      padding: const EdgeInsets.only(left: 15,right: 15,top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  color: AppColors.subTitleTxtColor,
                  fontSize: 16,
                  fontFamily: GoogleFonts.lato().fontFamily
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
