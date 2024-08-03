import 'package:flutter/material.dart';
import 'package:travelio/model/device.dart';

class DeviceViewModel extends ChangeNotifier {
  List<DeviceModel> devices = [
    DeviceModel(
      name: 'Light',
      iconPath: 'assets/light/icon.png',
      backgroundPath: 'assets/light/light.png',
      backgroundColor: const Color(0xFF8b9b90),
      isActive: true,
    ),
    DeviceModel(
      name: 'Smart TV',
      iconPath: 'assets/tv/icon.png',
      backgroundPath: 'assets/tv/tv.png',
      backgroundColor: const Color(0xFFd09365),
      isActive: false,
    ),
    DeviceModel(
      name: 'Fan',
      iconPath: 'assets/fan/icon.png',
      backgroundPath: 'assets/fan/fan.png',
      backgroundColor: const Color(0xFFad2934),
      isActive: false,
    ),
    DeviceModel(
      name: 'Speaker',
      iconPath: 'assets/speaker/icon.png',
      backgroundPath: 'assets/speaker/speaker.png',
      backgroundColor: const Color(0xFF848484),
      isActive: false,
    ),
  ];

  double _currentTemperature = 23;
  int _activeDeviceIndex = 0;

  double get currentTemperature => _currentTemperature;
  int get activeDeviceIndex => _activeDeviceIndex;
  String get activeBackground => devices[_activeDeviceIndex].backgroundPath;
  int get activeDevicesCount => devices.where((device) => device.isActive).length;

  void toggleDeviceStatus(int index) {
    devices[index].isActive = !devices[index].isActive;
    notifyListeners();
  }

  void updateTemperature(double newTemp) {
    _currentTemperature = newTemp;
    notifyListeners();
  }

  void setActiveDevice(int index) {
    _activeDeviceIndex = index;
    notifyListeners();
  }
}
