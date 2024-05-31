import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinic/features/app/domain/models/doctor.dart';
import '../../bloc/department/doctor_cubit.dart';

class DoctorTable extends StatelessWidget {
  const DoctorTable({
    super.key,
    required this.departments,
    this.selectedIndex,
    this.editable = true,
  });

  final List<Doctor> departments;

  final int? selectedIndex;

  final bool editable;

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 12,
      minWidth: 600,
      showCheckboxColumn: false,
      columns: editable ? kDoctorFields.map((e) => DataColumn2(label: Text(e),),).toList():
      kDoctorFields.sublist(1).map((e) => DataColumn2(label: Text(e),),).toList(),
      rows: departments.asMap().entries.map(
            (entry) {
          final index = entry.key;
          final item = entry.value;
          return DataRow(
            selected: selectedIndex == index,
            onSelectChanged: (selected) {
              if (selected != null && selected) {
                context.read<DoctorCubit>().selectDoctor(index);
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
                Text(item.),
              ),
            ],
          );
        },
      ).toList(),
    );
  }
}
