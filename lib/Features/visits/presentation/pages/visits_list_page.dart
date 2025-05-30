import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:visit_tracker/Features/visits/presentation/providers/visit_provider.dart';
import 'package:visit_tracker/Features/visits/presentation/widgets/visit_card.dart';
import 'package:visit_tracker/shared/widgets/empty_state_widget.dart';
import 'package:visit_tracker/shared/widgets/error_widget.dart';
import 'package:visit_tracker/shared/widgets/loading_widget.dart';


class VisitsListPage extends ConsumerStatefulWidget {
  const VisitsListPage({super.key});

  @override
  ConsumerState<VisitsListPage> createState() => _VisitsListPageState();
}

class _VisitsListPageState extends ConsumerState<VisitsListPage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredVisits = ref.watch(filteredVisitsProvider);
    final statusFilter = ref.watch(visitStatusFilterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Visits Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.analytics),
            onPressed: () => context.go('/statistics'),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search visits...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    ref.read(visitSearchQueryProvider.notifier).state = value;
                  },
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text('Filter by status: '),
                    const SizedBox(width: 8),
                    DropdownButton<String?>(
                      value: statusFilter,
                      hint: const Text('All'),
                      items: [
                        const DropdownMenuItem<String?>(
                          value: null,
                          child: Text('All'),
                        ),
                        ...['Completed', 'Pending', 'Cancelled'].map(
                          (status) => DropdownMenuItem<String>(
                            value: status,
                            child: Text(status),
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        ref.read(visitStatusFilterProvider.notifier).state = value;
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Visits List
          Expanded(
            child: filteredVisits.when(
              data: (visits) {
                if (visits.isEmpty) {
                  return const EmptyStateWidget(
                    message: 'No visits found',
                    icon: Icons.list_rounded,
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(visitsProvider);
                  },
                  child: ListView.builder(
                    itemCount: visits.length,
                    itemBuilder: (context, index) {
                      return VisitCard(visit: visits[index]);
                    },
                  ),
                );
              },
              loading: () => const LoadingWidget(),
              error: (error, stack) => CustomErrorWidget(
                message: error.toString(),
                onRetry: () => ref.invalidate(visitsProvider),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/add-visit'),
        child: const Icon(Icons.add),
      ),
    );
  }
}