import 'package:vizmo_employee_management_app/services/app_api_client.dart';

import '../models/checkin_model.dart';
import '../models/employee_model.dart';

class AppRepository {

  final AppApiClient apiClient;

  AppRepository({required this.apiClient});

  Future<List<EmployeeModel>> getAllEmployees(page, sortBy, search, filter) async{
    return apiClient.getAllEmployees(
        page,
        sortBy,
        search,
        filter,
    );
  }

  Future<EmployeeModel> getEmployeeById(id) async{
    return apiClient.getEmployeeById(id);
  }

  Future<List<CheckInModel>> getAllCheckInWithEmployeeId(employeeId) async{
    return apiClient.getAllCheckInWithEmployeeId(employeeId);
  }

  Future<CheckInModel> getCheckInModelWithEmployeeId(employeeId,id) async{
    return apiClient.getCheckInModelWithEmployeeId(employeeId, id);
  }

}