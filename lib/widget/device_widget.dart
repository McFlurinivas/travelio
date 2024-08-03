import 'package:flutter/material.dart';
import 'package:travelio/model/device.dart';

class DeviceWidget extends StatelessWidget {
  final DeviceModel device;

  const DeviceWidget({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        radius: 40,
                        child: Image.asset(
                          device.iconPath,
                          width: 30,
                          height: 30,
                        ),
                      ),
                      Positioned(
                        right: 10,
                        bottom: 0,
                        child: Icon(
                          Icons.circle,
                          color: device.isActive ? Colors.green : Colors.red,
                          size: 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(device.name,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600])),
                  const SizedBox(height: 4),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 5,
                height: 80,
                color: device.isActive ? Colors.yellow : Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
