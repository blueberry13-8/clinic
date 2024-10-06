import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:clinic/features/app/domain/models/doctor.dart';
import 'package:clinic/features/app/presentation/bloc/doctor/doctor_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../my_form_field.dart';

class MyEditingDoctorTable extends StatefulWidget {
  const MyEditingDoctorTable({
    super.key,
    required this.fields,
    this.item,
    required this.editable,
  });

  final Doctor? item;
  final List<String> fields;
  final bool editable;

  @override
  State<MyEditingDoctorTable> createState() =>
      _MyEditingDoctorTableState();
}

class _MyEditingDoctorTableState extends State<MyEditingDoctorTable> {
  @override
  void initState() {
    super.initState();
    if (widget.item == null) {
      _item = const Doctor(
        id: -1,
        fullName: '',
        specialty: '',
        workingHours: '',
        contactNumber: '',
        password: '',
      );
    } else {
      _item = widget.item!;
    }
  }

  late Doctor _item;

  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<DoctorCubit, DoctorEvent>(
      listener: (_, event) {
        if (event case FailedToAddUser event) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(event.message),
            ),
          );
        }
      },
      child: Column(
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
            value: widget.item?.fullName,
            onChanged: (newValue) =>
            _item = _item.copyWith(fullName: newValue),
            editable: widget.editable,
          ),
          MyFormField(
            enabled: widget.editable,
            fieldName: widget.fields[2],
            value: widget.item?.specialty,
            onChanged: (newValue) =>
            _item = _item.copyWith(specialty: newValue),
            editable: widget.editable,
          ),
          MyFormField(
            enabled: widget.editable,
            fieldName: widget.fields[3],
            value: widget.item?.workingHours,
            onChanged: (newValue) =>
            _item = _item.copyWith(workingHours: newValue),
            editable: widget.editable,
          ),
          MyFormField(
            enabled: widget.editable,
            fieldName: widget.fields[4],
            value: widget.item?.contactNumber,
            onChanged: (newValue) =>
            _item = _item.copyWith(contactNumber: newValue),
            editable: widget.editable,
          ),
          MyFormField(
            enabled: widget.editable,
            fieldName: widget.fields[5],
            value: widget.item?.password,
            onChanged: (newValue) =>
            _item = _item.copyWith(password: newValue),
            editable: widget.editable,
            isPassword: true,
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
                    context.read<DoctorCubit>().update(
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
                    context.read<DoctorCubit>().delete(
                      widget.item!,
                    );
                  }
                },
                child: const Text('Удалить'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
