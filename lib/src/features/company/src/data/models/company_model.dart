import 'dart:convert';

import 'package:room_agenda/src/features/company/company.dart';

class CompanyModel extends Company {
  const CompanyModel({
    required String hash,
    required String name,
    required String cnpj,
    required List<int> notWorkingDays,
  }) : super(
          hash: hash,
          name: name,
          cnpj: cnpj,
          notWorkingDays: notWorkingDays,
        );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'hash': hash,
      'name': name,
      'cnpj': cnpj,
      'notWorkingDays': notWorkingDays,
    };
  }

  factory CompanyModel.fromMap(Map<String, dynamic> map) {
    return CompanyModel(
      hash: map['hash'] ?? '',
      name: map['name'] ?? '',
      cnpj: map['cnpj'] ?? '',
      notWorkingDays: List<int>.from((map['notWorkingDays'] ?? [])),
    );
  }

  Company toEntity() {
    return Company(
      hash: hash,
      name: name,
      cnpj: cnpj,
      notWorkingDays: notWorkingDays,
    );
  }

  factory CompanyModel.fromEntity(Company company) {
    return CompanyModel(
      hash: company.hash,
      name: company.name,
      cnpj: company.cnpj,
      notWorkingDays: company.notWorkingDays,
    );
  }

  String toJson() => json.encode(toMap());

  factory CompanyModel.fromJson(String source) =>
      CompanyModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
