import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'features/navigation/main_nav_screen.dart';
import 'providers/finance_provider.dart';

class DompetHarianApp extends StatelessWidget {
  const DompetHarianApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FinanceProvider()..loadInitialData(),
      child: MaterialApp(
        title: 'SIMPanan',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const MainNavScreen(),
      ),
    );
  }
}