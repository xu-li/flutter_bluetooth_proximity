import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutterbluetoothproximity/providers/bluetooth.dart';
import 'package:flutterbluetoothproximity/widgets/devices.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class BluetoothOnScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BluetoothProvider provider = Provider.of<BluetoothProvider>(context);

    if (!provider.permissionsGranted) {
      return Scaffold(body: Center(child: Text("Permissions are required.")));
    }

    bool isScanning = provider.isScanning;
    return Scaffold(
      body: Center(child: DeviceList(provider.scanResults)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => isScanning ? provider.stopScan() : provider.startScan(),
        tooltip: isScanning ? 'Stop' : 'Start',
        child: Icon(isScanning ? Icons.pause : Icons.play_arrow),
      ),
    );
  }
}
