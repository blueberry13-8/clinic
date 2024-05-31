import 'package:freezed_annotation/freezed_annotation.dart';

part 'appointment.freezed.dart';

@freezed
class Appointment with _$Appointment {
  const factory Appointment({
    required int id,
    required int doctorId,
    required int patientId,
    required DateTime appointmentDate,
    required DateTime appointmentTime,
    required String room,
    required String status,
  }) = _Appointment;
}

const kAppointmentFields = [
  'ID',
  'ID Врача',
  'ID Пациента',
  'Дата приема',
  'Время приема',
  'Кабинет',
  'Статус',
];
