import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutterbluetoothproximity/screens/bluetooth_off.dart';
import 'package:flutterbluetoothproximity/screens/bluetooth_on.dart';
import 'package:provider/provider.dart';

class BluetoothScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    BluetoothState state = Provider.of<BluetoothState>(context);

    if (state == BluetoothState.on) {
      return BluetoothOnScreen();
    }

    return BluetoothOffScreen(state);
  }
}
