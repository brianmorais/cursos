import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.none:
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            return ScopedModel<UserModel>(
              model: UserModel(),
              child: ScopedModelDescendant<UserModel>(
                builder: (context, child, model) {
                  return ScopedModel<CartModel>(
                    model: CartModel(model),
                    child: MaterialApp(
                      title: 'Loja Virtual',
                      theme: ThemeData(
                        primarySwatch: Colors.blue,
                        primaryColor: Color.fromARGB(255, 4, 125, 141),
                      ),
                      debugShowCheckedModeBanner: false,
                      home: HomeScreen(),
                    ),
                  );
                },
              ),
            );
        }
      },
    );
  }
}
