import 'package:clinic/features/app/domain/models/medical_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/medical_history/medical_history_cubit.dart';
import '../widgets/medical_history/medical_history_table.dart';
import '../widgets/medical_history/my_editing_medical_history_widget.dart';

class MedicalHistoryPage extends StatelessWidget {
  const MedicalHistoryPage({
    super.key,
    required this.editable, this.login, this.role,
  });

  final bool editable;
  final String? login;
  final String? role;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MedicalHistoryCubit()..load(),
      child: _MedicalHistoryPage(
        key: key,
        editable: editable,
        login: login,
        role: role,
      ),
    );
  }
}

class _MedicalHistoryPage extends StatefulWidget {
  const _MedicalHistoryPage({super.key, required this.editable, this.login, this.role});

  final bool editable;
  final String? login;
  final String? role;

  @override
  State<_MedicalHistoryPage> createState() => _MedicalHistoryPageState();
}

class _MedicalHistoryPageState extends State<_MedicalHistoryPage> {
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

  List<MedicalHistory> filtered(List<MedicalHistory> items, String? query) {
    if (widget.role == 'Пациент' && widget.login != null) {
      items = items
          .where((element) => element.patientId == int.parse(widget.login!))
          .toList();
    } else if (widget.role == 'Врач' && widget.login != null) {
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
    final state = context.watch<MedicalHistoryCubit>().state;
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
                    context.read<MedicalHistoryCubit>().select(-1);
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
                  child: MedicalHistoryTable(
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
                    child: MyEditingMedicalHistoryTable(
                      item: state.selectedIndex! >= 0 &&
                              state.selectedIndex! < state.items.length
                          ? filtered(state.items, _searchController.text)[state.selectedIndex!]
                          : null,
                      fields: kMedicalHistoryFields,
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
