// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityModel _$ActivityModelFromJson(Map<String, dynamic> json) =>
    ActivityModel(
      id: (json['id'] as num).toInt(),
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$ActivityModelToJson(ActivityModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'createdAt': instance.createdAt.toIso8601String(),
    };
