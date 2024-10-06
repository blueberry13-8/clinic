part of 'patient_cubit.dart';

sealed class PatientEvent {}

class FailedToAddUser implements PatientEvent {
const FailedToAddUser(this.message);

final String message;
}