import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/auth_controller.dart';
import 'controllers/upload_controller.dart';
import 'views/home/home_view.dart';
import 'views/home/medical_history_view.dart';
import 'views/auth/login_view.dart';
import 'views/auth/signup_view.dart';
import 'views/upload/upload_view.dart';
import 'views/dashboard/dashboard_view.dart';
import 'views/diseases/diseases_view.dart';
import 'views/about/about_view.dart';

void main() {
  runApp(const SmartRetinaApp());
}

class SmartRetinaApp extends StatelessWidget {
  const SmartRetinaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => UploadController()),
      ],
      child: MaterialApp(
        title: 'Smart Retina',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF152066),
            brightness: Brightness.dark,
          ),
          scaffoldBackgroundColor: const Color(0xFF0F172A),
          canvasColor: const Color(0xFF0F172A),
          useMaterial3: true,
        ),
        initialRoute: '/home',
        routes: {
          '/home': (context) => const HomeView(),
          '/medical-history': (context) => const MedicalHistoryView(),
          '/login': (context) => const LoginView(),
          '/signup': (context) => const SignupView(),
          '/upload': (context) => const UploadView(),
          '/dashboard': (context) => const DashboardView(),
          '/diseases': (context) => const DiseasesView(),
          '/about': (context) => const AboutView(),
        },
      ),
    );
  }
}
