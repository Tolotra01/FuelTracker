import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/local/database.dart';
import '../../features/dashboard/view/dashboard_screen.dart';
import '../../features/depenses/view/depense_form_screen.dart';
import '../../features/depenses/view/depenses_screen.dart';
import '../../features/export/view/export_screen.dart';
import '../../features/maintenance/view/maintenance_form_screen.dart';
import '../../features/maintenance/view/maintenance_screen.dart';
import '../../features/pleins/view/plein_form_screen.dart';
import '../../features/pleins/view/pleins_screen.dart';
import '../../features/settings/view/settings_screen.dart';
import '../../features/shell/main_shell.dart';
import '../../features/statistics/view/statistics_screen.dart';
import '../../features/vehicles/view/vehicle_form_screen.dart';
import '../../features/vehicles/view/vehicles_screen.dart';

/// Chemins de navigation.
class Routes {
  Routes._();
  static const dashboard = '/dashboard';
  static const pleins = '/pleins';
  static const pleinForm = '/pleins/form';
  static const stats = '/stats';
  static const maintenance = '/maintenance';
  static const maintenanceForm = '/maintenance/form';
  static const settings = '/settings';
  static const vehicles = '/vehicles';
  static const vehicleForm = '/vehicles/form';
  static const depenses = '/depenses';
  static const depenseForm = '/depenses/form';
  static const export = '/export';
}

final _rootKey = GlobalKey<NavigatorState>();
final _shellKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootKey,
    initialLocation: Routes.dashboard,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellKey,
            routes: [
              GoRoute(
                path: Routes.dashboard,
                pageBuilder: (c, s) =>
                    const NoTransitionPage(child: DashboardScreen()),
              ),
            ],
          ),
          StatefulShellBranch(routes: [
            GoRoute(
              path: Routes.pleins,
              pageBuilder: (c, s) =>
                  const NoTransitionPage(child: PleinsScreen()),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: Routes.stats,
              pageBuilder: (c, s) =>
                  const NoTransitionPage(child: StatisticsScreen()),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: Routes.maintenance,
              pageBuilder: (c, s) =>
                  const NoTransitionPage(child: MaintenanceScreen()),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: Routes.settings,
              pageBuilder: (c, s) =>
                  const NoTransitionPage(child: SettingsScreen()),
            ),
          ]),
        ],
      ),

      // --- Routes plein écran (hors barre de navigation) ---
      GoRoute(
        parentNavigatorKey: _rootKey,
        path: Routes.pleinForm,
        builder: (c, s) => PleinFormScreen(plein: s.extra as Plein?),
      ),
      GoRoute(
        parentNavigatorKey: _rootKey,
        path: Routes.vehicles,
        builder: (c, s) => const VehiclesScreen(),
      ),
      GoRoute(
        parentNavigatorKey: _rootKey,
        path: Routes.vehicleForm,
        builder: (c, s) => VehicleFormScreen(vehicule: s.extra as Vehicule?),
      ),
      GoRoute(
        parentNavigatorKey: _rootKey,
        path: Routes.depenses,
        builder: (c, s) => const DepensesScreen(),
      ),
      GoRoute(
        parentNavigatorKey: _rootKey,
        path: Routes.depenseForm,
        builder: (c, s) => DepenseFormScreen(depense: s.extra as Depense?),
      ),
      GoRoute(
        parentNavigatorKey: _rootKey,
        path: Routes.maintenanceForm,
        builder: (c, s) =>
            MaintenanceFormScreen(maintenance: s.extra as Maintenance?),
      ),
      GoRoute(
        parentNavigatorKey: _rootKey,
        path: Routes.export,
        builder: (c, s) => const ExportScreen(),
      ),
    ],
  );
});
