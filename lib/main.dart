import 'package:flutter/material.dart';

import 'ui/home.dart';

// 0xFFF7BB0E jaune
// 0xFFF00000 rouge
// 0xFF29282C noir

class App extends StatelessWidget {
  ThemeData get theme => ThemeData(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          unselectedItemColor: Colors.white,
          selectedItemColor: Color(0xFFF7BB0E),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.black,
        canvasColor: Colors.black, // Color(0xFF282B2E),
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          color: Colors.black,
        ),
        accentColor: Color(0xFFF7BB0E),
        fontFamily: 'FiraGO',
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScaffoldd(),
      theme: theme,
    );
  }
}

void main() => runApp(App());
