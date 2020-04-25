import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:location/location.dart' show Location;
import 'package:permission_handler/permission_handler.dart';

class BluetoothProvider with ChangeNotifier {
  FlutterBlue _bluetooth;

  bool _permissionsGranted = false;
  bool _locationServiceEnabled = false;
  bool _isScanning = false;

  List<ScanResult> _scanResults = [];
  StreamSubscription _subscription;
  Location _location;


  BluetoothProvider() {
    _bluetooth = FlutterBlue.instance;
    _location = Location();

    requestPermissions().then((granted) {
      permissionsGranted = granted;
    });

    _location.serviceEnabled().then((value) {
      if (_locationServiceEnabled != value) {
        _locationServiceEnabled = value;
        notifyListeners();
      }

      if (!value) {
        _location.requestService();
      }
    });

    _bluetooth.isScanning.listen((value) {
      if (_isScanning != value) {
        _isScanning = value;
        notifyListeners();
      }
    });
  }

  startScan() {
    if (!permissionsGranted) {
      return;
    }

    _subscription?.cancel();

    _subscription = _bluetooth.scanResults.listen((results) {
      scanResults = results;
    }, onError: (error) {
      print("Bluetooth scan error: $error.");
    }, onDone: () {
      print("Bluetooth scan finished.");
    });

    if (!isScanning) {
      _bluetooth.startScan();
    }
  }

  stopScan() {
    _subscription?.cancel();
    _subscription = null;
    _bluetooth.stopScan();

    notifyListeners();
  }

  Future<bool> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [Permission.locationAlways].request();

    bool allGranted = true;

    statuses.forEach((perm, status) {
      if (!status.isGranted) {
        allGranted = false;
      }
    });

    return allGranted;
  }

  @override
  void dispose() {
    super.dispose();

    stopScan();
  }

  List<ScanResult> get scanResults => _scanResults;

  set scanResults(List<ScanResult> value) {
    _scanResults = value;
    notifyListeners();
  }

  bool get permissionsGranted => _permissionsGranted;

  set permissionsGranted(bool value) {
    if (value != _permissionsGranted) {
      _permissionsGranted = value;
      notifyListeners();
    }
  }

  bool get isScanning => _isScanning;
}
