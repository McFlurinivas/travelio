import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelio/view_model/device_view_model.dart';
import 'package:travelio/view_model/room_view_model.dart';
//import 'package:travelio/views/home_page.dart';
import 'package:travelio/views/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DeviceViewModel()),
        ChangeNotifierProvider(create: (_) => RoomViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}