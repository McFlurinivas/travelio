import 'package:flutter/material.dart';
import 'package:travelio/model/room.dart';

class RoomViewModel extends ChangeNotifier {
  List<Room> rooms = [
    Room(name: 'Office'),
  ];

  int _activeRoomIndex = 0;

  int get activeRoomIndex => _activeRoomIndex;

  void addRoom(String roomName) {
    rooms.add(Room(name: roomName));
    notifyListeners();
  }

  void setActiveRoom(int index) {
    _activeRoomIndex = index;
    notifyListeners();
  }
}
