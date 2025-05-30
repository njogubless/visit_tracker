import 'package:json_annotation/json_annotation.dart';
import 'package:visit_tracker/Features/visits/Domain/entities/visit.dart';

part 'visit_model.g.dart';

@JsonSerializable()
class VisitModel extends Visit {
  const VisitModel({
    required super.id,
    @JsonKey(name: 'customer_id') required super.customerId,
    @JsonKey(name: 'visit_date') required super.visitDate,
    required super.status,
    required super.location,
    required super.notes,
    @JsonKey(name: 'activities_done', fromJson: _activitiesFromJson, toJson: _activitiesToJson)
    required super.activitiesDone,
    @JsonKey(name: 'created_at') required super.createdAt,
  });
  
  factory VisitModel.fromJson(Map<String, dynamic> json) =>
      _$VisitModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$VisitModelToJson(this);
  
  static List<int> _activitiesFromJson(List<dynamic> activities) {
    return activities.map((e) => int.parse(e.toString())).toList();
  }
  
  static List<String> _activitiesToJson(List<int> activities) {
    return activities.map((e) => e.toString()).toList();
  }
}