import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vizmo_employee_management_app/models/checkin_model.dart';

import '../../services/app_repository.dart';

part 'checkin_event.dart';
part 'checkin_state.dart';

class CheckinBloc extends Bloc<CheckinEvent, CheckinState> {
  final AppRepository appRepository;

  CheckinBloc(this.appRepository) : super(CheckinInitial()) {
    on<GetAllCheckinsEvent>(getAllCheckins);
    on<GetCheckinByIdEvent>(getCheckin);
  }

  void getAllCheckins(GetAllCheckinsEvent event, Emitter<CheckinState> emit) async{
    emit(CheckinLoading());
    try{
      final List<CheckInModel> checkins = await appRepository.getAllCheckInWithEmployeeId(event.employeeId);
      emit(CheckinFetched(data: checkins));
    }catch(error){
      emit(CheckinFailed(errorMessage: error.toString()));
    }
  }

  void getCheckin(GetCheckinByIdEvent event, Emitter<CheckinState> emit) async{
    emit(CheckinLoading());
    try{
      final CheckInModel checkIn = await appRepository.getCheckInModelWithEmployeeId(event.employeeId,event.id);
      emit(CheckinFetched(data: checkIn));
    }catch(error){
      emit(CheckinFailed(errorMessage: error.toString()));
    }
  }
}
