import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/customer.dart';

part 'customer_model.g.dart';

@JsonSerializable()
class CustomerModel extends Customer {
  const CustomerModel({
    required super.id,
    required super.name,
    @JsonKey(name: 'created_at') required super.createdAt,
  });
  
  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);
}