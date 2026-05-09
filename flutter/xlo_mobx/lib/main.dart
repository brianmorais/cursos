import 'package:flutter/material.dart';
import 'package:xlo_mobx/screens/base/base_screen.dart';
import 'package:xlo_mobx/startup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Startup.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XLO MobX',
      theme: ThemeData(
        primaryColor: Colors.purple,
        scaffoldBackgroundColor: Colors.purple,
        appBarTheme: AppBarTheme(
          elevation: 0,
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.orange,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: BaseScreen(),
    );
  }
}
