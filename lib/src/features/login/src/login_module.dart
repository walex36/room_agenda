import 'package:flutter_modular/flutter_modular.dart';
import 'package:room_agenda/src/features/login/login.dart';
import 'package:room_agenda/src/features/login/src/pages/login_page.dart';

class LoginModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind((i) => LoginProvider(
              signInUseCase: i(),
            )),
        Bind((i) => SignInUseCase(repository: i())),
        Bind((i) => LoginRepository(loginRemoteDatasource: i())),
        Bind((i) => LoginFirebaseDatasource()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => const LoginPage(),
        )
      ];
}
