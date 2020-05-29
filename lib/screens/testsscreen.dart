import 'package:flutter/material.dart';

class TestsScreen extends StatefulWidget {
  TestsScreen({Key key}) : super(key: key);

  @override
  _TestsScreenState createState() => _TestsScreenState();
}

class _TestsScreenState extends State<TestsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterLogo(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Add'),
        icon: Icon(Icons.add_circle_outline),
        onPressed: (){},
      ),
    );
  }
}
