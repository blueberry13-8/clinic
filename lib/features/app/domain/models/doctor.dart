import 'package:freezed_annotation/freezed_annotation.dart';

part 'doctor.freezed.dart';

@freezed
class Doctor with _$Doctor {
  const factory Doctor({
    required int id,
    required String fullName,
    required String specialty,
    required String workingHours,
    required String contactNumber,
    required String password,
  }) = _Doctor;
}

const kDoctorFields = [
  'ID',
  'ФИО',
  'Специальность',
  'Рабочие часы',
  'Контактный телефон',
  'Пароль',
];
