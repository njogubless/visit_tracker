

import 'package:visit_tracker/Features/visits/Data/datasources/visit_datasources.dart';
import 'package:visit_tracker/Features/visits/Domain/entities/visit.dart';
import 'package:visit_tracker/Features/visits/Domain/repositories/visit_repository.dart';

class VisitRepositoryImpl implements VisitRepository {
  final VisitRemoteDataSource _remoteDataSource;
  
  VisitRepositoryImpl(this._remoteDataSource);

  @override
  String get baseUrl => _remoteDataSource.baseUrl;

  @override
  Future<VisitStatistics> getStatistics() async {
    return await getVisitStatistics();
  }
  
  @override
  Future<List<Visit>> getVisits() async {
    return await _remoteDataSource.getVisits();
  }
  
  @override
  Future<Visit> createVisit(Map<String, dynamic> visitData) async {
    return await _remoteDataSource.createVisit(visitData);
  }
  
  @override
  Future<Visit> updateVisit(int id, Map<String, dynamic> visitData) async {
    return await _remoteDataSource.updateVisit(id, visitData);
  }
  
  @override
  Future<void> deleteVisit(int id) async {
    await _remoteDataSource.deleteVisit(id);
  }
  
  @override
  Future<VisitStatistics> getVisitStatistics() async {
    final visits = await getVisits();
    final totalVisits = visits.length;
    final completedVisits = visits.where((v) => v.status == 'Completed').length;
    final pendingVisits = visits.where((v) => v.status == 'Pending').length;
    final cancelledVisits = visits.where((v) => v.status == 'Cancelled').length;
    final completionRate = totalVisits > 0 ? (completedVisits / totalVisits) * 100 : 0.0;
    
    return VisitStatistics(
      totalVisits: totalVisits,
      completedVisits: completedVisits,
      pendingVisits: pendingVisits,
      cancelledVisits: cancelledVisits,
      completionRate: completionRate,
    );
  }
}