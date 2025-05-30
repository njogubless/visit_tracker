
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:visit_tracker/Features/visits/Domain/entities/visit.dart';

class VisitRepository {
  final String baseUrl = 'https://kqgbftwsodpttpqgqnbh.supabase.co/rest/v1/'; // Replace with your actual API URL

  Future<List<Visit>> getVisits() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/visits'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Visit.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load visits: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching visits: $e');
    }
  }

  Future<VisitStatistics> getStatistics() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/visits/statistics'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return VisitStatistics.fromJson(jsonData);
      } else {
        throw Exception('Failed to load statistics: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching statistics: $e');
    }
  }

  Future<void> createVisit(Map<String, dynamic> visitData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/visits'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(visitData),
      );

      if (response.statusCode != 201 && response.statusCode != 200) {
        throw Exception('Failed to create visit: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating visit: $e');
    }
  }
}



// abstract class VisitRepository {
//   Future<List<Visit>> getVisits();
//   Future<Visit> createVisit(Map<String, dynamic> visitData);
//   Future<Visit> updateVisit(int id, Map<String, dynamic> visitData);
//   Future<void> deleteVisit(int id);
//   Future<VisitStatistics> getVisitStatistics();
// }