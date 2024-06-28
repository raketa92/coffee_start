import 'package:coffee_start/config/routes/routes.dart';
import 'package:coffee_start/config/theme/app_theme.dart';
import 'package:coffee_start/injection_container.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme(),
      onGenerateRoute: AppRoutes.onGenerateRoutes,
    );
  }
}
