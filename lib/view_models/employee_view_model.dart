import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';

import '../models/checkin_model.dart';
import '../models/employee_model.dart';

class EmployeeViewModel {

  static late EmployeeViewModel _instance;
  factory EmployeeViewModel() {
    _instance = EmployeeViewModel._internal();
    return _instance;
  }
  EmployeeViewModel._internal();

  static EmployeeModel? employee;
  static CheckInModel? checkIn;
  static List<CheckInModel>? checkIns;

  int page = 1;
  bool isLoadMore = false;
  List<EmployeeModel> employees = [];
  String searchKey = "";
  String sortBy = "";
  String filter = "";
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  List<String> columns = ["name","createdAt","email","phone","country"];

  Future<List<Location>> getLocations(String address) async{
    List<Location> locations = await locationFromAddress(address);
    return locations;
  }

  formatDate(String dateTime, String format){
    final DateTime now = DateTime.parse(dateTime);
    final DateFormat formatter = DateFormat(format);
    final String formatted = formatter.format(now);
    return formatted;
  }

}