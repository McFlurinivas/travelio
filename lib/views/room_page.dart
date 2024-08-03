import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelio/view_model/device_view_model.dart';
import 'package:travelio/view_model/room_view_model.dart';
import '../widget/device_widget.dart';

class RoomPage extends StatefulWidget {
  final int roomIndex;
  final bool isCelsius;
  final VoidCallback toggleTemperatureUnit;
  final Function(BuildContext) showAddRoomDialog;

  const RoomPage({
    required Key key,
    required this.roomIndex,
    required this.isCelsius,
    required this.toggleTemperatureUnit,
    required this.showAddRoomDialog,
  }) : super(key: key);

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  double getTemperature(double temp, bool isCelsius) {
    return isCelsius ? temp : temp * 1.8 + 32;
  }

  @override
  Widget build(BuildContext context) {
    final deviceViewModel = Provider.of<DeviceViewModel>(context);
    final roomViewModel = Provider.of<RoomViewModel>(context);
    final room = roomViewModel.rooms[widget.roomIndex];
    final isActiveDevice = deviceViewModel.devices[deviceViewModel.activeDeviceIndex].isActive;
    final backgroundColor = deviceViewModel.devices[deviceViewModel.activeDeviceIndex].backgroundColor;

    return AnimatedContainer(
      duration: const Duration(seconds: 2),
      color: isActiveDevice ? backgroundColor : Colors.black.withOpacity(0.5),
      child: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            child: Image.asset(
              deviceViewModel.activeBackground,
              color: isActiveDevice ? null : Colors.black.withOpacity(0.5),
              key: ValueKey<String>(deviceViewModel.activeBackground),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  const Row(
                    children: [
                      Icon(Icons.arrow_back, size: 30, color: Colors.white),
                      Spacer(),
                      Icon(Icons.settings, size: 30, color: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    room.name,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  if (roomViewModel.rooms.length > 1)
                    Row(
                      children: roomViewModel.rooms.map((room) {
                        int index = roomViewModel.rooms.indexOf(room);
                        return Container(
                          width: 8.0,
                          height: 8.0,
                          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.roomIndex == index ? Colors.white : Colors.grey,
                          ),
                        );
                      }).toList(),
                    ),
                  Text(
                    '${deviceViewModel.activeDevicesCount} devices active',
                    style: TextStyle(fontSize: 16, color: Colors.grey[300]),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: widget.toggleTemperatureUnit,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.thermostat_outlined, color: Colors.white),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: getTemperature(deviceViewModel.currentTemperature, widget.isCelsius)
                                      .toInt()
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                TextSpan(
                                  text: widget.isCelsius ? '°c' : '°f',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Slider(
                    activeColor: backgroundColor,
                    thumbColor: Colors.white,
                    label: getTemperature(deviceViewModel.currentTemperature, widget.isCelsius).toInt().toString(),
                    value: deviceViewModel.currentTemperature,
                    min: 0.0,
                    max: 100.0,
                    onChanged: (value) {
                      deviceViewModel.updateTemperature(value);
                    },
                  ),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: deviceViewModel.devices.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: GestureDetector(
                            onTap: () {
                              if (deviceViewModel.activeDeviceIndex == index) {
                                deviceViewModel.toggleDeviceStatus(index);
                              } else {
                                deviceViewModel.setActiveDevice(index);
                              }
                            },
                            child: SizedBox(
                              width: 140,
                              child: DeviceWidget(device: deviceViewModel.devices[index]),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () => widget.showAddRoomDialog(context),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_circle_outline, size: 30, color: Colors.white),
                        Text('Add', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
