import 'package:clinic/features/app/domain/models/appointment.dart';
import 'package:clinic/features/app/presentation/bloc/appointment/appointment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../my_form_field.dart';

class MyEditingAppointmentTable extends StatefulWidget {
  const MyEditingAppointmentTable({
    super.key,
    required this.fields,
    this.item,
    required this.editable,
  });

  final Appointment? item;
  final List<String> fields;
  final bool editable;

  @override
  State<MyEditingAppointmentTable> createState() =>
      _MyEditingAppointmentTableState();
}

class _MyEditingAppointmentTableState extends State<MyEditingAppointmentTable> {
  @override
  void initState() {
    super.initState();
    if (widget.item == null) {
      _item = Appointment(
        id: 0,
        doctorId: 0,
        patientId: 0,
        appointmentTime: DateTime.now(),
        room: '0',
        status: "Ожидает назначения",
      );
    } else {
      _item = widget.item!;
    }
  }

  late Appointment _item;

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
          value: widget.item?.appointmentTime,
          onChanged: (newValue) =>
              _item = _item.copyWith(appointmentTime: DateTime.parse(newValue)),
          editable: widget.editable,
        ),
        MyFormField(
          enabled: widget.editable,
          fieldName: widget.fields[4],
          value: widget.item?.room,
          onChanged: (newValue) => _item = _item.copyWith(room: newValue),
          editable: widget.editable,
        ),
        MyFormField(
          enabled: widget.editable,
          fieldName: widget.fields[5],
          value: widget.item?.status,
          onChanged: (newValue) => _item = _item.copyWith(status: newValue),
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
                  context.read<AppointmentCubit>().update(
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
                  context.read<AppointmentCubit>().delete(
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
