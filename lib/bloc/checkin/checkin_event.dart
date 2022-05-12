part of 'checkin_bloc.dart';

@immutable
abstract class CheckinEvent {}

class GetAllCheckinsEvent extends CheckinEvent{
  final String employeeId;

  GetAllCheckinsEvent({required this.employeeId});
}

class GetCheckinByIdEvent extends CheckinEvent{
  final String employeeId;
  final String id;

  GetCheckinByIdEvent({required this.employeeId, required this.id});
}
