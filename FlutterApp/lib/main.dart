import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Heart Rate App',
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomePage(),
        '/healthy': (context) => HealthyHeartPage(),
        '/unhealthy': (context) => UnhealthyHeartPage(),
      },
    );
  }
}


class WelcomePage extends StatelessWidget {
  Future<int?> _readHeartRateFromFile() async {
    String contents = File("/Users/zach/receiving_demo/javadata/heartrate.txt").readAsStringSync();
    return int.tryParse(contents);
  }

  void _handleStartButtonPressed(BuildContext context) async {
    final heartRate = await _readHeartRateFromFile();
    if (heartRate != null) {
      if (heartRate >= 60 && heartRate <= 100) {
        Navigator.pushNamed(context, '/healthy', arguments: heartRate);
      } else {
        Navigator.pushNamed(context, '/unhealthy', arguments: heartRate);
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Unable to read heart rate from file.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Heart Rate Monitor'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _handleStartButtonPressed(context),
          child: Text('Click Here to Start'),
        ),
      ),
    );
  }
}

class HealthyHeartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int heartRate = ModalRoute.of(context)?.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        title: Text('Healthy Heart'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Your heart rate is $heartRate bpm'),
            SizedBox(height: 16.0),
            Text('Your heart rate is healthy!'),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class UnhealthyHeartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int heartRate = ModalRoute.of(context)?.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        title: Text('Unhealthy Heart'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Your heart rate is $heartRate bpm'),
            SizedBox(height: 16.0),
            Text('Your heart rate is not healthy. Here are some tips:'),
            SizedBox(height: 8.0),
            Text('- Exercise regularly'),
            Text('- Eat a healthy diet'),
            Text('- Manage stress'),
            Text('- Get enough sleep'),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
