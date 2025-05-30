import 'package:visit_tracker/Features/customers/domain/entities/customer.dart';
import 'package:visit_tracker/core/network/api_client.dart';

abstract class CustomerRemoteDataSource {
  Future<List<Customer>> getCustomers();
  Future<Customer> getCustomerById(int id);
  Future<Customer> createCustomer(Map<String, dynamic> customerData);
  Future<Customer> updateCustomer(int id, Map<String, dynamic> customerData);
  Future<void> deleteCustomer(int id);
}

class CustomerRemoteDataSourceImpl implements CustomerRemoteDataSource {
  final ApiClient _apiClient;

  CustomerRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<Customer>> getCustomers() async {
    try {
      final response = await _apiClient.get('/customers');
      final List<dynamic> customersJson = response['data'] as List<dynamic>;
      return customersJson
          .map((json) => Customer.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch customers: $e');
    }
  }

  @override
  Future<Customer> getCustomerById(int id) async {
    try {
      final response = await _apiClient.get('/customers/$id');
      return Customer.fromJson(response['data'] as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to fetch customer: $e');
    }
  }

  @override
  Future<Customer> createCustomer(Map<String, dynamic> customerData) async {
    try {
      final response = await _apiClient.post('/customers', data: customerData);
      return Customer.fromJson(response['data'] as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to create customer: $e');
    }
  }

  @override
  Future<Customer> updateCustomer(int id, Map<String, dynamic> customerData) async {
    try {
      final response = await _apiClient.put('/customers/$id', data: customerData);
      return Customer.fromJson(response['data'] as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to update customer: $e');
    }
  }

  @override
  Future<void> deleteCustomer(int id) async {
    try {
      await _apiClient.delete('/customers/$id');
    } catch (e) {
      throw Exception('Failed to delete customer: $e');
    }
  }
}