import 'package:cours_flutter/auth/login.dart';
import 'package:cours_flutter/auth/register.dart';
import 'package:cours_flutter/crud/page/product.dart';
import 'package:cours_flutter/meteo.dart';
import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: const HomePage(),
      initialRoute: '/login',
      routes: {
        '/': (context) => const HomePage(),
        '/meteo': (context) => const MeteoPage(),
        '/product': (context) => const ProductPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        // '/profile': (context) => const ProfilePage(),
      },
    );
  }
}
