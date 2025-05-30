// lib/Features/activities/domain/repository/activity_repository.dart

import 'package:visit_tracker/Features/activities/domain/entities/activity.dart';

abstract class ActivityRepository {
  Future<List<Activity>> getActivities();
  Future<Activity> createActivity(Activity activity);
  Future<Activity> updateActivity(Activity activity);
  Future<void> deleteActivity(String id);
}