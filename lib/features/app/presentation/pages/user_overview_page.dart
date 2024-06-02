import 'package:clinic/features/app/presentation/pages/appointment_page.dart';
import 'package:clinic/features/app/presentation/pages/doctor_page.dart';
import 'package:clinic/features/app/presentation/pages/medical_history_page.dart';
import 'package:clinic/features/app/presentation/pages/patient_page.dart';
import 'package:flutter/material.dart';

class UserOverviewPage extends StatelessWidget {
  const UserOverviewPage({
    super.key,
    required this.login,
    required this.role,
  });

  final String login;
  final String role;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('ID: $login, Роль: $role'),
          bottom: TabBar(
            tabAlignment: TabAlignment.center,
            tabs: [
              role == 'Пациент'
                  ? const Tab(
                      child: Text('Врачи'),
                    )
                  : const Tab(
                      child: Text('Пациенты'),
                    ),
              const Tab(
                child: Text('Записи к врачам'),
              ),
              const Tab(
                child: Text('История болезней'),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 0,
            vertical: 0,
          ),
          child: TabBarView(
            children: [
              role == 'Пациент'
                  ? const DoctorPage(editable: false)
                  : const PatientPage(editable: false),
              AppointmentPage(
                editable: false,
                login: login,
                role: role,
              ),
              MedicalHistoryPage(
                editable: false,
                login: login,
                role: role,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
