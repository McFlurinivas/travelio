# Smart Home Control App

A Flutter-based smart home control application that allows users to manage devices and rooms, view real-time temperature, and more. The app features a splash screen with animations, device management, and dynamic room views.

Go to this link for app overview: https://drive.google.com/file/d/1ppac8lrdpI5Ygwbduj4a8LE_MRVLJSbU/view?usp=drive_link

## Features

- **Device Management:** Toggle device status and view device details.
- **Dynamic Room Views:** Manage multiple rooms and view devices within them.
- **Temperature Control:** Adjust and display current temperature with temperature unit switch (Celsius/Fahrenheit).
- **Animated Splash Screen:** A visually appealing introduction to the app.

## Screenshots

| Splash Screen | Home Screen | Add Rooms |
|---------------|-------------|-----------|
| <img src="assets/readme_assets/splashScreen.gif" alt="Splash Screen" height="400"/> | <img src="assets/readme_assets/homePage.gif" alt="Home Screen" height="400"/> | <img src="assets/readme_assets/add_rooms.gif" alt="Add Rooms" height="400"/> |

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

- **DeviceModel:** 
  Defines the properties of a device. It includes:
  - `name`: The name of the device.
  - `iconPath`: The path to the device's icon.
  - `backgroundPath`: The path to the background image for the device.
  - `backgroundColor`: The background color associated with the device.
  - `isActive`: A boolean indicating whether the device is active or not.

- **Room:** 
  Defines the properties of a room. It includes:
  - `name`: The name of the room.

- **DeviceViewModel:** 
  Manages the state and logic related to devices. Key responsibilities include:
  - Handling a list of devices.
  - Managing device states such as whether a device is active or not.
  - Keeping track of the current temperature.
  - Determining which device is currently active.
  - Notifying listeners of any changes to update the UI accordingly.

- **RoomViewModel:** 
  Manages the state and logic related to rooms. Key functionalities include:
  - Adding new rooms to the list.
  - Changing the active room.
  - Notifying listeners about updates to the room list or the active room index.
  - Ensuring dynamic updates to the UI in response to changes in room data.

- **HomePage:** 
  The main screen that integrates device and room management with a dynamic UI. Features include:
  - Displaying and navigating between rooms using a `PageView`.
  - Managing and displaying device states and backgrounds.
  - Toggling temperature units (°C or °F) and adjusting the temperature with a slider.
  - Adding new rooms by clicking `add button` and entering the room name in a dialog box.
  - Updating UI elements and handling interactions with `DeviceViewModel` and `RoomViewModel`.
  - **Device Status Feedback:**
    - When a device is **on**:
      - The background color of the page brightens.
      - The background image (i.e. the respective appliances) becomes more vibrant.
      - The active signal changes to green, indicating that the device is switched on.
    - When a device is **off**:
      - The background color and image fade.
      - The active signal changes to red, indicating that the device is switched off.

- **SplashScreen:** 
  Displays the initial screen with animations.

- **DeviceWidget:** 
  A UI component designed to visually represent a device with:
  - **Icon:** Displayed in a circular avatar showing the device’s icon.
  - **Status Indicator:** A small circle indicating whether the device is active or inactive. (GREEN: On; RED: Off)
  - **Name:** Displayed below the icon with distinctive styling.
  - **Status Bar:** A vertical bar on the right side that reflects the device's status with color changes. (YELLOW: On; GREY: Off)
  
  This widget is suitable for use in lists where a collection of devices needs to be displayed with their icons, names, and statuses.
