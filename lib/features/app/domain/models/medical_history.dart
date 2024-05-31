import 'package:freezed_annotation/freezed_annotation.dart';

part 'medical_history.freezed.dart';

@freezed
class MedicalHistory with _$MedicalHistory {
  const factory MedicalHistory({
    required int id,
    required int doctorId,
    required int patientId,
    required DateTime diagnosisDate,
    required String description,
  }) = _MedicalHistory;
}

const kMedicalHistoryFields = [
  'ID',
  'ID Врача',
  'ID Пациента',
  'Дата диагноза',
  'Описание',
];
