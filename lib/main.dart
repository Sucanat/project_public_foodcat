import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:public_foodcat/screens/home/home_page.dart';
import 'package:public_foodcat/screens/home/add_foodcat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.lightBlue), // ตั้งค่าสีฟ้าอ่อน
        useMaterial3: true,
        fontFamily: GoogleFonts.kanit().fontFamily,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        AddfoodcatPage.routeName: (context) => AddfoodcatPage(),
      },
    );
  }
}
