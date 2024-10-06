import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:clinic/features/app/domain/models/patient.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/repositories/database.dart';

part 'patient_cubit.freezed.dart';
part 'patient_event.dart';
part 'patient_state.dart';

class PatientCubit extends Cubit<PatientState>
    with BlocPresentationMixin<PatientState, PatientEvent> {
  PatientCubit() : super(const PatientState.initial());

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
    emit(const PatientState.loading());
    try {
      final items = await Database().getPatients();
      emit(
        PatientState.success(
          items: items,
          selectedIndex: prevState?.selectedIndex,
        ),
      );
    } catch (e) {
      emit(PatientState.error(e.toString()));
      rethrow;
    }
  }

  Future<void> delete(Patient item) async {
    Success? prevState;
    if (state case Success state) {
      prevState = state.copyWith();
    }
    emit(const PatientState.loading());
    try {
      await Database().deletePatient(item);
      final items = await Database().getPatients();
      final selectedIndex =
          prevState != null && item.id == prevState.selectedIndex
              ? null
              : prevState?.selectedIndex;
      emit(
        PatientState.success(
          items: items,
          selectedIndex: selectedIndex,
        ),
      );
    } catch (e) {
      emit(PatientState.error(e.toString()));
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
            Patient(
              id: id + 1,
              fullName: '',
              age: 1,
              contactNumber: '',
              address: '',
              gender: '',
              password: '',
            ),
          ],
          selectedIndex: id,
        ),
      );
    }
  }

  Future<void> update(
    Patient item, [
    bool isAdd = false,
  ]) async {
    Success? prevState;
    if (state case Success state) {
      prevState = state.copyWith();
    }
    emit(const PatientState.loading());
    try {
      if (isAdd) {
        await Database().addPatient(item);
      } else {
        await Database().updatePatient(item);
      }
      final items = await Database().getPatients();
      emit(
        PatientState.success(
          items: items,
          selectedIndex: prevState?.selectedIndex,
        ),
      );
    } catch (e) {
      emitPresentation(FailedToAddUser(e.toString()));
      if (prevState == null) {
        await load();
      } else {
        emit(prevState);
      }
    }
  }
}
