import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:logger/logger.dart';
import 'package:postgres/postgres.dart';

import '../../../../common/exceptions/database_exception.dart';
import '../models/appointment.dart';
import '../models/doctor.dart';
import '../models/medical_history.dart';
import '../models/patient.dart';

class Database {
  static final Database _db = Database._privateConstructor();

  Database._privateConstructor();

  // TODO: Use data for current database
  final String user = 'postgres',
      password = 'postgres',
      host = 'localhost',
      database = 'clinic_registry';

  Connection? conn;
  var logger = Logger();

  factory Database() {
    return _db;
  }

  Future<Connection> connect() async {
    if (this.conn != null) {
      // logger.i("Connected to DB");
      return this.conn!;
    }
    // logger.i("Starting connection to DB");
    final Connection conn;
    try {
      conn = await Connection.open(
        Endpoint(
          host: host,
          database: database,
          username: user,
          password: password,
        ),
        settings: const ConnectionSettings(sslMode: SslMode.disable),
      );
    } catch (e, stackTrace) {
      logger.e('Unable to connect to DB', error: e, stackTrace: stackTrace);
      rethrow;
    }
    logger.d('Connected to DB');
    this.conn = conn;
    return conn;
  }

  Future<(int?, String)> login(String contactNumber, String password) async {
    await connect();
    var hashedPassword = md5.convert(utf8.encode(password)).toString();
    Result result;

    result = await conn!.execute(
      r'SELECT * FROM Patient WHERE contact_number=$1 and password=$2',
      parameters: [contactNumber, hashedPassword],
    );
    if (result.length == 1) return (result.firstOrNull?.first as int?, 'Пациент');
    result = await conn!.execute(
      r'SELECT * FROM Doctor WHERE contact_number=$1 and password=$2',
      parameters: [contactNumber, hashedPassword],
    );
    if (result.length == 1) return (result.firstOrNull?.first as int?, 'Врач');
    return (null, '');
  }

  /// Patient
  Future<List<Patient>> getPatients() async {
    await connect();
    var query = 'SELECT * FROM Patient';
    final result = await conn!.execute(
      query,
    );
    List<Patient> items = [];
    for (int i = 0; i < result.length; i++) {
      items.add(
        Patient(
          id: result[i][0] as int,
          fullName: result[i][1] as String,
          age: result[i][2] as int,
          contactNumber: result[i][3] as String,
          address: result[i][4] as String,
          gender: result[i][5] as String,
          password: result[i][6] as String,
        ),
      );
    }
    return items;
  }

  Future<bool> isContactNumberOccupied(String contactNumber) async {
    final resultPatient = await conn!.execute(
      r'SELECT COUNT(*) FROM Patient WHERE contact_number = $1',
      parameters: [contactNumber],
    );
    final resultDoctor = await conn!.execute(
      r'SELECT COUNT(*) FROM Doctor WHERE contact_number = $1',
      parameters: [contactNumber],
    );
    return (resultPatient.first.first! as int) > 0 ||
        (resultDoctor.first.first! as int) > 0;
  }

  Future<void> addPatient(Patient item) async {
    await connect();
    if (await isContactNumberOccupied(item.contactNumber)) {
      throw DatabaseException("Номер телефона занят");
    }
    final hashedPassword = md5.convert(utf8.encode(item.password)).toString();
    await conn!.execute(
      r'INSERT INTO Patient (full_name, age, contact_number, address, gender, password) VALUES ($1, $2, $3, $4, $5, $6)',
      parameters: [
        item.fullName,
        item.age,
        item.contactNumber,
        item.address,
        item.gender,
        hashedPassword,
      ],
    );
  }

  Future<void> deletePatient(Patient item) async {
    await connect();
    await conn!.execute(
      r'DELETE FROM Patient WHERE id=$1',
      parameters: [item.id],
    );
  }

  Future<void> updatePatient(Patient item) async {
    await connect();
    final hashedPassword = md5.convert(utf8.encode(item.password)).toString();
    await conn!.execute(
      r'UPDATE Patient SET full_name=$1, age=$2, contact_number=$3, address=$4, gender=$5, password=$6 WHERE id=$7',
      parameters: [
        item.fullName,
        item.age,
        item.contactNumber,
        item.address,
        item.gender,
        hashedPassword,
        item.id
      ],
    );
  }

  /// Doctor
  Future<List<Doctor>> getDoctors() async {
    await connect();
    var query = 'SELECT * FROM Doctor';
    final result = await conn!.execute(
      query,
    );
    List<Doctor> items = [];
    for (int i = 0; i < result.length; i++) {
      items.add(
        Doctor(
          id: result[i][0] as int,
          fullName: result[i][1] as String,
          specialty: result[i][2] as String,
          workingHours: result[i][3] as String,
          contactNumber: result[i][4] as String,
          password: result[i][5] as String,
        ),
      );
    }
    return items;
  }

  Future<void> addDoctor(Doctor item) async {
    await connect();
    if (await isContactNumberOccupied(item.contactNumber)) {
      logger.e("Номер телефона занят");
      throw DatabaseException("Номер телефона занят");
    }
    final hashedPassword = md5.convert(utf8.encode(item.password)).toString();
    await conn!.execute(
      r'INSERT INTO Doctor (full_name, specialty, working_hours, contact_number, password) VALUES ($1, $2, $3, $4, $5)',
      parameters: [
        item.fullName,
        item.specialty,
        item.workingHours,
        item.contactNumber,
        hashedPassword,
      ],
    );
  }

  Future<void> deleteDoctor(Doctor item) async {
    await connect();
    await conn!.execute(
      r'DELETE FROM Doctor WHERE id=$1',
      parameters: [item.id],
    );
  }

  Future<void> updateDoctor(Doctor item) async {
    await connect();
    final hashedPassword = md5.convert(utf8.encode(item.password)).toString();
    await conn!.execute(
      r'UPDATE Doctor SET full_name=$1, specialty=$2, working_hours=$3, contact_number=$4, password=$5 WHERE id=$6',
      parameters: [
        item.fullName,
        item.specialty,
        item.workingHours,
        item.contactNumber,
        hashedPassword,
        item.id
      ],
    );
  }

  /// Appointment
  Future<List<Appointment>> getAppointments(
      {int? patientId, int? doctorId}) async {
    await connect();
    var query = 'SELECT * FROM Appointment';
    if (patientId != null) {
      query = 'SELECT * FROM Appointment WHERE patient_id=$patientId';
    }
    if (doctorId != null) {
      query = 'SELECT * FROM Appointment WHERE doctor_id=$doctorId';
    }
    final result = await conn!.execute(
      query,
    );
    List<Appointment> items = [];
    for (int i = 0; i < result.length; i++) {
      items.add(
        Appointment(
          id: result[i][0] as int,
          doctorId: result[i][1] as int,
          patientId: result[i][2] as int,
          appointmentTime: result[i][3] as DateTime,
          room: result[i][4] as String,
          status: result[i][5] as String,
        ),
      );
    }
    return items;
  }

  Future<void> addAppointment(Appointment item) async {
    await connect();
    await conn!.execute(
      r'INSERT INTO Appointment (doctor_id, patient_id, appointment_time, room, status) VALUES ($1, $2, $3, $4, $5)',
      parameters: [
        item.doctorId,
        item.patientId,
        item.appointmentTime,
        item.room,
        item.status,
      ],
    );
  }

  Future<void> deleteAppointment(Appointment item) async {
    await connect();
    await conn!.execute(
      r'DELETE FROM Appointment WHERE id=$1',
      parameters: [item.id],
    );
  }

  Future<void> updateAppointment(Appointment item) async {
    await connect();
    await conn!.execute(
      r'UPDATE Appointment SET doctor_id=$1, patient_id=$2, appointment_time=$3, room=$4, status=$5 WHERE id=$6',
      parameters: [
        item.doctorId,
        item.patientId,
        item.appointmentTime,
        item.room,
        item.status,
        item.id,
      ],
    );
  }

  /// MedicalHistory
  Future<List<MedicalHistory>> getMedicalHistories(
      {int? patientId, int? doctorId}) async {
    await connect();
    var query = 'SELECT * FROM MedicalHistory';
    if (patientId != null) {
      query = 'SELECT * FROM MedicalHistory WHERE patient_id=$patientId';
    }
    if (doctorId != null) {
      query = 'SELECT * FROM MedicalHistory WHERE doctor_id=$doctorId';
    }
    final result = await conn!.execute(
      query,
    );
    List<MedicalHistory> items = [];
    for (int i = 0; i < result.length; i++) {
      items.add(
        MedicalHistory(
          id: result[i][0] as int,
          patientId: result[i][1] as int,
          diagnosisDate: result[i][2] as DateTime,
          doctorId: result[i][3] as int,
          description: result[i][4] as String,
        ),
      );
    }
    return items;
  }

  Future<void> addMedicalHistory(MedicalHistory item) async {
    await connect();
    await conn!.execute(
      r'INSERT INTO MedicalHistory (patient_id, diagnosis_date, doctor_id, description) VALUES ($1, $2, $3, $4)',
      parameters: [
        item.patientId,
        item.diagnosisDate,
        item.doctorId,
        item.description,
      ],
    );
  }

  Future<void> deleteMedicalHistory(MedicalHistory item) async {
    await connect();
    await conn!.execute(
      r'DELETE FROM MedicalHistory WHERE id=$1',
      parameters: [item.id],
    );
  }

  Future<void> updateMedicalHistory(MedicalHistory item) async {
    await connect();
    await conn!.execute(
      r'UPDATE MedicalHistory SET patient_id=$1, diagnosis_date=$2, doctor_id=$3, description=$4 WHERE id=$5',
      parameters: [
        item.patientId,
        item.diagnosisDate,
        item.doctorId,
        item.description,
        item.id,
      ],
    );
  }
}
