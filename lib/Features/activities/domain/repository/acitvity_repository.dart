// // lib/Features/activities/domain/repository/activity_repository.dart

import 'package:visit_tracker/Features/activities/domain/entities/activity.dart';

abstract class ActivityRepository {
  Future<List<Activity>> getActivities();
  Future<Activity> createActivity(dynamic activity);
  Future<Activity> updateActivity(Activity activity);
  Future<void> deleteActivity(String id);
}

// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:visit_tracker/Features/activities/domain/entities/activity.dart';

// class ActivityRepository {
//   final String baseUrl =
//       'YOUR_API_BASE_URL'; // Replace with your actual API URL

//   Future<List<Activity>> getActivities() async {
//     try {
//       final response = await http.get(
//         Uri.parse('$baseUrl/activities'),
//         headers: {'Content-Type': 'application/json'},
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> jsonData = json.decode(response.body);
//         return jsonData.map((json) => Activity.fromJson(json)).toList();
//       } else {
//         throw Exception('Failed to load activities: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Error fetching activities: $e');
//     }
//   }

//  Future<Activity> createActivity(dynamic activity) async {
//   try {
//     final response = await http.post(
//       Uri.parse('$baseUrl/activities'),
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode(activity), // Add the activity data to request body
//     );

//     if (response.statusCode == 201 || response.statusCode == 200) {
//       final Map<String, dynamic> jsonData = json.decode(response.body);
//       return Activity.fromJson(jsonData); // Return single Activity, not List
//     } else {
//       throw Exception('Failed to create activity: ${response.statusCode}');
//     }
//   } catch (e) {
//     throw Exception('Error creating activity: $e');
//   }
// }

//   Future<Activity> updateActivity(Activity activity) async {
//     try {
//       final response = await http.put(
//         Uri.parse('$baseUrl/activities/${activity.id}'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(activity.toJson()),
//       );

//       if (response.statusCode == 200) {
//         return Activity.fromJson(json.decode(response.body));
//       } else {
//         throw Exception('Failed to update activity: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Error updating activity: $e');
//     }
//   }
//   Future<void> deleteActivity(String id) async {
//     try {
//       final response = await http.delete(
//         Uri.parse('$baseUrl/activities/$id'),
//         headers: {'Content-Type': 'application/json'},
//       );

//       if (response.statusCode != 204) {
//         throw Exception('Failed to delete activity: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Error deleting activity: $e');
//     }
//   }
// }
