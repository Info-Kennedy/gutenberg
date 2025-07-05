import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gutenberg/app/app.dart';
import 'package:gutenberg/app/app_bloc_observer.dart';
import 'package:gutenberg/common/common.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = const AppBlocObserver();
  await setupLocator();

  // Initialize language for CommonHelper
  final commonHelper = CommonHelper();
  await commonHelper.initializeLanguage();

  // Initialize theme cubit
  final themeCubit = getIt<ThemeCubit>();
  await themeCubit.initializeTheme();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => getIt<PreferencesRepository>()),
        RepositoryProvider<ApiRepository>(create: (context) => getIt<ApiRepository>()),
      ],
      child: const App(),
    ),
  );
}
