part of 'patient_cubit.dart';

@freezed
class PatientState {
  const factory PatientState.initial() = Initial;

  const factory PatientState.loading() = Loading;

  const factory PatientState.success({
    @Default([]) List<Patient> items,
    int? selectedIndex,
  }) = Success;

  const factory PatientState.error([String? message]) = Error;
}