import 'package:clinic/features/app/domain/models/doctor.dart';
import 'package:clinic/features/app/presentation/bloc/doctor/doctor_cubit.dart';
import 'package:clinic/features/app/presentation/widgets/doctor/my_editing_doctor_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../widgets/doctor/doctor_table.dart';

class DoctorPage extends StatelessWidget {
  const DoctorPage({
    super.key,
    required this.editable,
  });

  final bool editable;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorCubit()..load(),
      child: _DoctorsPage(
        key: key,
        editable: editable,
      ),
    );
  }
}

class _DoctorsPage extends StatefulWidget {
  const _DoctorsPage({super.key, required this.editable});

  final bool editable;

  @override
  State<_DoctorsPage> createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<_DoctorsPage> {
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

  List<Doctor> filtered(List<Doctor> items, String? query) {
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
    final state = context.watch<DoctorCubit>().state;
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
                    context.read<DoctorCubit>().select(-1);
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
                  child: DoctorTable(
                    items:
                        filtered(state.items, _searchController.text),
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
                    child: MyEditingDoctorTable(
                      item: state.selectedIndex! >= 0 &&
                              state.selectedIndex! <
                                  state.items.length
                          ? state.items[state.selectedIndex!]
                          : null,
                      fields: kDoctorFields,
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
