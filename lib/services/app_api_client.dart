import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vizmo_employee_management_app/models/checkin_model.dart';
import 'package:vizmo_employee_management_app/models/employee_model.dart';

class AppApiClient {

  final baseUrl = "https://620dfdda20ac3a4eedcf5a52.mockapi.io/api";
  late final http.Client httpClient;

  AppApiClient({required this.httpClient});

  var headers = { 'Content-Type': 'application/json' };

  Future<List<EmployeeModel>> getAllEmployees(page, sortBy, search, String filter) async{

    var isFilterEnable = filter.isNotEmpty ? filter:"search";
    var endPoint = '$baseUrl/employee?page=$page&limit=10&sortBy=$sortBy&order=desc&$isFilterEnable=$search';
    var request = http.Request('GET', Uri.parse(endPoint));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String responseStr = await response.stream.bytesToString();
    List<dynamic> json = jsonDecode(responseStr);

    List<EmployeeModel> employees = [];
    for (var element in json) {
        EmployeeModel employee = EmployeeModel.fromJson(element);
        employees.add(employee);
      }

    return employees;
  }

  Future<EmployeeModel> getEmployeeById(id) async{
    var request = http.Request('GET', Uri.parse('$baseUrl/employee/$id'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String responseStr = await response.stream.bytesToString();
    Map<String, dynamic> json = jsonDecode(responseStr);

    return EmployeeModel.fromJson(json);
  }

  Future<List<CheckInModel>> getAllCheckInWithEmployeeId(employeeId) async{
    var request = http.Request('GET', Uri.parse('$baseUrl/employee/$employeeId/checkin'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String responseStr = await response.stream.bytesToString();
    List<dynamic> json = jsonDecode(responseStr);
    List<CheckInModel> checkins = [];
    for (var element in json) {
      CheckInModel checkin = CheckInModel.fromJson(element);
      checkins.add(checkin);
    }

    return checkins;
  }

  Future<CheckInModel> getCheckInModelWithEmployeeId(employeeId,id) async{
    var request = http.Request('GET', Uri.parse('$baseUrl/employee/$employeeId/checkin/$id'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String responseStr = await response.stream.bytesToString();
    Map<String, dynamic> json = jsonDecode(responseStr);

    return CheckInModel.fromJson(json);
  }

}