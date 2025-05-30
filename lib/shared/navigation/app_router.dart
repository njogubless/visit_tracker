
import 'package:go_router/go_router.dart';
import 'package:visit_tracker/Features/visits/presentation/pages/add_visit_page.dart';
import 'package:visit_tracker/Features/visits/presentation/pages/visit_statistics.dart';
import 'package:visit_tracker/Features/visits/presentation/pages/visits_list_page.dart';


final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'visits',
      builder: (context, state) => const VisitsListPage(),
    ),
    GoRoute(
      path: '/add-visit',
      name: 'add-visit',
      builder: (context, state) => const AddVisitPage(),
    ),
    GoRoute(
      path: '/statistics',
      name: 'statistics',
      builder: (context, state) => const VisitStatisticsPage(),
    ),
  ],
);