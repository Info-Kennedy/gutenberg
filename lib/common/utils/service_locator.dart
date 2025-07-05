import 'package:gutenberg/common/common.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  // Register PreferencesRepository
  getIt.registerSingleton<PreferencesRepository>(PreferencesRepository());
  //Register DIO
  getIt.registerSingleton<Dio>(Dio());
  //Register ApiRepository
  getIt.registerSingleton<ApiRepository>(ApiRepository(getIt<Dio>(), getIt<PreferencesRepository>()));
  //Register ThemeCubit
  getIt.registerSingleton<ThemeCubit>(ThemeCubit(getIt<PreferencesRepository>()));
}
