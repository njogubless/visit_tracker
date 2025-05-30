// import 'package:visit_tracker/Features/customers/domain/entities/customer.dart';

// abstract class CustomerRepository {
//   Future<List<Customer>> getCustomers();
//   Future<Customer> getCustomerById(int id);
//   Future<Customer> createCustomer(Map<String, dynamic> customerData);
//   Future<Customer> updateCustomer(int id, Map<String, dynamic> customerData);
//   Future<void> deleteCustomer(int id);
// }


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:visit_tracker/Features/customers/domain/entities/customer.dart';

class CustomerRepository {
  final String baseUrl = 'https://kqgbftwsodpttpqgqnbh.supabase.co/rest/v1/'; // Replace with your actual API URL

  Future<List<Customer>> getCustomers() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/customers'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Customer.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load customers: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching customers: $e');
    }
  }
}