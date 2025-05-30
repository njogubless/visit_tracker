// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitModel _$VisitModelFromJson(Map<String, dynamic> json) => VisitModel(
      id: (json['id'] as num).toInt(),
      customerId: (json['customerId'] as num).toInt(),
      visitDate: DateTime.parse(json['visitDate'] as String),
      status: json['status'] as String,
      location: json['location'] as String,
      notes: json['notes'] as String,
      activitiesDone: (json['activitiesDone'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$VisitModelToJson(VisitModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'visitDate': instance.visitDate.toIso8601String(),
      'status': instance.status,
      'location': instance.location,
      'notes': instance.notes,
      'activitiesDone': instance.activitiesDone,
      'createdAt': instance.createdAt.toIso8601String(),
    };
