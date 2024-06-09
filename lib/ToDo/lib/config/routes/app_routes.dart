
import 'package:discover_training_location/ToDo/lib/config/routes/routes_location.dart';
import 'package:discover_training_location/ToDo/lib/config/routes/routes_provider.dart';
import 'package:discover_training_location/ToDo/lib/screens/create_task_screen.dart';
import 'package:discover_training_location/ToDo/lib/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

final appRoutes = [
  GoRoute(
    path: RouteLocation.home,
    parentNavigatorKey: navigationKey,
    builder: HomeScreen.builder,
  ),
  GoRoute(
    path: RouteLocation.createTask,
    parentNavigatorKey: navigationKey,
    builder: CreateTaskScreen.builder,
  ),
];
