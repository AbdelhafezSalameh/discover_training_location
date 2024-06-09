import 'package:discover_training_location/ToDo/lib/app/app.dart';
import 'package:discover_training_location/admin_panel/screens/dashboard/dashboard_screen.dart';
import 'package:discover_training_location/admin_panel/screens/main/components/request_training.dart';
import 'package:discover_training_location/admin_panel/screens/main/main_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Map<String, WidgetBuilder> routes = {
  RequrstsTrainings.routeName: (context) => RequrstsTrainings(),
  DashboardScreen.routeName: (context) => const DashboardScreen(),
  MainScreen.routeName: (context) => MainScreen(),
 // FlutterRiverpodTodoApp.routeName: (context) => FlutterRiverpodTodoApp(),
  FlutterRiverpodTodoApp.routeName: (context) => const ProviderScope(child: FlutterRiverpodTodoApp()),

};
