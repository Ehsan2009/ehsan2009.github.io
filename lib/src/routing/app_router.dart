import 'package:chat_app/src/features/authentication/presentation/auth/auth_screen.dart';
import 'package:chat_app/src/features/chat/presentation/chat_room/chat_room_screen.dart';
import 'package:chat_app/src/features/chat/presentation/chat_list/chat_list_screen.dart';
import 'package:chat_app/src/features/settings/presentation/settings_screen.dart';
import 'package:chat_app/src/features/authentication/presentation/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  splash,
  auth,
  chatList,
  chatRoom,
  settings,
}

final goRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.splash.name,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/auth',
      name: AppRoute.auth.name,
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(
      path: '/chat-list',
      name: AppRoute.chatList.name,
      builder: (context, state) => const ChatListScreen(),
      routes: [
        GoRoute(
          path: 'chat-room',
          name: AppRoute.chatRoom.name,
          builder: (context, state) {
            String userEmail = state.extra as String;
            return ChatRoomScreen(userEmail: userEmail);
          },
        ),
        GoRoute(
          path: 'settings',
          name: AppRoute.settings.name,
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
  ],
);
