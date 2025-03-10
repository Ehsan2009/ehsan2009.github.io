import 'package:chat_app/src/features/authentication/presentation/auth_screen.dart';
import 'package:chat_app/src/features/chat/presentation/chat_screen.dart';
import 'package:chat_app/src/features/chat/presentation/home_screen.dart';
import 'package:chat_app/src/features/settings/presentation/settings_screen.dart';
import 'package:chat_app/src/features/authentication/presentation/splash_screen.dart';
import 'package:go_router/go_router.dart';

final goRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/auth_screen',
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(
      path: '/home_screen',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/chat_screen',
      builder: (context, state) {
        String userEmail = state.extra as String;
        return ChatScreen(userEmail: userEmail);
      },
    ),
    GoRoute(
      path: '/settings_screen',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
