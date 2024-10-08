import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:clinic/features/app/domain/models/patient.dart';
import 'package:clinic/features/app/presentation/bloc/patient/patient_cubit.dart';
import 'package:clinic/features/app/presentation/widgets/patient/my_editing_patient_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/patient/patient_table.dart';

class PatientPage extends StatelessWidget {
  const PatientPage({
    super.key,
    required this.editable,
  });

  final bool editable;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PatientCubit()..load(),
      child: _PatientPage(
        key: key,
        editable: editable,
      ),
    );
  }
}

class _PatientPage extends StatefulWidget {
  const _PatientPage({super.key, required this.editable});

  final bool editable;

  @override
  State<_PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<_PatientPage> {
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

  List<Patient> filtered(List<Patient> items, String? query) {
    if (query == null) return items;
    return items
        .where(
          (element) => element.fullName.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<PatientCubit, PatientEvent>(
      listener: (context, event) {
        if (event case FailedToAddUser event) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(event.message),
            ),
          );
        }
      },
      child: BlocBuilder<PatientCubit, PatientState>(
        builder: (context, state) {
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
                          context.read<PatientCubit>().select(-1);
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
                        child: PatientTable(
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
                          child: MyEditingPatientTable(
                            item: state.selectedIndex! >= 0 &&
                                    state.selectedIndex! < state.items.length
                                ? state.items[state.selectedIndex!]
                                : null,
                            fields: kPatientFields,
                            editable: widget.editable,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state case Loading() || Initial()) {
            return const CircularProgressIndicator();
          } else {
            return const Center(
              child: Text('Error'),
            );
          }
        },
      ),
    );
  }
}
