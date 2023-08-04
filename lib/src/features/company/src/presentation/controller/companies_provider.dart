import 'package:flutter/material.dart';
import 'package:room_agenda/src/features/company/company.dart';
import 'package:room_agenda/src/features/company/src/domain/usecases/get_companies_usecase.dart';
import 'package:room_agenda/src/features/login/login.dart';

class CompaniesProvider extends ChangeNotifier {
  final GetCompaniesUsecase _getCompaniesUsecase;

  CompaniesProvider({
    required GetCompaniesUsecase getCompaniesUsecase,
  }) : _getCompaniesUsecase = getCompaniesUsecase;

  bool isLoading = false;
  List<Company> companies = [];

  void getCompanies({required Usuario usuario}) async {
    isLoading = true;
    notifyListeners();

    final companiesOrFailure = await _getCompaniesUsecase
        .call(ParamsGetCompanies(cnpjs: usuario.cnpjs));

    companiesOrFailure.fold(
      (companies) {
        this.companies = companies;
      },
      (failure) {
        print(failure);
      },
    );
    notifyListeners();
  }
}
