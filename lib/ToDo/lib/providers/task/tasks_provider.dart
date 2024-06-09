import 'package:discover_training_location/ToDo/lib/data/repositories/task_repository_provider.dart';
import 'package:discover_training_location/ToDo/lib/providers/task/task_notifier.dart';
import 'package:discover_training_location/ToDo/lib/providers/task/task_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tasksProvider = StateNotifierProvider<TaskNotifier, TaskState>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return TaskNotifier(repository);
});
