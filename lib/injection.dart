import 'package:get_it/get_it.dart';
import 'package:hello_ddd/injection.config.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
void configureInjection(String env) => getIt.init(environment: env);
