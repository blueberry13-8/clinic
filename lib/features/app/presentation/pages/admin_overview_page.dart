import 'package:clinic/features/app/presentation/pages/doctor_page.dart';
// import 'package:clinic/features/app/presentation/pages/new_employee_page.dart';
// import 'package:clinic/features/app/presentation/pages/position_page.dart';
// import 'package:clinic/features/app/presentation/pages/salary_payments_page.dart';
import 'package:flutter/material.dart';

class AdminOverviewPage extends StatelessWidget {
  const AdminOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabAlignment: TabAlignment.center,
            tabs: [
              Tab(
                child: Text('Врачи'),
              ),
              // Tab(
              //   child: Text('Отделы'),
              // ),
              // Tab(
              //   child: Text('Должности'),
              // ),
              // Tab(
              //   child: Text('Выплаты'),
              // ),
            ],
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 0,
            vertical: 0,
          ),
          child: TabBarView(
            children: [
              // NewEmployeePage(),
              // DepartmentPage(editable: true),
              // PositionsPage(editable: true),
              // SalaryPaymentsPage(editable: true, employeeId: null),
              DoctorPage(editable: true),
            ],
          ),
        ),
      ),
    );
  }
}
