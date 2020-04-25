import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutterbluetoothproximity/providers/bluetooth.dart';
import 'package:flutterbluetoothproximity/screens/bluetooth.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bluetooth Proximity',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(providers: [
        ChangeNotifierProvider<BluetoothProvider>(create: (_) => BluetoothProvider()),
        StreamProvider<BluetoothState>(create: (_) => FlutterBlue.instance.state),
      ], child: BluetoothScreen()),
    );
  }
}
