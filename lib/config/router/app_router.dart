
import 'package:go_router/go_router.dart';
import 'package:movie_app_uplabs/presentation/screens/screens.dart';


final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    name: HomeScreen.name,
    builder: (context, state) => const HomeScreen(),
  ),
]);
