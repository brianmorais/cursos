import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Floating Button',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const platform = const MethodChannel("floating_button");
  int count = 0;

  @override
  void initState() {
    super.initState();
    platform.setMethodCallHandler((call) async {
      if (call.method == "touch") {
        setState(() {
          count++;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Floating Button Demo'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '$count',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 50),
            ),
            ElevatedButton(
              onPressed: () {
                platform.invokeMethod('create');
              },
              child: Text('Create'),
            ),
            ElevatedButton(
              onPressed: () {
                platform.invokeMethod('show');
              },
              child: Text('Show'),
            ),
            ElevatedButton(
              onPressed: () {
                platform.invokeMethod('hide');
              },
              child: Text('Hide'),
            ),
            ElevatedButton(
              onPressed: () {
                platform.invokeMethod("isShowing").then(
                      (value) => print(value),
                    );
              },
              child: Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }
}
