import 'dart:ffi';
import 'dart:io';
import 'dart:developer';
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
        '/unhealthyHigh': (context) => UnhealthyHeartPageHigh(),
        '/unhealthyLow': (context) => UnhealthyHeartPageLow(),
      },
    );
  }
}

class WelcomePage extends StatelessWidget {
  Future<int?> _readHeartRateFromFile() async {
    String contents = File("/Users/zach/receiving_demo/javadata/heartrate.txt").readAsStringSync();
    return int.tryParse(contents);
  }

  void _handleStartButtonPressed(BuildContext context, var sAge) async {
    var age = int.parse(sAge);
    final heartRate = await _readHeartRateFromFile();
    if (heartRate != null) {
      if (age < 10) { // FOR AGES 9 AND BELOW
        if (heartRate < 75) {
          Navigator.pushNamed(context, '/unhealthyLow', arguments: heartRate);
        } else if (heartRate > 120) {
          Navigator.pushNamed(context, '/unhealthyHigh', arguments: heartRate);
        } else {
          Navigator.pushNamed(context, '/healthy', arguments: heartRate);
        }
      } else if (age >= 10) { // AGES 10 AND UP
        if (heartRate < 60) {
          Navigator.pushNamed(context, '/unhealthyLow', arguments: heartRate);
        } else if (heartRate > 110) {
          Navigator.pushNamed(context, '/unhealthyHigh', arguments: heartRate);
        } else {
          Navigator.pushNamed(context, '/healthy', arguments: heartRate);
        }
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


  // use this controller to get what the user is typing
  final _textController = TextEditingController();

  //store user age from input (as string)
  String sAge = '';  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Heart Rate Monitor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
            child: Center (child: Image.asset('assets/heart.jpeg', height:200, width: 200),
            ),
            ),
            SizedBox(height: 100.0),
            Container(
            child: Container(
              child: Center(
                child: Text('To determine a healthy heart rate, enter your age:', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),
            ),
            ),
            SizedBox(height: 10.0),
          TextField(
            controller: _textController,
            decoration: InputDecoration(
              hintText: 'Enter your age',
              border: const OutlineInputBorder(),
              suffixIcon: 
                IconButton(
                  onPressed: () {
                    // clear whats in text field
                    _textController.clear();
                  }, 
                icon: Icon(Icons.clear)
                ),
              ),
          ),
          MaterialButton(
            onPressed: () =>  _handleStartButtonPressed(context, _textController.text),
            color: Colors.blue,
            child: Text('Enter', style: TextStyle(color: Colors.white)),
          ),
        ],
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
            Text('Your heart rate is $heartRate bpm', style: TextStyle(color: Colors.green, fontSize: 25, fontWeight: FontWeight.bold),),
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

class UnhealthyHeartPageHigh extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int heartRate = ModalRoute.of(context)?.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        title: Text('High Heart Rate!'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Your heart rate is $heartRate bpm!',  style: TextStyle(color: Colors.red, fontSize: 25, fontWeight: FontWeight.bold),),
            Text('Your heart rate is too high for your age. Here are some tips to lower it:', textAlign: TextAlign.center,),
            SizedBox(height: 8.0),
            Text('- Exercise regularly'),
            Text('- Eat healthy. Avoid caffeine and salt.'),
            Text('- Manage stress. Try and take a deep breath!'),
            Text('- Get enough sleep'),
            Text('- Drink plenty of water.'),
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

class UnhealthyHeartPageLow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int heartRate = ModalRoute.of(context)?.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        title: Text('Low Heart Rate!'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Your heart rate is $heartRate bpm!',  style: TextStyle(color: Colors.red, fontSize: 25, fontWeight: FontWeight.bold),),
            Text('Your heart rate is too low for your age. Here are some tips to increase your heartrate:', textAlign: TextAlign.center,),
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
