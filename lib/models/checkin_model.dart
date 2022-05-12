import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

@immutable
@JsonSerializable()
class CheckInModel extends Equatable {

  const CheckInModel({
    required this.id,
    required this.checkin,
    required this.location,
    required this.purpose,
    required this.employeeId
  });

  final String id;
  final String checkin;
  final String location;
  final String purpose;
  final String employeeId;

  factory CheckInModel.fromJson(Map<String,dynamic> data) {

    final id = data['id'];
    final checkin = data['checkin'];
    final location = data['location'];
    final purpose = data['purpose'];
    final employeeId = data['employeeId'];

    return CheckInModel(
      id: id,
      checkin: checkin,
      location: location,
      purpose: purpose,
      employeeId: employeeId
    );
  }


  @override
  List<Object?> get props => [];

}