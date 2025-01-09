import 'package:flutter/material.dart';
import 'package:pawtect_flutter/add_screen.dart';
import 'package:pawtect_flutter/home_screen.dart';
import 'package:pawtect_flutter/details_screen.dart';
import 'package:pawtect_flutter/update_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF072233)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/add': (context) => AddScreen(),
        '/details': (context) => DetailsScreen(onNavigateBack: () => Navigator.pop(context), petIndex: 0),
        '/update': (context) => UpdateScreen(onNavigateBack: () => Navigator.pop(context), petIndex: 0),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/details') {
          final args = settings.arguments as Map<String, dynamic>;
          final petId = args['petId'];

          return MaterialPageRoute(
            builder: (context) => DetailsScreen(onNavigateBack: () => Navigator.pop(context), petIndex: petId),
          );
        }
        if (settings.name == '/update') {
          final args = settings.arguments as Map<String, dynamic>;
          final petId = args['petId'];

          return MaterialPageRoute(
            builder: (context) => UpdateScreen(onNavigateBack: () => Navigator.pop(context), petIndex: petId),
          );
        }
      },
    );
  }
}
