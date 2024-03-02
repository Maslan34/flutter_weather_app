# Weather App

This Weather App is a simple Flutter application that fetches and displays weather data for Istanbul, Ankara, and Izmir. It utilizes the Open-Meteo API to retrieve weather information such as temperature, visibility, pressure, and soil moisture.

## Project Teaser

![Teaser](/teaser/teaser.gif)

## Getting Started

To run this app, you need to have Flutter installed on your machine. Clone the repository, navigate to the project directory, and follow these steps:


### Installation

1. Clone the repository:

```bash

git clone https://github.com/Maslan34/flutter_weather_app.git

````

2. Navigate to the project directory:

    ```bash
    cd flutter_weather_app
    ```

3. Run the app:

    ```bash
    flutter run
    ```

1. **Get dependencies:**

   Run `flutter pub get` to install the necessary dependencies.

2. **Run the app:**

   Execute `flutter run` to run the app on a connected device or an emulator.

## Dependencies

- `http`: For making network requests to the Open-Meteo API.
- `flutter_lottie`: For displaying animations that represent the current weather condition.
- `cupertino_icons`: This is an asset repo containing the default set of icon assets used by Flutter's Cupertino widgets..


## Usage

Upon launching the app, it will automatically fetch weather data for Istanbul, Ankara, and Izmir. Swipe left or right to navigate between cities. The app will display the current weather condition along with detailed weather information including temperature, visibility, pressure, and moisture levels.The background animation will change between day and night based on the current time, providing an immersive user experience.

## Features

- Displays current weather information for three cities: Istanbul, Ankara, and Izmir.
- Provides detailed weather information including temperature, visibility, pressure, and moisture levels.
- Includes animations to visually represent the current weather condition (sunny, rainy, cloudy, snowy).
- Uses a `PageView` to allow users to swipe between cities and see their respective weather details.
- Implements a custom shadow and light animation that simulates a day and night cycle based on the current time.

# API LINK

- https://open-meteo.com/






