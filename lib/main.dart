import 'package:flutter/material.dart';
import 'widgets/map_view.dart';
import 'widgets/accelerometer_widget.dart';

void main() {
  runApp(const GeoSenseApp());
}

class GeoSenseApp extends StatelessWidget {
  const GeoSenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GeoSense',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GeoSense'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: const Column(
        children: [
          Expanded(
            flex: 3,
            child: MapView(),
          ),
          Expanded(
            flex: 1,
            child: AccelerometerWidget(),
          ),
        ],
      ),
    );
  }
}
