part of 'employee_bloc.dart';

@immutable
abstract class EmployeeState {}

class EmployeeInitial extends EmployeeState {}

class EmployeeLoading extends EmployeeState{}

class EmployeeFetched extends EmployeeState{
  final dynamic data;
  EmployeeFetched({required this.data});
}

class EmployeeFailed extends EmployeeState{
  final String errorMessage;
  EmployeeFailed({required this.errorMessage});
}
