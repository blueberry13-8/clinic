import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinic/features/app/domain/models/patient.dart';
import '../../bloc/patient/patient_cubit.dart';

class PatientTable extends StatelessWidget {
  const PatientTable({
    super.key,
    required this.items,
    this.selectedIndex,
    this.editable = true,
  });

  final List<Patient> items;

  final int? selectedIndex;

  final bool editable;

  @override
  Widget build(BuildContext context) {
    final patientFields = kPatientFields.sublist(0, kPatientFields.length - 1);
    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 12,
      minWidth: 600,
      showCheckboxColumn: false,
      columns: editable ? patientFields.map((e) => DataColumn2(label: Text(e),),).toList():
      patientFields.sublist(1).map((e) => DataColumn2(label: Text(e),),).toList(),
      rows: items.asMap().entries.map(
            (entry) {
          final index = entry.key;
          final item = entry.value;
          return DataRow(
            selected: selectedIndex == index,
            onSelectChanged: (selected) {
              if (selected != null && selected) {
                context.read<PatientCubit>().select(index);
              }
            },
            cells: [
              if (editable)
                DataCell(
                  Text('${item.id}'),
                ),
              DataCell(
                Text(item.fullName),
              ),
              DataCell(
                Text(item.age.toString()),
              ),
              DataCell(
                Text(item.contactNumber),
              ),
              DataCell(
                Text(item.address),
              ),
              DataCell(
                Text(item.gender),
              ),
            ],
          );
        },
      ).toList(),
    );
  }
}
