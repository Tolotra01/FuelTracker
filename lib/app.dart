import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'providers/app_providers.dart';

class FuelTrackApp extends ConsumerWidget {
  const FuelTrackApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsStreamProvider).value;
    final router = ref.watch(routerProvider);

    final themeMode = switch (settings?.themeMode) {
      1 => ThemeMode.light,
      2 => ThemeMode.dark,
      _ => ThemeMode.system,
    };

    final grandTexte = settings?.grandTexte ?? false;

    return MaterialApp.router(
      title: 'FuelTrack',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      routerConfig: router,
      builder: (context, child) {
        final media = MediaQuery.of(context);
        return MediaQuery(
          data: media.copyWith(
            textScaler: grandTexte
                ? const TextScaler.linear(1.25)
                : media.textScaler,
          ),
          child: child!,
        );
      },
    );
  }
}
