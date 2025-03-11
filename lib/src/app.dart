// import 'package:chat_app/src/features/settings/presentation/settings_controller.dart';
// import 'package:chat_app/src/features/settings/presentation/theme_mode_controller.dart';
// import 'package:chat_app/src/routing/app_router.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_fonts/google_fonts.dart';

// class MyApp extends ConsumerWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return FutureBuilder<ThemeMode>(
//       future: ref.watch(themeModeControllerProvider),
//       builder: (context, snapshot) {
        
//       },
//     );

//     MaterialApp.router(
//       darkTheme: ThemeData.dark().copyWith(
//         textTheme: GoogleFonts.robotoTextTheme().copyWith(
//             bodyMedium: const TextStyle(color: Colors.white),
//             labelMedium: TextStyle(color: Colors.grey[300])),
//         scaffoldBackgroundColor: const Color.fromARGB(255, 49, 45, 45),
//         appBarTheme: AppBarTheme.of(context).copyWith(
//           backgroundColor: const Color.fromARGB(255, 49, 45, 45),
//           foregroundColor: Colors.grey[500],
//         ),
//         cardTheme: const CardTheme().copyWith(
//           color: Colors.grey[800],
//         ),
//       ),
//       theme: ThemeData().copyWith(
//         textTheme: GoogleFonts.robotoTextTheme().copyWith(
//           bodyMedium: const TextStyle(color: Colors.black),
//           labelMedium: TextStyle(color: Colors.grey[600]),
//         ),
//         scaffoldBackgroundColor: Colors.grey[300],
//         appBarTheme: AppBarTheme.of(context).copyWith(
//           backgroundColor: Colors.grey[300],
//           foregroundColor: Colors.grey[500],
//         ),
//         cardTheme: const CardTheme().copyWith(
//           color: Colors.white,
//         ),
//       ),
//       themeMode: themeMode,
//       debugShowCheckedModeBanner: false,
//       routerConfig: goRouter,
//     );
//   }
// }

import 'package:chat_app/src/features/settings/presentation/theme_mode_controller.dart';
import 'package:chat_app/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeAsync = ref.watch(themeModeControllerProvider);

    return themeModeAsync.when(
      data: (themeMode) => MaterialApp.router(
        darkTheme: ThemeData.dark().copyWith(
          textTheme: GoogleFonts.robotoTextTheme().copyWith(
              bodyMedium: const TextStyle(color: Colors.white),
              labelMedium: TextStyle(color: Colors.grey[300])),
          scaffoldBackgroundColor: const Color.fromARGB(255, 49, 45, 45),
          appBarTheme: AppBarTheme.of(context).copyWith(
            backgroundColor: const Color.fromARGB(255, 49, 45, 45),
            foregroundColor: Colors.grey[500],
          ),
          cardTheme: const CardTheme().copyWith(
            color: Colors.grey[800],
          ),
        ),
        theme: ThemeData().copyWith(
          textTheme: GoogleFonts.robotoTextTheme().copyWith(
            bodyMedium: const TextStyle(color: Colors.black),
            labelMedium: TextStyle(color: Colors.grey[600]),
          ),
          scaffoldBackgroundColor: Colors.grey[300],
          appBarTheme: AppBarTheme.of(context).copyWith(
            backgroundColor: Colors.grey[300],
            foregroundColor: Colors.grey[500],
          ),
          cardTheme: const CardTheme().copyWith(
            color: Colors.white,
          ),
        ),
        themeMode: themeMode, // Correct usage
        debugShowCheckedModeBanner: false,
        routerConfig: goRouter,
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text("Error loading theme: $error")),
    );
  }
}

