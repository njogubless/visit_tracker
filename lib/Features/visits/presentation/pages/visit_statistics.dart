import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:visit_tracker/Features/visits/presentation/providers/visit_provider.dart';
import 'package:visit_tracker/Features/visits/presentation/widgets/statistics_card.dart';
import 'package:visit_tracker/shared/widgets/error_widget.dart';
import 'package:visit_tracker/shared/widgets/loading_widget.dart';


class VisitStatisticsPage extends ConsumerWidget {
  const VisitStatisticsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statisticsAsync = ref.watch(visitStatisticsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Visit Statistics'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: statisticsAsync.when(
        data: (statistics) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your Visit Overview',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: StatisticsCard(
                      title: 'Total Visits',
                      value: statistics.totalVisits.toString(),
                      icon: Icons.list_rounded,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: StatisticsCard(
                      title: 'Completed',
                      value: statistics.completedVisits.toString(),
                      icon: Icons.check_circle,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: StatisticsCard(
                      title: 'Pending',
                      value: statistics.pendingVisits.toString(),
                      icon: Icons.pending,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: StatisticsCard(
                      title: 'Cancelled',
                      value: statistics.cancelledVisits.toString(),
                      icon: Icons.cancel,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        'Completion Rate',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      LinearProgressIndicator(
                        value: statistics.completionRate / 100,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          statistics.completionRate >= 70 ? Colors.green : Colors.orange,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${statistics.completionRate.toStringAsFixed(1)}%',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        loading: () => const LoadingWidget(),
        error: (error, stack) => CustomErrorWidget(
          message: error.toString(),
          onRetry: () => ref.invalidate(visitStatisticsProvider),
        ),
      ),
    );
  }
}