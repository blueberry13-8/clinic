import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinic/features/app/domain/models/appointment.dart';
import '../../bloc/appointment/appointment_cubit.dart';

class AppointmentTable extends StatelessWidget {
  const AppointmentTable({
    super.key,
    required this.items,
    this.selectedIndex,
    this.editable = true,
  });

  final List<Appointment> items;

  final int? selectedIndex;

  final bool editable;

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 12,
      minWidth: 600,
      showCheckboxColumn: false,
      columns: editable
          ? kAppointmentFields
              .map(
                (e) => DataColumn2(
                  label: Text(e),
                ),
              )
              .toList()
          : kAppointmentFields
              .sublist(1)
              .map(
                (e) => DataColumn2(
                  label: Text(e),
                ),
              )
              .toList(),
      rows: items.asMap().entries.map(
        (entry) {
          final index = entry.key;
          final item = entry.value;
          return DataRow(
            selected: selectedIndex == index,
            onSelectChanged: (selected) {
              if (selected != null && selected) {
                context.read<AppointmentCubit>().select(index);
              }
            },
            cells: [
              if (editable)
                DataCell(
                  Text('${item.id}'),
                ),
              DataCell(
                Text(item.doctorId.toString()),
              ),
              DataCell(
                Text(item.patientId.toString()),
              ),
              DataCell(
                Text(item.appointmentTime.toString()),
              ),
              DataCell(
                Text(item.room),
              ),
              DataCell(
                Text(item.status),
              ),
            ],
          );
        },
      ).toList(),
    );
  }
}
