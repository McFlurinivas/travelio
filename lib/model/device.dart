import 'package:flutter/material.dart';

class DeviceModel {
  final String name;
  String iconPath;
  final String backgroundPath;
  Color backgroundColor;
  bool isActive;

  DeviceModel({
    required this.name,
    required this.iconPath,
    required this.backgroundPath,
    required this.backgroundColor,
    required this.isActive,
  });
}
