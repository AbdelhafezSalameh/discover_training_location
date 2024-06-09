import 'package:discover_training_location/ToDo/lib/data/datasource/task_datasource_provider.dart';
import 'package:discover_training_location/ToDo/lib/data/repositories/task_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'task_repository_impl.dart';

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  final datasource = ref.read(taskDatasourceProvider);
  return TaskRepositoryImpl(datasource);
});
