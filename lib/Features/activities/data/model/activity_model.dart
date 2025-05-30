import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/activity.dart';

part 'activity_model.g.dart';

@JsonSerializable()
class ActivityModel extends Activity {
  const ActivityModel({
    required super.id,
    required super.description,
    @JsonKey(name: 'created_at') required super.createdAt,
  });
  
  factory ActivityModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$ActivityModelToJson(this);
}