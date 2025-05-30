class Customer {
  final int id;
  final String name;
  final DateTime createdAt;
  
  const Customer({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] as int,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}