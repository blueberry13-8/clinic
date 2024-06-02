import 'package:clinic/features/app/presentation/pages/appointment_page.dart';
import 'package:clinic/features/app/presentation/pages/doctor_page.dart';
import 'package:clinic/features/app/presentation/pages/patient_page.dart';
import 'package:flutter/material.dart';

class UserOverviewPage extends StatelessWidget {
  const UserOverviewPage({super.key, required this.login});

  final String login;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabAlignment: TabAlignment.center,
            tabs: [
              Tab(
                child: Text('Врачи'),
              ),
              Tab(
                child: Text('Пациенты'),
              ),
              Tab(
                child: Text('Записи к врачам'),
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
              DoctorPage(editable: false),
              PatientPage(editable: false),
              AppointmentPage(editable: false),
            ],
          ),
        ),
      ),
    );
  }
}
