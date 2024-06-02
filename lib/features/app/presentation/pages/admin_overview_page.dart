import 'package:clinic/features/app/presentation/pages/appointment_page.dart';
import 'package:clinic/features/app/presentation/pages/doctor_page.dart';
import 'package:clinic/features/app/presentation/pages/patient_page.dart';
import 'package:flutter/material.dart';

class AdminOverviewPage extends StatelessWidget {
  const AdminOverviewPage({super.key});

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
              DoctorPage(editable: true),
              PatientPage(editable: true),
              AppointmentPage(editable: true),
            ],
          ),
        ),
      ),
    );
  }
}
