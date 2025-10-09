import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'init_di.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<GetIt> initDi(String env) async => await getIt.init(environment: env);
