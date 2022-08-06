import 'package:flutter/material.dart';

enum DeviceStatus {
  unknown,
  ok,
  error,
}

class DeviceModel extends ChangeNotifier {
  final List<Device> _devices = [
    Device("Herbert's\nnotebook",
        icon: Icons.computer, iconPath: "assets/macbook_icon2.png"),
    Device("Herbert's\nsmartphone",
        icon: Icons.phone_android, iconPath: "assets/iphone_icon.png"),
    Device("Herbert's\ntablet",
        icon: Icons.tablet_android, iconPath: "assets/ipad_icon.png"),
    Device("Device XUA-192", icon: Icons.router),
    Device("Andrea's smartphone", icon: Icons.phone_android),
    Device("Daniel's tablet", icon: Icons.tablet_android),
  ];

  List<Device> get devices => _devices;

  Device getDevice(int index) {
    return _devices[index];
  }

  DeviceStatus getConnectionStatus() {
    if (anyConnectionProblems()) return DeviceStatus.error;
    if (anyUnknown()) return DeviceStatus.unknown;
    return DeviceStatus.ok;
  }

  DeviceStatus getSecurityStatus() {
    if (anySecurityProblems()) return DeviceStatus.error;
    if (anyUnknown()) return DeviceStatus.unknown;
    return DeviceStatus.ok;
  }

  bool anyProblems() {
    return anyConnectionProblems() || anySecurityProblems();
  }

  bool anyConnectionProblems() {
    return _devices.any((device) => device.hasConnectionProblem());
  }

  bool anySecurityProblems() {
    return _devices.any((device) => device.hasSecurityProblem());
  }

  bool anyUnknown() {
    return _devices.any((device) => device.hasUnknown());
  }

  DeviceStatus _nextStatus(DeviceStatus status) {
    var size = DeviceStatus.values.length;
    var nextStatus = DeviceStatus.values[(status.index + 1) % size];
    return nextStatus;
  }

  void toggleDeviceSecurityStatus(int index) {
    _devices[index].securityStatus =
        _nextStatus(_devices[index].securityStatus);
    notifyListeners();
  }

  void toggleDeviceConnectionStatus(int index) {
    _devices[index].connectionStatus =
        _nextStatus(_devices[index].connectionStatus);
    notifyListeners();
  }

  void toggleDevicePerformanceStatus(int index) {
    _devices[index].performanceStatus =
        _nextStatus(_devices[index].performanceStatus);
    notifyListeners();
  }

  void createIssue() {
    _devices[0].performanceStatus = DeviceStatus.error;
    // On purpose doesn't call notify listeners, the screen should not change
    // until the notification is tapped! This is a hacky workaround...
  }

  void fixIssue() {
    _devices[0].performanceStatus = DeviceStatus.ok;
  }
}

class Device {
  final String name;
  final IconData icon;
  final String iconPath;
  DeviceStatus securityStatus = DeviceStatus.ok;
  DeviceStatus connectionStatus = DeviceStatus.ok;
  DeviceStatus performanceStatus = DeviceStatus.ok;

  bool hasConnectionProblem() {
    return connectionStatus == DeviceStatus.error ||
        performanceStatus == DeviceStatus.error;
  }

  bool hasSecurityProblem() {
    return securityStatus == DeviceStatus.error;
  }

  bool hasUnknown() {
    return securityStatus == DeviceStatus.unknown ||
        connectionStatus == DeviceStatus.unknown ||
        performanceStatus == DeviceStatus.unknown;
  }

  Device(this.name,
      {required this.icon, this.iconPath = "assets/logo_square.png"});
}
