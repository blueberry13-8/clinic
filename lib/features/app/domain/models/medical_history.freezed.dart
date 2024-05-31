// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'medical_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MedicalHistory {
  int get id => throw _privateConstructorUsedError;
  int get doctorId => throw _privateConstructorUsedError;
  int get patientId => throw _privateConstructorUsedError;
  DateTime get diagnosisDate => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MedicalHistoryCopyWith<MedicalHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MedicalHistoryCopyWith<$Res> {
  factory $MedicalHistoryCopyWith(
          MedicalHistory value, $Res Function(MedicalHistory) then) =
      _$MedicalHistoryCopyWithImpl<$Res, MedicalHistory>;
  @useResult
  $Res call(
      {int id,
      int doctorId,
      int patientId,
      DateTime diagnosisDate,
      String description});
}

/// @nodoc
class _$MedicalHistoryCopyWithImpl<$Res, $Val extends MedicalHistory>
    implements $MedicalHistoryCopyWith<$Res> {
  _$MedicalHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? doctorId = null,
    Object? patientId = null,
    Object? diagnosisDate = null,
    Object? description = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      doctorId: null == doctorId
          ? _value.doctorId
          : doctorId // ignore: cast_nullable_to_non_nullable
              as int,
      patientId: null == patientId
          ? _value.patientId
          : patientId // ignore: cast_nullable_to_non_nullable
              as int,
      diagnosisDate: null == diagnosisDate
          ? _value.diagnosisDate
          : diagnosisDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MedicalHistoryImplCopyWith<$Res>
    implements $MedicalHistoryCopyWith<$Res> {
  factory _$$MedicalHistoryImplCopyWith(_$MedicalHistoryImpl value,
          $Res Function(_$MedicalHistoryImpl) then) =
      __$$MedicalHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int doctorId,
      int patientId,
      DateTime diagnosisDate,
      String description});
}

/// @nodoc
class __$$MedicalHistoryImplCopyWithImpl<$Res>
    extends _$MedicalHistoryCopyWithImpl<$Res, _$MedicalHistoryImpl>
    implements _$$MedicalHistoryImplCopyWith<$Res> {
  __$$MedicalHistoryImplCopyWithImpl(
      _$MedicalHistoryImpl _value, $Res Function(_$MedicalHistoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? doctorId = null,
    Object? patientId = null,
    Object? diagnosisDate = null,
    Object? description = null,
  }) {
    return _then(_$MedicalHistoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      doctorId: null == doctorId
          ? _value.doctorId
          : doctorId // ignore: cast_nullable_to_non_nullable
              as int,
      patientId: null == patientId
          ? _value.patientId
          : patientId // ignore: cast_nullable_to_non_nullable
              as int,
      diagnosisDate: null == diagnosisDate
          ? _value.diagnosisDate
          : diagnosisDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MedicalHistoryImpl implements _MedicalHistory {
  const _$MedicalHistoryImpl(
      {required this.id,
      required this.doctorId,
      required this.patientId,
      required this.diagnosisDate,
      required this.description});

  @override
  final int id;
  @override
  final int doctorId;
  @override
  final int patientId;
  @override
  final DateTime diagnosisDate;
  @override
  final String description;

  @override
  String toString() {
    return 'MedicalHistory(id: $id, doctorId: $doctorId, patientId: $patientId, diagnosisDate: $diagnosisDate, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MedicalHistoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.doctorId, doctorId) ||
                other.doctorId == doctorId) &&
            (identical(other.patientId, patientId) ||
                other.patientId == patientId) &&
            (identical(other.diagnosisDate, diagnosisDate) ||
                other.diagnosisDate == diagnosisDate) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, doctorId, patientId, diagnosisDate, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MedicalHistoryImplCopyWith<_$MedicalHistoryImpl> get copyWith =>
      __$$MedicalHistoryImplCopyWithImpl<_$MedicalHistoryImpl>(
          this, _$identity);
}

abstract class _MedicalHistory implements MedicalHistory {
  const factory _MedicalHistory(
      {required final int id,
      required final int doctorId,
      required final int patientId,
      required final DateTime diagnosisDate,
      required final String description}) = _$MedicalHistoryImpl;

  @override
  int get id;
  @override
  int get doctorId;
  @override
  int get patientId;
  @override
  DateTime get diagnosisDate;
  @override
  String get description;
  @override
  @JsonKey(ignore: true)
  _$$MedicalHistoryImplCopyWith<_$MedicalHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
