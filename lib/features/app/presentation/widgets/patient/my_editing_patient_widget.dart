import 'package:clinic/features/app/domain/models/patient.dart';
import 'package:clinic/features/app/presentation/bloc/patient/patient_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../my_form_field.dart';

class MyEditingPatientTable extends StatefulWidget {
  const MyEditingPatientTable({
    super.key,
    required this.fields,
    this.item,
    required this.editable,
  });

  final Patient? item;
  final List<String> fields;
  final bool editable;

  @override
  State<MyEditingPatientTable> createState() =>
      _MyEditingPatientTableState();
}

class _MyEditingPatientTableState extends State<MyEditingPatientTable> {
  @override
  void initState() {
    super.initState();
    if (widget.item == null) {
      _item = const Patient(
        id: -1,
        fullName: '',
        age: 0,
        contactNumber: '',
        address: '',
        gender: '',
        password: '',
      );
    } else {
      _item = widget.item!;
    }
  }

  late Patient _item;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MyFormField(
          enabled: widget.editable,
          fieldName: widget.fields[0],
          value: widget.item?.id,
          onChanged: (newValue) =>
          _item = _item.copyWith(id: int.parse(newValue)),
          editable: widget.editable,
        ),
        MyFormField(
          enabled: widget.editable,
          fieldName: widget.fields[1],
          value: widget.item?.fullName,
          onChanged: (newValue) =>
          _item = _item.copyWith(fullName: newValue),
          editable: widget.editable,
        ),
        MyFormField(
          enabled: widget.editable,
          fieldName: widget.fields[2],
          value: widget.item?.age,
          onChanged: (newValue) =>
          _item = _item.copyWith(age: int.parse(newValue)),
          editable: widget.editable,
        ),
        MyFormField(
          enabled: widget.editable,
          fieldName: widget.fields[3],
          value: widget.item?.contactNumber,
          onChanged: (newValue) =>
          _item = _item.copyWith(contactNumber: newValue),
          editable: widget.editable,
        ),
        MyFormField(
          enabled: widget.editable,
          fieldName: widget.fields[4],
          value: widget.item?.address,
          onChanged: (newValue) =>
          _item = _item.copyWith(address: newValue),
          editable: widget.editable,
        ),
        MyFormField(
          enabled: widget.editable,
          fieldName: widget.fields[5],
          value: widget.item?.gender,
          onChanged: (newValue) =>
          _item = _item.copyWith(gender: newValue),
          editable: widget.editable,
        ),
        MyFormField(
          enabled: widget.editable,
          fieldName: widget.fields[6],
          value: widget.item?.password,
          onChanged: (newValue) =>
          _item = _item.copyWith(password: newValue),
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
                  context.read<PatientCubit>().update(
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
                  context.read<PatientCubit>().delete(
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
