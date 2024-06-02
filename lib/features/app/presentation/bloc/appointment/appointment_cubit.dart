import 'package:bloc/bloc.dart';
import 'package:clinic/features/app/domain/models/appointment.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/repositories/database.dart';

part 'appointment_state.dart';

part 'appointment_cubit.freezed.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  AppointmentCubit() : super(const AppointmentState.initial());

  void select(int newIndex) {
    if (state case Success state) {
      emit(
        state.copyWith(
          selectedIndex: newIndex,
        ),
      );
    }
  }

  Future<void> load() async {
    Success? prevState;
    if (state case Success state) {
      prevState = state.copyWith();
    }
    emit(const AppointmentState.loading());
    try {
      final items = await Database().getAppointments(); //TODO:
      emit(
        AppointmentState.success(
          items: items,
          selectedIndex: prevState?.selectedIndex,
        ),
      );
    } catch (e) {
      emit(AppointmentState.error(e.toString()));
      rethrow;
    }
  }

  Future<void> delete(Appointment item) async {
    Success? prevState;
    if (state case Success state) {
      prevState = state.copyWith();
    }
    emit(const AppointmentState.loading());
    try {
      await Database().deleteAppointment(item);
      final items = await Database().getAppointments(); //TODO:
      final selectedIndex =
          prevState != null && item.id == prevState.selectedIndex
              ? null
              : prevState?.selectedIndex;
      emit(
        AppointmentState.success(
          items: items,
          selectedIndex: selectedIndex,
        ),
      );
    } catch (e) {
      emit(AppointmentState.error(e.toString()));
      rethrow;
    }
  }

  Future<void> add() async {
    if (state case Success state) {
      final id = state.items.length;
      emit(
        state.copyWith(
          items: [
            ...state.items,
            Appointment(
              id: 0,
              doctorId: 0,
              patientId: 0,
              appointmentTime: DateTime.now(),
              room: '0',
              status: 'Ожидает назначения'
            ),
          ],
          selectedIndex: id,
        ),
      );
    }
  }

  Future<void> update(
    Appointment item, [
    bool isAdd = false,
  ]) async {
    Success? prevState;
    if (state case Success state) {
      prevState = state.copyWith();
    }
    emit(const AppointmentState.loading());
    try {
      if (isAdd) {
        await Database().addAppointment(item);
      } else {
        await Database().updateAppointment(item);
      }
      final items = await Database().getAppointments(); //TODO:
      emit(
        AppointmentState.success(
          items: items,
          selectedIndex: prevState?.selectedIndex,
        ),
      );
    } catch (e) {
      emit(AppointmentState.error(e.toString()));
      rethrow;
    }
  }
}
