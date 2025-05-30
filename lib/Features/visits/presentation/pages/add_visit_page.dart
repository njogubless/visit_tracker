import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../widgets/visit_form.dart';

class AddVisitPage extends ConsumerWidget {
  const AddVisitPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Visit'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: VisitForm(),
        ),
      ),
    );
  }
}