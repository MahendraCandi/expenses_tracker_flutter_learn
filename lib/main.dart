import 'package:expense_tracker/widgets/expense.dart';
import 'package:flutter/material.dart';

var appColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 183, 0, 255),
);

var appDarkScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: appDarkScheme,
        cardTheme: const CardTheme().copyWith(
          color: appDarkScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: appDarkScheme.primaryContainer,
            foregroundColor: appDarkScheme.onPrimaryContainer,
          ),
        ),
      ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: appColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: appColorScheme.onPrimaryContainer,
          foregroundColor: appColorScheme.primaryContainer
        ),
        cardTheme: const CardTheme().copyWith(
          color: appColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: appColorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: appColorScheme.onSecondaryContainer,
            fontSize: 16,
          ),
        ),
      ),
      home: const Expenses(),
    ),
  );
}
