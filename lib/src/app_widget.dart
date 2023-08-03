import 'package:room_agenda/src/core/src/const/router_const.dart';

import 'app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute(RouterConst.login());
    return ModularApp(
      module: AppModule(),
      child: MaterialApp.router(
        title: 'Agenda Clinica',
        builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!),
        theme: ThemeData(
          useMaterial3: true,
        ),
        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [Locale('pt', 'BR')],
      ),
    );
  }
}
