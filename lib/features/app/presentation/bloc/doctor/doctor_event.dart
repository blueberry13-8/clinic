part of 'doctor_cubit.dart';

sealed class DoctorEvent {}

class FailedToAddUser implements DoctorEvent {
  const FailedToAddUser(this.message);

  final String message;
}