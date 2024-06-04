import 'package:flutter/material.dart';
import 'package:gestion_des_elements/screens/viewsElementsScreens.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nom Application des contact',
      home: AffichageElementScreen(),
    );
  }
}
