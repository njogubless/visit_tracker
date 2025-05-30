import '../entities/visit.dart';
import '../repositories/visit_repository.dart';

class GetVisits {
  final VisitRepository _repository;
  
  GetVisits(this._repository);
  
  Future<List<Visit>> call({String? searchQuery, String? statusFilter}) async {
    final visits = await _repository.getVisits();
    
    var filteredVisits = visits;
    
    if (searchQuery != null && searchQuery.isNotEmpty) {
      filteredVisits = filteredVisits.where((visit) =>
          visit.location.toLowerCase().contains(searchQuery.toLowerCase()) ||
          visit.notes.toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }
    
    if (statusFilter != null && statusFilter.isNotEmpty) {
      filteredVisits = filteredVisits.where((visit) => visit.status == statusFilter).toList();
    }
    
    return filteredVisits;
  }
}