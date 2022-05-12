part of 'employee_bloc.dart';

@immutable
abstract class EmployeeEvent {}

class GetAllEmployeesEvent extends EmployeeEvent{
  final int page;
  final List<EmployeeModel> employees;
  final String sortBy;
  final String search;
  final String filter;
  final bool isNextPage;

  GetAllEmployeesEvent({
    required this.page,
    required this.employees,
    required this.search,
    required this.filter,
    required this.sortBy,
    required this.isNextPage
  });
}

class GetEmployeeEvent extends EmployeeEvent{
  final String id;

  GetEmployeeEvent({required this.id});
}