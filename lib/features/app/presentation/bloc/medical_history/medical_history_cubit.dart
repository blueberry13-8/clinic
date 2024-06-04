import 'package:bloc/bloc.dart';
import 'package:clinic/features/app/domain/models/medical_history.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/repositories/database.dart';

part 'medical_history_cubit.freezed.dart';
part 'medical_history_state.dart';

class MedicalHistoryCubit extends Cubit<MedicalHistoryState> {
  MedicalHistoryCubit() : super(const MedicalHistoryState.initial());

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
    emit(const MedicalHistoryState.loading());
    try {
      final items = await Database().getMedicalHistories(); //TODO:
      emit(
        MedicalHistoryState.success(
          items: items,
          selectedIndex: prevState?.selectedIndex,
        ),
      );
    } catch (e) {
      emit(MedicalHistoryState.error(e.toString()));
      rethrow;
    }
  }

  Future<void> delete(MedicalHistory item) async {
    Success? prevState;
    if (state case Success state) {
      prevState = state.copyWith();
    }
    emit(const MedicalHistoryState.loading());
    try {
      await Database().deleteMedicalHistory(item);
      final items = await Database().getMedicalHistories(); //TODO:
      final selectedIndex =
          prevState != null && item.id == prevState.selectedIndex
              ? null
              : prevState?.selectedIndex;
      emit(
        MedicalHistoryState.success(
          items: items,
          selectedIndex: selectedIndex,
        ),
      );
    } catch (e) {
      emit(MedicalHistoryState.error(e.toString()));
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
            MedicalHistory(
              id: 0,
              doctorId: 0,
              patientId: 0,
              diagnosisDate: DateTime.now(),
              description: '',
            ),
          ],
          selectedIndex: id,
        ),
      );
    }
  }

  Future<void> update(
    MedicalHistory item, [
    bool isAdd = false,
  ]) async {
    Success? prevState;
    if (state case Success state) {
      prevState = state.copyWith();
    }
    emit(const MedicalHistoryState.loading());
    try {
      if (isAdd) {
        await Database().addMedicalHistory(item);
      } else {
        await Database().updateMedicalHistory(item);
      }
      final items = await Database().getMedicalHistories(); //TODO:
      emit(
        MedicalHistoryState.success(
          items: items,
          selectedIndex: prevState?.selectedIndex,
        ),
      );
    } catch (e) {
      emit(MedicalHistoryState.error(e.toString()));
      rethrow;
    }
  }
}
