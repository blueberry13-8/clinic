import 'package:clinic/features/app/domain/models/appointment.dart';
import 'package:clinic/features/app/presentation/bloc/appointment/appointment_cubit.dart';
import 'package:clinic/features/app/presentation/widgets/appointment/appointment_table.dart';
import 'package:clinic/features/app/presentation/widgets/appointment/my_editing_appointment_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentPage extends StatelessWidget {
  const AppointmentPage({
    super.key,
    required this.editable,
    this.login,
    this.role,
  });

  final bool editable;
  final String? login;
  final String? role;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppointmentCubit()..load(),
      child: _AppointmentPage(
        key: key,
        editable: editable,
        login: login,
        role: role,
      ),
    );
  }
}

class _AppointmentPage extends StatefulWidget {
  const _AppointmentPage(
      {super.key, required this.editable, this.login, this.role});

  final bool editable;
  final String? login;
  final String? role;

  @override
  State<_AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<_AppointmentPage> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Appointment> filtered(List<Appointment> items, String? query) {
    if (widget.role == 'Пациент' && widget.login != null) {
      items = items
          .where((element) => element.patientId == int.parse(widget.login!))
          .toList();
    } else if (widget.login != null) {
      items = items
          .where((element) => element.doctorId == int.parse(widget.login!))
          .toList();
    }
    if (query == null) return items;
    return items
        .where(
          (element) => element.id.toString().toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppointmentCubit>().state;
    if (state case Success state) {
      return Stack(
        children: [
          if (widget.editable)
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  onPressed: () {
                    context.read<AppointmentCubit>().select(-1);
                  },
                  child: const Icon(Icons.add),
                ),
              ),
            ),
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 80.0,
                    vertical: 10,
                  ),
                  child: TextFormField(
                    controller: _searchController,
                    onChanged: (newValue) => setState(() {}),
                    decoration: const InputDecoration(
                      hintText: 'Поиск...',
                      icon: Icon(
                        Icons.search,
                      ),
                    ),
                  ),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 400),
                  child: AppointmentTable(
                    items: filtered(state.items, _searchController.text),
                    selectedIndex: state.selectedIndex,
                    editable: widget.editable,
                  ),
                ),
                if (state.selectedIndex != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 150.0,
                      vertical: 20,
                    ),
                    child: MyEditingAppointmentTable(
                      item: state.selectedIndex! >= 0 &&
                              state.selectedIndex! < state.items.length
                          ? state.items[state.selectedIndex!]
                          : null,
                      fields: kAppointmentFields,
                      editable: widget.editable,
                    ),
                  ),
              ],
            ),
          ),
        ],
      );
    } else if (state case Loading || Initial) {
      return const CircularProgressIndicator();
    } else {
      return const Center(
        child: Text('Error'),
      );
    }
  }
}
