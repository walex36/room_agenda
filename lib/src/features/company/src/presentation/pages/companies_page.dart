import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:room_agenda/src/core/core.dart';
import 'package:room_agenda/src/features/company/src/presentation/controller/companies_provider.dart';
import 'package:room_agenda/src/features/login/login.dart';

class CompaniesPage extends StatefulWidget {
  final Usuario usuario;
  const CompaniesPage({super.key, required this.usuario});

  @override
  State<CompaniesPage> createState() => _CompaniesPageState();
}

class _CompaniesPageState extends State<CompaniesPage> {
  final companiesProvider = Modular.get<CompaniesProvider>();

  @override
  void initState() {
    super.initState();
    companiesProvider.getCompanies(usuario: widget.usuario);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ChangeNotifierProvider<CompaniesProvider>(
      create: (context) => companiesProvider,
      child: Consumer<CompaniesProvider>(
        builder: (context, provider, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: provider.companies.map((company) {
                return ElevatedButton(
                  onPressed: () => Modular.to.pushNamed(RouterConst.rooms(),
                      arguments: {'company': company}),
                  child: Text(company.name),
                );
              }).toList(),
            ),
          );
        },
      ),
    ));
  }
}
