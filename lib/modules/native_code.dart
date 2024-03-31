import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeCodeScreen extends StatefulWidget {

  @override
  State<NativeCodeScreen> createState() => _NativeCodeScreenState();
}

class _NativeCodeScreenState extends State<NativeCodeScreen> {
  static const platform = const MethodChannel('samples.flutter.dev/battery');
  String batteryLevel = 'Unknown battery level.';

  void getBatteryLevel(){
    platform.invokeMethod<int>('getBatteryLevel').then((value) {
      setState(() {
        batteryLevel = 'Battery level at $value %';
      });
    }).catchError((error){
      setState(() {
        batteryLevel = 'failed to get Battery level at ${error.message} %';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        ElevatedButton(
        onPressed: getBatteryLevel,
        child: const Text('Get Battery Level'),
    ),
    Text(batteryLevel),
    ],
    ),
    ),
    );
  }
}
