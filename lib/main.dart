import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kancha/providers/balanc_provider.dart';
import 'package:kancha/providers/company_provider.dart';
import 'package:kancha/providers/notification_provider.dart';
import 'package:kancha/providers/product_provider.dart';
import 'package:kancha/providers/raw_material_provider.dart';
import 'package:kancha/providers/task_provider.dart';
import 'package:kancha/providers/user_provider.dart';
import 'package:kancha/providers/warehouse_provider.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kancha/main_shell.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => WarehouseProvider()),
        ChangeNotifierProvider(create: (_) => RawMaterialProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => CompanyProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => ProductWarehouseProvider()),
        ChangeNotifierProvider(create: (_) => BalancProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: TextTheme(
          headlineMedium: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: TextStyle(
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w700,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo, // можно любой seed
        ),
        scaffoldBackgroundColor: Colors.white
      ),
      home: MainShell(), // ⬅️ ваш StatefulWidget со Scaffold
    );
  }
}
