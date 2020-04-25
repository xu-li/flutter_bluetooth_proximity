import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class DeviceList extends StatelessWidget {
  final List<ScanResult> results;

  DeviceList(this.results);

  @override
  Widget build(BuildContext context) {
    return results.isEmpty
        ? Text("There is no device around you.")
        : ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              ScanResult result = results[index];
              return ListTile(title: buildTitle(result), subtitle: buildSubtitle(result));
            });
  }

  Widget buildTitle(ScanResult result) {
    return Text((result.device.name ?? "Unknown") + " - " + result.device.id.id);
  }

  Widget buildSubtitle(ScanResult result) {
    return Text(
        "RSSI: " + result.rssi.toString() + ", Distance: " + calculateDistanceFromRSSI(result.rssi).toString() + "m");
  }

  ///
  /// @see https://gist.github.com/eklimcz/446b56c0cb9cfe61d575
  double calculateDistanceFromRSSI(int rssi) {
    var txPower = -59;

    if (rssi == 0) {
      return -1.0;
    }

    var ratio = rssi * 1.0 / txPower;
    if (ratio < 1.0) {
      return pow(ratio, 10);
    } else {
      var distance = (0.89976) * pow(ratio, 7.7095) + 0.111;
      return distance;
    }
  }
}
