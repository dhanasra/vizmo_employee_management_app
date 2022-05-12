import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vizmo_employee_management_app/models/employee_model.dart';
import 'package:vizmo_employee_management_app/services/app_repository.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final AppRepository appRepository;

  EmployeeBloc(this.appRepository) : super(EmployeeInitial()) {
    on<GetAllEmployeesEvent>(getAllEmployees);
    on<GetEmployeeEvent>(getEmployee);
  }

  void getAllEmployees(GetAllEmployeesEvent event, Emitter<EmployeeState> emit) async{
    emit(EmployeeLoading());
    try{
      List<EmployeeModel> employees =
          await appRepository.getAllEmployees(
            event.page,
            event.sortBy,
            event.search,
            event.filter,
          );
      if(event.isNextPage){
        employees = [...event.employees,...employees];
      }
      emit(EmployeeFetched(data: employees));
    }catch(error){
      emit(EmployeeFailed(errorMessage: error.toString()));
    }
  }

  void getEmployee(GetEmployeeEvent event, Emitter<EmployeeState> emit) async{
    emit(EmployeeLoading());
    try{
      final EmployeeModel employee = await appRepository.getEmployeeById(event.id);
      emit(EmployeeFetched(data: employee));
    }catch(error){
      emit(EmployeeFailed(errorMessage: error.toString()));
    }
  }
}
