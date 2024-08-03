# Smart Home Control App

A Flutter-based smart home control application that allows users to manage devices and rooms, view real-time temperature, and more. The app features a splash screen with animations, device management, and dynamic room views.

## Features

- **Device Management:** Toggle device status and view device details.
- **Dynamic Room Views:** Manage multiple rooms and view devices within them.
- **Temperature Control:** Adjust and display current temperature with temperature unit switch (Celsius/Fahrenheit).
- **Animated Splash Screen:** A visually appealing introduction to the app.

## Screenshots

![Splash Screen](assets/readme_assets/splashScreen.gif)
![Home Page](assets/readme_assets/homePage.gif)
![Add Rooms](assets/readme_assets/add_rooms.gif)

## Getting Started

To get started with this project, follow the instructions below.

### Prerequisites

- Flutter SDK
- Dart SDK
- An IDE such as Visual Studio Code or Android Studio

### Installation

1. **Clone the repository:**

    ```bash
    git clone https://github.com/McFlurinivas/travelio.git
    ```

2. **Navigate to the project directory:**

    ```bash
    cd smart-home-control-app
    ```

3. **Install dependencies:**

    ```bash
    flutter pub get
    ```

4. **Run the app:**

    ```bash
    flutter run
    ```

## Directory Structure

- `lib/`
  - `model/` - Contains data models for devices and rooms.
  - `view_model/` - Contains view models managing state and logic for devices and rooms.
  - `view/` - Contains UI code and screens.
  - `widget/` - Contains reusable UI components.

## Code Overview

- **DeviceModel:** Defines the properties of a device.
- **Room:** Defines the properties of a room.
- **DeviceViewModel:** Manages the state and logic related to devices. That is 
- **RoomViewModel:** Manages the state and logic related to rooms.
- **HomePage:** Main screen that displays devices and rooms.
- **SplashScreen:** Initial screen with animations.
- **DeviceWidget:** UI component for displaying device information.
