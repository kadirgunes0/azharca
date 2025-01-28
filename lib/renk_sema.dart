import 'package:flutter/material.dart';
import 'package:ders3/giderler.dart';

var renkSemasi = ColorScheme.fromSeed(seedColor: Colors.orange);

var koyuMod = ColorScheme.fromSeed(
    seedColor: Colors.deepOrange, brightness: Brightness.dark);

class RenkSemalari extends StatelessWidget {
  const RenkSemalari({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: koyuMod,
        cardTheme: const CardTheme().copyWith(
          color: koyuMod.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: koyuMod.primaryContainer,
            foregroundColor: koyuMod.onPrimaryContainer,
          ),
        ),
      ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: renkSemasi,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: renkSemasi.onPrimaryContainer,
          foregroundColor: renkSemasi.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: renkSemasi.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: renkSemasi.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: renkSemasi.onSecondaryContainer,
                fontSize: 16,
              ),
            ),
      ),
      home: Giderler(),
    );
  }
}
