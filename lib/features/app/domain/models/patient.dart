import 'package:freezed_annotation/freezed_annotation.dart';

part 'patient.freezed.dart';

@freezed
class Patient with _$Patient {
  const factory Patient({
    required int id,
    required String fullName,
    required int age,
    required String contactNumber,
    required String address,
    required String gender,
    required String password,
  }) = _Patient;
}

const kPatientFields = [
  'ID',
  'ФИО',
  'Полных лет',
  'Контактный телефон',
  'Адрес',
  'Пол',
  'Пароль',
];
