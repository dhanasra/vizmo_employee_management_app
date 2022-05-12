part of 'checkin_bloc.dart';

@immutable
abstract class CheckinState {}

class CheckinInitial extends CheckinState {}

class CheckinLoading extends CheckinState{}

class CheckinFetched extends CheckinState{
  final dynamic data;
  CheckinFetched({required this.data});
}

class CheckinFailed extends CheckinState{
  final String errorMessage;
  CheckinFailed({required this.errorMessage});
}
