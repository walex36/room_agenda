import 'package:result_dart/result_dart.dart';
import 'package:room_agenda/src/core/src/exceptions/app_exception.dart';

import '../../../company.dart';

class CompanyRepository implements ImpCompanyRepository {
  final ImpCompanyRemoteDatasource _remoteDatasource;

  CompanyRepository({required ImpCompanyRemoteDatasource remoteDatasource})
      : _remoteDatasource = remoteDatasource;

  @override
  Future<Result<List<Company>, AppException>> getCompanies(
      {required List<String> cnpjs}) async {
    try {
      final listCompanysModel =
          await _remoteDatasource.getCompanies(cnpjs: cnpjs);

      return Success(
          listCompanysModel.map((company) => company.toEntity()).toList());
    } on RemoteException catch (e) {
      return Failure(e);
    }
  }

  @override
  Future<Result<bool, AppException>> updateCompany(
      {required Company company}) async {
    try {
      final result = await _remoteDatasource.updateCompany(
          company: CompanyModel.fromEntity(company));

      return Success(result);
    } on RemoteException catch (e) {
      return Failure(e);
    }
  }
}
