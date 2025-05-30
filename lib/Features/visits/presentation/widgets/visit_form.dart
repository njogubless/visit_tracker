import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:visit_tracker/Features/activities/presentation/providers/activities_providers.dart';
import 'package:visit_tracker/Features/customers/presentation/providers/customer_provider.dart';
import 'package:visit_tracker/Features/visits/presentation/providers/visit_provider.dart';

class VisitForm extends ConsumerStatefulWidget {
  const VisitForm({super.key});

  @override
  ConsumerState<VisitForm> createState() => _VisitFormState();
}

class _VisitFormState extends ConsumerState<VisitForm> {
  final _formKey = GlobalKey<FormState>();
  final _locationController = TextEditingController();
  final _notesController = TextEditingController();
  
  int? _selectedCustomerId;
  DateTime _selectedDate = DateTime.now();
  String _selectedStatus = 'Pending';
   final Set<int> _selectedActivities = {};
  bool _isLoading = false;

  final List<String> _statusOptions = ['Pending', 'Completed', 'Cancelled'];

  @override
  void dispose() {
    _locationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customersAsync = ref.watch(customersProvider);
    final activitiesAsync = ref.watch(activitiesProvider);

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Customer Selection
            const Text(
              'Customer',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            customersAsync.when(
              data: (customers) => DropdownButtonFormField<int>(
                value: _selectedCustomerId,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Select a customer',
                ),
                items: customers.map((customer) {
                  return DropdownMenuItem<int>(
                    value: customer.id,
                    child: Text(customer.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCustomerId = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a customer';
                  }
                  return null;
                },
              ),
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) => Text('Error loading customers: $error'),
            ),
            const SizedBox(height: 16),

            // Visit Date
            const Text(
              'Visit Date',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (date != null) {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(_selectedDate),
                  );
                  if (time != null) {
                    setState(() {
                      _selectedDate = DateTime(
                        date.year,
                        date.month,
                        date.day,
                        time.hour,
                        time.minute,
                      );
                    });
                  }
                }
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year} ${_selectedDate.hour}:${_selectedDate.minute.toString().padLeft(2, '0')}',
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Status
            const Text(
              'Status',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedStatus,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: _statusOptions.map((status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedStatus = value!;
                });
              },
            ),
            const SizedBox(height: 16),

            // Location
            const Text(
              'Location',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _locationController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter visit location',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a location';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Activities
            const Text(
              'Activities Done',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            activitiesAsync.when(
              data: (activities) => Column(
                children: activities.map((activity) {
                  return CheckboxListTile(
                    title: Text(activity.description),
                    value: _selectedActivities.contains(activity.id),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          _selectedActivities.add(activity.id);
                        } else {
                          _selectedActivities.remove(activity.id);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) => Text('Error loading activities: $error'),
            ),
            const SizedBox(height: 16),

            // Notes
            const Text(
              'Notes',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter visit notes (optional)',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _submitForm,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Create Visit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final visitData = {
          'customer_id': _selectedCustomerId,
          'visit_date': _selectedDate.toIso8601String(),
          'status': _selectedStatus,
          'location': _locationController.text,
          'notes': _notesController.text,
          'activities_done': _selectedActivities.map((id) => id.toString()).toList(),
        };

        await ref.read(visitsProvider.notifier).createVisit(visitData);
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Visit created successfully!')),
          );
          context.go('/');
        }
      } catch (error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error creating visit: $error')),
          );
        }
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}