import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visit_tracker/Features/customers/data/data_sources/customer_data_source.dart';
import 'package:visit_tracker/Features/customers/data/repositories/customer_repository_impl.dart';
import 'package:visit_tracker/Features/customers/domain/entities/customer.dart';
import 'package:visit_tracker/Features/customers/domain/repositories/customer_repository.dart';
import 'package:visit_tracker/Features/visits/presentation/providers/visit_provider.dart';


final customerRemoteDataSourceProvider = Provider<CustomerRemoteDataSource>((ref) {
  return CustomerRemoteDataSourceImpl(ref.read(apiClientProvider));
});

final customerRepositoryProvider = Provider<CustomerRepository>((ref) {
  return CustomerRepositoryImpl(ref.read(customerRemoteDataSourceProvider));
});

final customersProvider = FutureProvider<List<Customer>>((ref) async {
  final repository = ref.read(customerRepositoryProvider);
  return await repository.getCustomers();
});