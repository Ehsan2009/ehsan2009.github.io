import 'package:chat_app/src/features/settings/presentation/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref.watch(settingsControllerProvider);

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
            context.go('/home_screen');
          },
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.grey[700],
          ),
        ),
      ),
      body: Card(
        elevation: 0,
        color: Theme.of(context).cardTheme.color,
        margin: const EdgeInsets.all(24),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Text(
                'Dark Mode',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Switch(
                value: currentThemeMode == ThemeMode.dark ? true : false,
                onChanged: (value) {
                  ref.read(settingsControllerProvider.notifier).toggleTheme();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
