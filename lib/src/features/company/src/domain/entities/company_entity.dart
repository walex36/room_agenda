// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Company extends Equatable {
  final String hash;
  final String name;
  final String cnpj;
  final List<int> notWorkingDays;

  const Company({
    required this.hash,
    required this.name,
    required this.cnpj,
    required this.notWorkingDays,
  });

  @override
  List<Object?> get props => [hash, name, cnpj, notWorkingDays];

  Company copyWith({
    String? hash,
    String? name,
    String? cnpj,
    List<int>? notWorkingDays,
  }) {
    return Company(
      hash: hash ?? this.hash,
      name: name ?? this.name,
      cnpj: cnpj ?? this.cnpj,
      notWorkingDays: notWorkingDays ?? this.notWorkingDays,
    );
  }
}
