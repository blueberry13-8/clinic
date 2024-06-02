// import 'package:cinema/features/app/presentation/pages/position_page.dart';
// import 'package:cinema/features/app/presentation/pages/salary_payments_page.dart';
import 'package:clinic/features/app/presentation/pages/doctor_page.dart';
import 'package:clinic/features/app/presentation/pages/patient_page.dart';
import 'package:flutter/material.dart';

class UserOverviewPage extends StatelessWidget {
  const UserOverviewPage({super.key, required this.login});

  final String login;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
              // Tab(
              //   child: Text('Выплаты'),
              // ),
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
              // const DepartmentPage(editable: false),
              // // const UserPositionsPage(),
              // const PositionsPage(editable: false),
              // SalaryPaymentsPage(employeeId: login, editable: false),
              //UserTicketsPage(login: login),
              DoctorPage(editable: false),
              PatientPage(editable: false),
            ],
          ),
        ),
      ),
    );
  }
}
