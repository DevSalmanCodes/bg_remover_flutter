import 'package:bg_remover_fltuter/providers/api_provider.dart';
import 'package:bg_remover_fltuter/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApiProvider(),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: HomeView()),
    );
  }
}
