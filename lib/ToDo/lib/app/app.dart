import 'package:discover_training_location/ToDo/lib/config/routes/routes_provider.dart';
import 'package:discover_training_location/ToDo/lib/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FlutterRiverpodTodoApp extends ConsumerWidget {
  const FlutterRiverpodTodoApp({super.key});
  static String routeName = "/FlutterRiverpodTodoApp";

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    final route = ref.watch(routesProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: route,
    );
  }
}
