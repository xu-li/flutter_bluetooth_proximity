import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothOffScreen extends StatelessWidget {
  final BluetoothState state;

  BluetoothOffScreen(this.state);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: state == null
                ? Text("Bluetooth is not available on your device.")
                : Text("Bluetooth: " + state.toString())));
  }
}
