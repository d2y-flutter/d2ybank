import 'package:equatable/equatable.dart';

class KycFormEntity extends Equatable {
  final String nik;
  final String fullName;
  final String placeOfBirth;
  final DateTime dateOfBirth;
  final String address;
  final String gender;
  final String religion;
  final bool acceptedStatement;

  const KycFormEntity({
    required this.nik,
    required this.fullName,
    required this.placeOfBirth,
    required this.dateOfBirth,
    required this.address,
    required this.gender,
    required this.religion,
    required this.acceptedStatement,
  });

  @override
  List<Object?> get props => [
        nik,
        fullName,
        placeOfBirth,
        dateOfBirth,
        address,
        gender,
        religion,
        acceptedStatement,
      ];
}