import 'package:chat_app/src/features/settings/presentation/theme_mode_controller.dart';
import 'package:chat_app/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeAsync = ref.watch(themeModeControllerProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          'S E T T I N G S',
          style: GoogleFonts.roboto(
            fontSize: 18,
            color: Colors.grey[700],
          ),
        ),
        centerTitle: true,
          leading: GestureDetector(
          onTap: () {
            context.goNamed(AppRoute.chatList.name);
          },
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.grey[700],
          ),
        ),
      ),
      body: themeModeAsync.when(
        data: (themeMode) => Card(
          elevation: 0,
          color: Theme.of(context).cardTheme.color,
          margin: const EdgeInsets.all(24),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Text(
                  'Dark Mode',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Switch(
                  value: themeMode == ThemeMode.dark,
                  onChanged: (value) {
                    ref
                        .read(themeModeControllerProvider.notifier)
                        .toggleTheme();
                  },
                ),
              ],
            ),
          ),
        ),
        loading: () => Center(
            child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.onPrimary,
        )),
        error: (error, stack) =>
            Center(child: Text('Error loading theme: $error')),
      ),
    );
  }
}
