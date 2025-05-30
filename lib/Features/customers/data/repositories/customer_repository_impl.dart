
import 'package:visit_tracker/Features/customers/data/data_sources/customer_data_source.dart';
import 'package:visit_tracker/Features/customers/domain/entities/customer.dart';
import 'package:visit_tracker/Features/customers/domain/repositories/customer_repository.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerRemoteDataSource _remoteDataSource;

  @override
  String get baseUrl => _remoteDataSource.baseUrl;

  CustomerRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<Customer>> getCustomers() async {
    return await _remoteDataSource.getCustomers();
  }

  @override
  Future<Customer> getCustomerById(int id) async {
    return await _remoteDataSource.getCustomerById(id);
  }

  @override
  Future<Customer> createCustomer(Map<String, dynamic> customerData) async {
    return await _remoteDataSource.createCustomer(customerData);
  }

  @override
  Future<Customer> updateCustomer(int id, Map<String, dynamic> customerData) async {
    return await _remoteDataSource.updateCustomer(id, customerData);
  }

  @override
  Future<void> deleteCustomer(int id) async {
    await _remoteDataSource.deleteCustomer(id);
  }
}