part of 'appointment_cubit.dart';

@freezed
class AppointmentState {
  const factory AppointmentState.initial() = Initial;

  const factory AppointmentState.loading() = Loading;

  const factory AppointmentState.success({
    @Default([]) List<Appointment> items,
    int? selectedIndex,
  }) = Success;

  const factory AppointmentState.error([String? message]) = Error;
}