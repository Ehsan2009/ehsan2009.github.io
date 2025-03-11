import 'package:chat_app/src/features/authentication/presentation/auth/auth_screen.dart';
import 'package:chat_app/src/features/chat/presentation/chat_room/chat_room_screen.dart';
import 'package:chat_app/src/features/chat/presentation/chat_list/chat_list_screen.dart';
import 'package:chat_app/src/features/settings/presentation/settings_screen.dart';
import 'package:chat_app/src/features/authentication/presentation/splash/splash_screen.dart';
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
      builder: (context, state) => const ChatListScreen(),
    ),
    GoRoute(
      path: '/chat_screen',
      builder: (context, state) {
        String userEmail = state.extra as String;
        return ChatRoomScreen(userEmail: userEmail);
      },
    ),
    GoRoute(
      path: '/settings_screen',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
