class Visit {
  final int id;
  final int customerId;
  final DateTime visitDate;
  final String status;
  final String location;
  final String notes;
  final List<int> activitiesDone;
  final DateTime createdAt;
  
  const Visit({
    required this.id,
    required this.customerId,
    required this.visitDate,
    required this.status,
    required this.location,
    required this.notes,
    required this.activitiesDone,
    required this.createdAt,
  });
}

class VisitStatistics {
  final int totalVisits;
  final int completedVisits;
  final int pendingVisits;
  final int cancelledVisits;
  final double completionRate;
  
  const VisitStatistics({
    required this.totalVisits,
    required this.completedVisits,
    required this.pendingVisits,
    required this.cancelledVisits,
    required this.completionRate,
  });
}