
import 'package:flutter/material.dart';
import 'package:travelio/view_model/device_view_model.dart';
import 'package:travelio/view_model/room_view_model.dart';
import '../widget/device_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DeviceViewModel deviceViewModel = DeviceViewModel();
  final RoomViewModel roomViewModel = RoomViewModel();
  bool isCelsius = true;
  final PageController _pageController = PageController();
  final PageStorageBucket _bucket = PageStorageBucket();
  int _currentRoomIndex = 0;

  double get temperature => isCelsius
      ? deviceViewModel.currentTemperature
      : deviceViewModel.currentTemperature * 1.8 + 32;

  void _showAddRoomDialog() {
    TextEditingController roomNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: deviceViewModel
          .devices[deviceViewModel.activeDeviceIndex].backgroundColor.withOpacity(0.8),
          title: const Text('Create New Room'),
          content: TextField(
            controller: roomNameController,
            decoration: const InputDecoration(hintText: "Room Name"),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Create'),
              onPressed: () {
                setState(() {
                  roomViewModel.addRoom(
                      "${roomNameController.text[0].toUpperCase()}${roomNameController.text.substring(1).toLowerCase()}");
                });
                Navigator.of(context).pop();

                Future.delayed(const Duration(milliseconds: 200), () {
                  _pageController.jumpToPage(roomViewModel.rooms.length - 1);
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: deviceViewModel
          .devices[deviceViewModel.activeDeviceIndex].backgroundColor,
      body: PageView.builder(
        key: const PageStorageKey<String>('pageView'),
        controller: _pageController,
        itemCount: roomViewModel.rooms.length,
        onPageChanged: (index) {
          setState(() {
            roomViewModel.setActiveRoom(index);
            _currentRoomIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return PageStorage(
            key: PageStorageKey<int>(index),
            bucket: _bucket,
            child: AnimatedContainer(
              duration: const Duration(seconds: 2),
              color: deviceViewModel.devices[deviceViewModel.activeDeviceIndex]
                      .isActive
                  ? deviceViewModel
                      .devices[deviceViewModel.activeDeviceIndex]
                      .backgroundColor
                  : Colors.black.withOpacity(0.5),
              child: Stack(
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(seconds: 1),
                    child: Image.asset(
                      deviceViewModel.activeBackground,
                      color: deviceViewModel
                              .devices[deviceViewModel.activeDeviceIndex]
                              .isActive
                          ? null
                          : Colors.black.withOpacity(0.5),
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
                          const SizedBox(height: 40,),
                          const Row(
                            children: [
                              Icon(Icons.arrow_back,
                                  size: 30, color: Colors.white),
                              Spacer(),
                              Icon(Icons.settings,
                                  size: 30, color: Colors.white),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            roomViewModel.rooms[roomViewModel.activeRoomIndex].name,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          roomViewModel.rooms.length > 1
                              ? Row(
                                  children: roomViewModel.rooms.map((room) {
                                    int index = roomViewModel.rooms.indexOf(room);
                                    return Container(
                                      width: 8.0,
                                      height: 8.0,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 2.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _currentRoomIndex == index
                                            ? Colors.white
                                            : Colors.grey,
                                      ),
                                    );
                                  }).toList(),
                                )
                              : const SizedBox(),
                          Text(
                            '${deviceViewModel.activeDevicesCount} devices active',
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[300]),
                          ),
                          const SizedBox(height: 16),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isCelsius = !isCelsius;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.thermostat_outlined,
                                      color: Colors.white),
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                      text: temperature.toInt().toString(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    TextSpan(
                                      text: isCelsius ? '°c' : '°f',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ]))
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          Slider(
                            activeColor: deviceViewModel
                                .devices[deviceViewModel.activeDeviceIndex]
                                .backgroundColor,
                            thumbColor: Colors.white,
                            label: temperature.toInt().toString(),
                            value: deviceViewModel.currentTemperature,
                            min: 0.0,
                            max: 100.0,
                            onChanged: (value) {
                              setState(() {
                                deviceViewModel.updateTemperature(value);
                              });
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
                                      setState(() {
                                        if (deviceViewModel.activeDeviceIndex ==
                                            index) {
                                          deviceViewModel
                                              .toggleDeviceStatus(index);
                                        } else {
                                          deviceViewModel
                                              .setActiveDevice(index);
                                        }
                                      });
                                    },
                                    child: SizedBox(
                                        width: 140,
                                        child: DeviceWidget(
                                            device: deviceViewModel
                                                .devices[index])),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          InkWell(
                            onTap: _showAddRoomDialog,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_circle_outline,
                                      size: 30, color: Colors.white),
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
            ),
          );
        },
      ),
    );
  }
}