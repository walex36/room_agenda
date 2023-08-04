import 'package:result_dart/result_dart.dart';
import 'package:room_agenda/src/core/core.dart';
import 'package:room_agenda/src/features/company/company.dart';

class GetCompaniesUsecase extends UseCase<List<Company>, ParamsGetCompanies> {
  final ImpCompanyRepository _companyRepository;

  GetCompaniesUsecase({required ImpCompanyRepository companyRepository})
      : _companyRepository = companyRepository;

  @override
  Future<Result<List<Company>, AppException>> call(
      ParamsGetCompanies params) async {
    return await _companyRepository.getCompanies(cnpjs: params.cnpjs);
  }
}

class ParamsGetCompanies {
  final List<String> cnpjs;

  ParamsGetCompanies({required this.cnpjs});
}
