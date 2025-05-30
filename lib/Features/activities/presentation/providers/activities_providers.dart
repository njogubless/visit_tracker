import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visit_tracker/Features/activities/domain/entities/activity.dart';


final activityRemoteDataSourceProvider = Provider<ActivityRemoteDataSource>((ref) {
  return ActivityRemoteDataSourceImpl(ref.read(apiClientProvider));
});

final activityRepositoryProvider = Provider<ActivityRepositoryImpl>((ref) {
  return ActivityRepositoryImpl(ref.read(activityRemoteDataSourceProvider));
});

final activitiesProvider = FutureProvider<List<Activity>>((ref) async {
  final repository = ref.read(activityRepositoryProvider);
  return await repository.getActivities();
});