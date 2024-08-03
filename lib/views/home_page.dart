import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelio/view_model/device_view_model.dart';
import 'package:travelio/view_model/room_view_model.dart';
import 'room_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isCelsius = true;
  final PageController _pageController = PageController();

  double getTemperature(double temp, bool isCelsius) {
    return isCelsius ? temp : temp * 1.8 + 32;
  }

  void _showAddRoomDialog(BuildContext context) {
    TextEditingController roomNameController = TextEditingController();
    final deviceViewModel = Provider.of<DeviceViewModel>(context, listen: false);
    final roomViewModel = Provider.of<RoomViewModel>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: deviceViewModel
              .devices[deviceViewModel.activeDeviceIndex]
              .backgroundColor
              .withOpacity(0.8),
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
                roomViewModel.addRoom(
                  "${roomNameController.text[0].toUpperCase()}${roomNameController.text.substring(1).toLowerCase()}",
                );
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
    final deviceViewModel = Provider.of<DeviceViewModel>(context);
    final roomViewModel = Provider.of<RoomViewModel>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: deviceViewModel
          .devices[deviceViewModel.activeDeviceIndex]
          .backgroundColor,
      body: PageView.builder(
        controller: _pageController,
        itemCount: roomViewModel.rooms.length,
        itemBuilder: (context, index) {
          return RoomPage(
            key: ValueKey(index),
            roomIndex: index,
            isCelsius: isCelsius,
            toggleTemperatureUnit: () {
              setState(() {
                isCelsius = !isCelsius;
              });
            },
            showAddRoomDialog: _showAddRoomDialog,
          );
        },
      ),
    );
  }
}
