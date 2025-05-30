import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visit_tracker/Features/customers/presentation/providers/customer_provider.dart';
import 'package:visit_tracker/Features/visits/Domain/entities/visit.dart';
import 'package:visit_tracker/core/utils/date_formatter.dart';


class VisitCard extends ConsumerWidget {
  final Visit visit;

  const VisitCard({super.key, required this.visit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customersAsync = ref.watch(customersProvider);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: customersAsync.when(
                    data: (customers) {
                      final customer = customers.firstWhere(
                        (c) => c.id == visit.customerId,
                        orElse: () => throw Exception('Customer not found'),
                      );
                      return Text(
                        customer.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                    loading: () => const Text('Loading...'),
                    error: (_, __) => Text('Customer ID: ${visit.customerId}'),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(visit.status),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    visit.status,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    visit.location,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.schedule, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  DateFormatter.formatForDisplay(visit.visitDate),
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            if (visit.notes.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                visit.notes,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14),
              ),
            ],
            if (visit.activitiesDone.isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 4,
                children: visit.activitiesDone.map((activityId) {
                  return Chip(
                    label: Text('Activity $activityId'),
                    backgroundColor: Colors.blue[100],
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}