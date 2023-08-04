import 'package:result_dart/result_dart.dart';
import 'package:room_agenda/src/core/core.dart';
import 'package:room_agenda/src/features/company/company.dart';

abstract class ImpCompanyRepository {
  Future<Result<List<Company>, AppException>> getCompanies({
    required List<String> cnpjs,
  });

  Future<Result<bool, AppException>> updateCompany({
    required Company company,
  });
}
