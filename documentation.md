=================================================
Heart Rate App Documentation
=================================================

Table of Contents
-----------------
1. Introduction
2. Installation
3. Usage
4. Class Overview <br />
    4.1 MyApp <br />
    4.2 WelcomePage <br />
    4.3 HealthyHeartPage <br />
    4.4 UnhealthyHeartPageHigh <br />
    4.5 UnhealthyHeartPageLow

1. Introduction
-----------------
The Heart Rate App is a Flutter application that calculates and analyzes heart rates based on age. It provides information about whether the heart rate is healthy, too high, or too low, along with tips for maintaining a healthy heart rate.

2. Installation
-----------------
To install the Heart Rate App, follow these steps:
1. Install Flutter on your development machine.
2. Clone the project from the repository.
3. Open the project in your preferred IDE.
4. Run the `flutter pub get` command to install the project dependencies.
5. Connect a mobile device or emulator.
6. Run the `flutter run` command to start the application.

3. Usage
-----------------
To use the Heart Rate App, follow these steps:
1. Launch the application on your mobile device or emulator.
2. Enter your age in the provided text field.
3. Tap the "Enter" button to calculate and analyze your heart rate.
4. Based on your heart rate and age, you will be directed to one of the following pages:
   - HealthyHeartPage: If your heart rate is within the healthy range.
   - UnhealthyHeartPageHigh: If your heart rate is too high for your age.
   - UnhealthyHeartPageLow: If your heart rate is too low for your age.
5. On each page, you will find information about your heart rate and relevant tips.
6. Tap the "Back" button to return to the previous page or the welcome page.

4. Class Overview
-----------------
4.1 MyApp
--------------
This class represents the root of the Flutter application. It sets up the application's routes and initializes the MaterialApp.

4.2 WelcomePage
-----------------
This class represents the welcome page of the Heart Rate App. It allows users to enter their age and initiates the heart rate analysis based on the entered age.

- Function `_readHeartRateFromFile()`: 
  Reads the heart rate value from a file and returns it as an integer or `null` if the heart rate cannot be read.

- Function `_handleStartButtonPressed(BuildContext context, var sAge)`:
  Handles the start button press event. It takes the `BuildContext` and `sAge` (age as a string) as parameters. This function converts the age to an integer and reads the heart rate from the file using `_readHeartRateFromFile()`. Based on the age and heart rate values, it navigates to the appropriate page or displays an error dialog if the heart rate cannot be read.

4.3 HealthyHeartPage
-----------------
This class represents the page displayed when the heart rate is within the healthy range for the entered age. It displays the heart rate value and a message indicating a healthy heart rate.

4.4 UnhealthyHeartPageHigh
-----------------
This class represents the page displayed when the heart rate is too high for the entered age. It displays the heart rate value and provides tips for lowering the heart rate.

4.5 UnhealthyHeartPageLow
-----------------
This class represents the page displayed when the heart rate is too low for the entered age. It displays the heart rate value and provides tips for increasing the heart rate.
