import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visit_tracker/Features/visits/Data/datasources/visit_datasources.dart';
import 'package:visit_tracker/Features/visits/Data/repositories/visit_repository_impl.dart';
import 'package:visit_tracker/Features/visits/Domain/entities/visit.dart';
import 'package:visit_tracker/Features/visits/Domain/usecases/get_visits.dart';
import 'package:visit_tracker/core/network/api_client.dart';


// Providers
final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());

final visitRemoteDataSourceProvider = Provider<VisitRemoteDataSource>((ref) {
  return VisitRemoteDataSourceImpl(ref.read(apiClientProvider));
});

final visitRepositoryProvider = Provider<VisitRepositoryImpl>((ref) {
  return VisitRepositoryImpl(ref.read(visitRemoteDataSourceProvider));
});

final getVisitsUseCaseProvider = Provider<GetVisits>((ref) {
  return GetVisits(ref.read(visitRepositoryProvider));
});

// State Providers
final visitsProvider = StateNotifierProvider<VisitsNotifier, AsyncValue<List<Visit>>>((ref) {
  return VisitsNotifier(ref.read(getVisitsUseCaseProvider), ref.read(visitRepositoryProvider));
});

final visitSearchQueryProvider = StateProvider<String>((ref) => '');
final visitStatusFilterProvider = StateProvider<String?>((ref) => null);

final filteredVisitsProvider = Provider<AsyncValue<List<Visit>>>((ref) {
  final visitsAsyncValue = ref.watch(visitsProvider);
  final searchQuery = ref.watch(visitSearchQueryProvider);
  final statusFilter = ref.watch(visitStatusFilterProvider);
  
  return visitsAsyncValue.when(
    data: (visits) {
      var filteredVisits = visits;
      
      if (searchQuery.isNotEmpty) {
        filteredVisits = filteredVisits.where((visit) =>
            visit.location.toLowerCase().contains(searchQuery.toLowerCase()) ||
            visit.notes.toLowerCase().contains(searchQuery.toLowerCase())).toList();
      }
      
      if (statusFilter != null && statusFilter.isNotEmpty) {
        filteredVisits = filteredVisits.where((visit) => visit.status == statusFilter).toList();
      }
      
      return AsyncValue.data(filteredVisits);
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

final visitStatisticsProvider = FutureProvider<VisitStatistics>((ref) async {
  final repository = ref.read(visitRepositoryProvider);
  return await repository.getVisitStatistics();
});

class VisitsNotifier extends StateNotifier<AsyncValue<List<Visit>>> {
  final GetVisits _getVisits;
  final VisitRepositoryImpl _repository;
  
  VisitsNotifier(this._getVisits, this._repository) : super(const AsyncValue.loading()) {
    loadVisits();
  }
  
  Future<void> loadVisits() async {
    state = const AsyncValue.loading();
    try {
      final visits = await _getVisits();
      state = AsyncValue.data(visits);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
  
  Future<void> createVisit(Map<String, dynamic> visitData) async {
    try {
      await _repository.createVisit(visitData);
      await loadVisits(); // Refresh the list
    } catch (error) {
      rethrow;
    }
  }
  
  Future<void> updateVisit(int id, Map<String, dynamic> visitData) async {
    try {
      await _repository.updateVisit(id, visitData);
      await loadVisits(); // Refresh the list
    } catch (error) {
      rethrow;
    }
  }
  
  Future<void> deleteVisit(int id) async {
    try {
      await _repository.deleteVisit(id);
      await loadVisits(); // Refresh the list
    } catch (error) {
      rethrow;
    }
  }
}