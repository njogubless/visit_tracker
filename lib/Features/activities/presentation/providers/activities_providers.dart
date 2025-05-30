// lib/Features/activities/presentation/providers/activities_providers.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visit_tracker/Features/activities/domain/entities/activity.dart';
import 'package:visit_tracker/Features/activities/data/datasources/activity_datasources.dart';
import 'package:visit_tracker/Features/activities/data/repository/activity_repository_impl.dart';
import 'package:visit_tracker/Features/activities/domain/repository/acitvity_repository.dart';
import 'package:visit_tracker/Features/visits/presentation/providers/visit_provider.dart';


final activityRemoteDataSourceProvider = Provider<ActivityRemoteDataSource>((ref) {
  return ActivityRemoteDataSourceImpl(ref.read(apiClientProvider));
});

final activityRepositoryProvider = Provider<ActivityRepository>((ref) {
  return ActivityRepositoryImpl(ref.read(activityRemoteDataSourceProvider));
});

final activitiesProvider = FutureProvider<List<Activity>>((ref) async {
  final repository = ref.read(activityRepositoryProvider);
  return await repository.getActivities();
});

// Additional providers for activity management
final createActivityProvider = Provider((ref) {
  final repository = ref.read(activityRepositoryProvider);
  return (Activity activity) async => await repository.createActivity(activity);
});

final updateActivityProvider = Provider((ref) {
  final repository = ref.read(activityRepositoryProvider);
  return (Activity activity) async => await repository.updateActivity(activity);
});

final deleteActivityProvider = Provider((ref) {
  final repository = ref.read(activityRepositoryProvider);
  return (String id) async => await repository.deleteActivity(id);
});