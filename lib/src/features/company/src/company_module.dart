import 'package:flutter_modular/flutter_modular.dart';
import 'package:room_agenda/src/features/company/company.dart';
import 'package:room_agenda/src/features/company/src/domain/usecases/get_companies_usecase.dart';
import 'package:room_agenda/src/features/company/src/presentation/controller/companies_provider.dart';
import 'package:room_agenda/src/features/company/src/presentation/pages/companies_page.dart';

class CompanyModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind((i) => CompaniesProvider(
              getCompaniesUsecase: i(),
            )),
        Bind((i) => GetCompaniesUsecase(companyRepository: i())),
        Bind((i) => CompanyRepository(remoteDatasource: i())),
        Bind((i) => CompanyFirebaseDatasource()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => CompaniesPage(
            usuario: args.data['usuario'],
          ),
        )
      ];
}
