import 'package:room_agenda/src/features/company/company.dart';

abstract class ImpCompanyRemoteDatasource {
  Future<List<CompanyModel>> getCompanies({
    required List<String> cnpjs,
  });

  Future<bool> updateCompany({
    required CompanyModel company,
  });
}
