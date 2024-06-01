part of 'doctor_cubit.dart';

@freezed
class DoctorState {
  const factory DoctorState.initial() = Initial;

  const factory DoctorState.loading() = Loading;

  const factory DoctorState.success({
    @Default([]) List<Doctor> items,
    int? selectedIndex,
  }) = Success;

  const factory DoctorState.error([String? message]) = Error;
}