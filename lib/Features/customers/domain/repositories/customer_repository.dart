import 'package:visit_tracker/Features/customers/domain/entities/customer.dart';

abstract class CustomerRepository {
  Future<List<Customer>> getCustomers();
  Future<Customer> getCustomerById(int id);
  Future<Customer> createCustomer(Map<String, dynamic> customerData);
  Future<Customer> updateCustomer(int id, Map<String, dynamic> customerData);
  Future<void> deleteCustomer(int id);
}