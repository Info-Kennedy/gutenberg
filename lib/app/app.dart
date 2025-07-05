import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gutenberg/common/common.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'routes.dart';
import 'package:go_router/go_router.dart';

final GoRouter _router = Routes().router;

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, String>(
      bloc: getIt<ThemeCubit>(),
      builder: (context, themeMode) {
        final uiHelper = UiHelper();
        final isSystemDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
        final effectiveThemeMode = themeMode == ThemeConfig.SYSTEM ? (isSystemDark ? ThemeConfig.DARK : ThemeConfig.LIGHT) : themeMode;
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: _router,
          theme: uiHelper.themeData(effectiveThemeMode),
          restorationScopeId: 'app',
          title: 'Gutenberg',
          builder: (context, child) => ResponsiveBreakpoints.builder(
            child: child!,
            breakpoints: [
              const Breakpoint(start: 375, end: 450, name: MOBILE),
              const Breakpoint(start: 451, end: 800, name: TABLET),
              const Breakpoint(start: 801, end: 1920, name: DESKTOP),
              const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
            ],
          ),
        );
      },
    );
  }
}
