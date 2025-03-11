import 'package:chat_app/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      darkTheme: ThemeData.dark().copyWith(
        textTheme:  GoogleFonts.robotoTextTheme().copyWith(
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
      // themeMode: themeProvider.themeMode,
      debugShowCheckedModeBanner: false,
      routerConfig: goRouter,
    );
  }
}
