import 'package:flutter/material.dart';

class NoticesScreen extends StatefulWidget {
  NoticesScreen({Key key}) : super(key: key);

  @override
  _NoticesScreenState createState() => _NoticesScreenState();
}

class _NoticesScreenState extends State<NoticesScreen> {
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
