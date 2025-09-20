import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:pagination_in_details/service_locator.config.dart';

final injector = GetIt.instance;
@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureDependencies() => injector.init();
