import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gutenberg/common/common.dart';

class ThemeToggleWidget extends StatelessWidget {
  const ThemeToggleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, String>(
      bloc: getIt<ThemeCubit>(),
      builder: (context, currentThemeMode) {
        final isSystemDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
        final isDarkMode = currentThemeMode == ThemeConfig.SYSTEM ? isSystemDark : currentThemeMode == ThemeConfig.DARK;

        return PopupMenuButton<String>(
          icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode, color: Theme.of(context).colorScheme.onSurface),
          onSelected: (String themeMode) async {
            final themeCubit = getIt<ThemeCubit>();
            switch (themeMode) {
              case ThemeConfig.LIGHT:
                await themeCubit.setLightTheme();
                break;
              case ThemeConfig.DARK:
                await themeCubit.setDarkTheme();
                break;
              case ThemeConfig.SYSTEM:
                await themeCubit.setSystemTheme();
                break;
            }
          },
          itemBuilder: (BuildContext context) => [
            PopupMenuItem<String>(
              value: ThemeConfig.LIGHT,
              child: Row(
                children: [
                  Icon(Icons.light_mode, color: currentThemeMode == ThemeConfig.LIGHT ? Theme.of(context).colorScheme.primary : null),
                  const SizedBox(width: 8),
                  Text('Light Theme'),
                  if (currentThemeMode == ThemeConfig.LIGHT) const Spacer(),
                  if (currentThemeMode == ThemeConfig.LIGHT) Icon(Icons.check, color: Theme.of(context).colorScheme.primary),
                ],
              ),
            ),
            PopupMenuItem<String>(
              value: ThemeConfig.DARK,
              child: Row(
                children: [
                  Icon(Icons.dark_mode, color: currentThemeMode == ThemeConfig.DARK ? Theme.of(context).colorScheme.primary : null),
                  const SizedBox(width: 8),
                  Text('Dark Theme'),
                  if (currentThemeMode == ThemeConfig.DARK) const Spacer(),
                  if (currentThemeMode == ThemeConfig.DARK) Icon(Icons.check, color: Theme.of(context).colorScheme.primary),
                ],
              ),
            ),
            PopupMenuItem<String>(
              value: ThemeConfig.SYSTEM,
              child: Row(
                children: [
                  Icon(Icons.settings_system_daydream, color: currentThemeMode == ThemeConfig.SYSTEM ? Theme.of(context).colorScheme.primary : null),
                  const SizedBox(width: 8),
                  Text('System Theme'),
                  if (currentThemeMode == ThemeConfig.SYSTEM) const Spacer(),
                  if (currentThemeMode == ThemeConfig.SYSTEM) Icon(Icons.check, color: Theme.of(context).colorScheme.primary),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Animated theme toggle switch with sun and moon icons
class AnimatedThemeToggle extends StatefulWidget {
  const AnimatedThemeToggle({super.key});

  @override
  State<AnimatedThemeToggle> createState() => _AnimatedThemeToggleState();
}

class _AnimatedThemeToggleState extends State<AnimatedThemeToggle> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);

    _rotationAnimation = Tween<double>(begin: 0.0, end: 0.5).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, String>(
      bloc: getIt<ThemeCubit>(),
      builder: (context, currentThemeMode) {
        final isSystemDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
        final isDarkMode = currentThemeMode == ThemeConfig.SYSTEM ? isSystemDark : currentThemeMode == ThemeConfig.DARK;

        return GestureDetector(
          onTap: () async {
            // Start animation
            _animationController.forward().then((_) {
              _animationController.reverse();
            });

            // Toggle theme
            final themeCubit = getIt<ThemeCubit>();
            if (currentThemeMode == ThemeConfig.SYSTEM) {
              // If on system theme, switch to the opposite of current system appearance
              final newTheme = isSystemDark ? ThemeConfig.LIGHT : ThemeConfig.DARK;
              await themeCubit.updateThemeMode(newTheme);
            } else {
              await themeCubit.toggleTheme();
            }
          },
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  width: 60,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: isDarkMode ? [const Color(0xFF2C3E50), const Color(0xFF34495E)] : [const Color(0xFFF39C12), const Color(0xFFE67E22)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isDarkMode ? Colors.black.withValues(alpha: 0.3) : Colors.orange.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      // Sun icon (left side)
                      Positioned(
                        left: 8,
                        top: 0,
                        bottom: 0,
                        child: Center(
                          child: Transform.rotate(
                            angle: _rotationAnimation.value * 2 * 3.14159,
                            child: Icon(Icons.wb_sunny, size: 16, color: isDarkMode ? Colors.white.withValues(alpha: 0.3) : Colors.white),
                          ),
                        ),
                      ),
                      // Moon icon (right side)
                      Positioned(
                        right: 8,
                        top: 0,
                        bottom: 0,
                        child: Center(
                          child: Transform.rotate(
                            angle: -_rotationAnimation.value * 2 * 3.14159,
                            child: Icon(Icons.nightlight_round, size: 16, color: isDarkMode ? Colors.white : Colors.white.withValues(alpha: 0.3)),
                          ),
                        ),
                      ),
                      // Animated toggle circle
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        left: isDarkMode ? 32 : 2,
                        top: 2,
                        child: Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 4, offset: const Offset(0, 2))],
                          ),
                          child: Center(
                            child: Icon(
                              isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
                              size: 14,
                              color: isDarkMode ? const Color(0xFF2C3E50) : const Color(0xFFF39C12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

/// Simple theme toggle button that switches between light and dark
class SimpleThemeToggle extends StatelessWidget {
  const SimpleThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, String>(
      bloc: getIt<ThemeCubit>(),
      builder: (context, currentThemeMode) {
        final isSystemDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
        final isDarkMode = currentThemeMode == ThemeConfig.SYSTEM ? isSystemDark : currentThemeMode == ThemeConfig.DARK;

        return IconButton(
          icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode, color: Theme.of(context).colorScheme.onSurface),
          onPressed: () async {
            await getIt<ThemeCubit>().toggleTheme();
          },
          tooltip: 'Toggle Theme',
        );
      },
    );
  }
}
