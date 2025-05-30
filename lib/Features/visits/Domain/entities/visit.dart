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

  factory Visit.fromJson(Map<String, dynamic> json) {
    return Visit(
      // SAFE PARSING - Handle null values and wrong types
      id: _parseToInt(json['id']),
      customerId: _parseToInt(json['customer_id']),
      visitDate: _parseToDateTime(json['visit_date']),
      status: json['status']?.toString() ?? 'Pending',
      location: json['location']?.toString() ?? '',
      notes: json['notes']?.toString() ?? '',
      activitiesDone: _parseActivitiesDone(json['activities_done']),
      createdAt: _parseToDateTime(json['created_at']),
    );
  }
  
  // HELPER METHODS FOR SAFE PARSING
  static int _parseToInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }
  
  static DateTime _parseToDateTime(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (e) {
        return DateTime.now();
      }
    }
    return DateTime.now();
  }
  
  static List<int> _parseActivitiesDone(dynamic value) {
    if (value == null) return [];
    if (value is List) {
      return value.map((e) {
        if (e is int) return e;
        if (e is String) return int.tryParse(e) ?? 0;
        return 0;
      }).toList();
    }
    return [];
  }
}

// PROBLEM 2: Fix your VisitStatistics parsing
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

  factory VisitStatistics.fromJson(Map<String, dynamic> json) {
    return VisitStatistics(
      // SAFE PARSING FOR STATISTICS
      totalVisits: _parseToInt(json['total_visits']),
      completedVisits: _parseToInt(json['completed_visits']),
      pendingVisits: _parseToInt(json['pending_visits']),
      cancelledVisits: _parseToInt(json['cancelled_visits']),
      completionRate: _parseToDouble(json['completion_rate']),
    );
  }
  
  static int _parseToInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    if (value is double) return value.round();
    return 0;
  }
  
  static double _parseToDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }
}
