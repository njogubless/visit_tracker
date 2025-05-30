import '../entities/visit.dart';

abstract class VisitRepository {
  Future<List<Visit>> getVisits();
  Future<Visit> createVisit(Map<String, dynamic> visitData);
  Future<Visit> updateVisit(int id, Map<String, dynamic> visitData);
  Future<void> deleteVisit(int id);
  Future<VisitStatistics> getVisitStatistics();
}