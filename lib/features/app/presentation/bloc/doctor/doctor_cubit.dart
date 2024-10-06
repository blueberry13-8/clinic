import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/doctor.dart';
import '../../../domain/repositories/database.dart';

part 'doctor_cubit.freezed.dart';
part 'doctor_event.dart';
part 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState>
    with BlocPresentationMixin<DoctorState, DoctorEvent> {
  DoctorCubit() : super(const DoctorState.initial());

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
    emit(const DoctorState.loading());
    try {
      final items = await Database().getDoctors();
      emit(
        DoctorState.success(
          items: items,
          selectedIndex: prevState?.selectedIndex,
        ),
      );
    } catch (e) {
      emit(DoctorState.error(e.toString()));
      rethrow;
    }
  }

  Future<void> delete(Doctor item) async {
    Success? prevState;
    if (state case Success state) {
      prevState = state.copyWith();
    }
    emit(const DoctorState.loading());
    try {
      await Database().deleteDoctor(item);
      final items = await Database().getDoctors();
      final selectedIndex =
          prevState != null && item.id == prevState.selectedIndex
              ? null
              : prevState?.selectedIndex;
      emit(
        DoctorState.success(
          items: items,
          selectedIndex: selectedIndex,
        ),
      );
    } catch (e) {
      emit(DoctorState.error(e.toString()));
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
            Doctor(
              id: id + 1,
              fullName: '',
              specialty: '',
              workingHours: '',
              contactNumber: '',
              password: '',
            ),
          ],
          selectedIndex: id,
        ),
      );
    }
  }

  Future<void> update(
    Doctor item, [
    bool isAdd = false,
  ]) async {
    Success? prevState;
    if (state case Success state) {
      prevState = state.copyWith();
    }
    emit(const DoctorState.loading());
    try {
      if (isAdd) {
        await Database().addDoctor(item);
      } else {
        await Database().updateDoctor(item);
      }
      final items = await Database().getDoctors();
      emit(
        DoctorState.success(
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
