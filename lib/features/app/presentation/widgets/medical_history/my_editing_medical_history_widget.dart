import 'package:clinic/features/app/domain/models/medical_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/medical_history/medical_history_cubit.dart';
import '../my_form_field.dart';

class MyEditingMedicalHistoryTable extends StatefulWidget {
  const MyEditingMedicalHistoryTable({
    super.key,
    required this.fields,
    this.item,
    required this.editable,
  });

  final MedicalHistory? item;
  final List<String> fields;
  final bool editable;

  @override
  State<MyEditingMedicalHistoryTable> createState() =>
      _MyEditingMedicalHistoryTableState();
}

class _MyEditingMedicalHistoryTableState
    extends State<MyEditingMedicalHistoryTable> {
  @override
  void initState() {
    super.initState();
    if (widget.item == null) {
      _item = MedicalHistory(
        id: 0,
        doctorId: 0,
        patientId: 0,
        diagnosisDate: DateTime.now(),
        description: '',
      );
    } else {
      _item = widget.item!;
    }
  }

  late MedicalHistory _item;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MyFormField(
          enabled: false,
          fieldName: widget.fields[0],
          value: widget.item?.id,
          onChanged: (newValue) =>
              _item = _item.copyWith(id: int.parse(newValue)),
          editable: widget.editable,
        ),
        MyFormField(
          enabled: widget.editable,
          fieldName: widget.fields[1],
          value: widget.item?.doctorId,
          onChanged: (newValue) =>
              _item = _item.copyWith(doctorId: int.parse(newValue)),
          editable: widget.editable,
        ),
        MyFormField(
          enabled: widget.editable,
          fieldName: widget.fields[2],
          value: widget.item?.patientId,
          onChanged: (newValue) =>
              _item = _item.copyWith(patientId: int.parse(newValue)),
          editable: widget.editable,
        ),
        MyFormField(
          enabled: widget.editable,
          fieldName: widget.fields[3],
          value: widget.item?.diagnosisDate,
          onChanged: (newValue) =>
              _item = _item.copyWith(diagnosisDate: DateTime.parse(newValue)),
          editable: widget.editable,
        ),
        MyFormField(
          enabled: widget.editable,
          fieldName: widget.fields[4],
          value: widget.item?.description,
          onChanged: (newValue) =>
              _item = _item.copyWith(description: newValue),
          editable: widget.editable,
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                if (widget.editable) {
                  context.read<MedicalHistoryCubit>().update(
                        _item,
                        widget.item == null,
                      );
                }
              },
              child: const Text('Обновить'),
            ),
            const SizedBox(
              width: 15,
            ),
            ElevatedButton(
              onPressed: () async {
                if (widget.editable && widget.item != null) {
                  context.read<MedicalHistoryCubit>().delete(
                        widget.item!,
                      );
                }
              },
              child: const Text('Удалить'),
            ),
          ],
        ),
      ],
    );
  }
}
