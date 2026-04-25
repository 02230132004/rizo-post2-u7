import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class AccelerometerWidget extends StatefulWidget {
  const AccelerometerWidget({super.key});

  @override
  State<AccelerometerWidget> createState() => _AccelerometerWidgetState();
}

class _AccelerometerWidgetState extends State<AccelerometerWidget> {
  StreamSubscription<UserAccelerometerEvent>? _subscription;
  double _x = 0, _y = 0, _z = 0;
  bool _isShaking = false;
  final double _threshold = 15.0;

  @override
  void initState() {
    super.initState();
    // Corregido: sensor_plus 4.0.2 usa userAccelerometerEvents
    _subscription = userAccelerometerEvents.listen(
      (UserAccelerometerEvent event) {
        if (!mounted) return;
        setState(() {
          _x = event.x;
          _y = event.y;
          _z = event.z;

          if (_x.abs() > _threshold || _y.abs() > _threshold || _z.abs() > _threshold) {
            _isShaking = true;
          } else {
            _isShaking = false;
          }
        });
      },
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _isShaking ? Colors.red : Colors.white,
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Acelerómetro',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('X: ${_x.toStringAsFixed(2)} m/s²'),
            Text('Y: ${_y.toStringAsFixed(2)} m/s²'),
            Text('Z: ${_z.toStringAsFixed(2)} m/s²'),
            const SizedBox(height: 10),
            if (_isShaking)
              const Text(
                '¡AGITACIÓN DETECTADA!',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}
