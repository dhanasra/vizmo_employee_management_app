import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

@immutable
@JsonSerializable()
class EmployeeModel extends Equatable {

  const EmployeeModel({
    required this.id,
    required this.name,
    required this.avatar,
    required this.email,
    required this.phone,
    required this.birthday,
    required this.country,
    required this.department,
    required this.createdAt,
  });

  final String id;
  final String name;
  final String avatar;
  final String email;
  final String phone;
  final String birthday;
  final String country;
  final List<dynamic> department;
  final String createdAt;

  factory EmployeeModel.fromJson(Map<String,dynamic> data) {
    
    final id = data['id'];
    final name = data['name'];
    final avatar = data['avatar'];
    final email = data['email'];
    final phone = data['phone'];
    final birthday = data['birthday'];
    final country = data['country'];
    final department = data['department'];
    final createdAt = data['createdAt'];

    return EmployeeModel(
        id: id,
        name: name,
        avatar: avatar,
        email: email,
        phone: phone,
        birthday: birthday,
        country: country,
        department: department,
        createdAt: createdAt
    );
  }


  @override
  List<Object?> get props => [];

}