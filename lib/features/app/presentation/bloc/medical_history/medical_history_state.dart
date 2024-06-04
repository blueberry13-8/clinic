part of 'medical_history_cubit.dart';

@freezed
class MedicalHistoryState {
  const factory MedicalHistoryState.initial() = Initial;

  const factory MedicalHistoryState.loading() = Loading;

  const factory MedicalHistoryState.success({
    @Default([]) List<MedicalHistory> items,
    int? selectedIndex,
  }) = Success;

  const factory MedicalHistoryState.error([String? message]) = Error;
}
