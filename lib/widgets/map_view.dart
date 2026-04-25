import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../services/location_service.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final LocationService _locationService = LocationService();
  GoogleMapController? _mapController;
  StreamSubscription<Position>? _positionSubscription;
  
  LatLng? _initialPosition;
  final Set<Marker> _markers = {};
  final Set<Circle> _circles = {};

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    try {
      bool hasPermission = await _locationService.checkAndRequestPermissions();
      if (!hasPermission) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Permisos de ubicación denegados')),
          );
        }
        return;
      }

      Position position = await _locationService.getCurrentLocation();
      if (!mounted) return;
      
      setState(() {
        _initialPosition = LatLng(position.latitude, position.longitude);
        _updateMarkers(position);
        _setGeofenceCircle(position);
      });

      _positionSubscription = _locationService.getLocationStream().listen(
        (Position position) {
          if (!mounted) return;
          setState(() {
            _updateMarkers(position);
          });
        },
        onError: (error) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error de ubicación: $error')),
            );
          }
        },
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error inicializando mapa: $e')),
        );
      }
    }
  }

  void _updateMarkers(Position position) {
    _markers.clear();
    _markers.add(
      Marker(
        markerId: const MarkerId('user_location'),
        position: LatLng(position.latitude, position.longitude),
        infoWindow: const InfoWindow(title: 'Mi Ubicación'),
      ),
    );
  }

  void _setGeofenceCircle(Position position) {
    _circles.add(
      Circle(
        circleId: const CircleId('geofence_1'),
        center: LatLng(position.latitude, position.longitude),
        radius: 200,
        fillColor: Colors.blue.withOpacity(0.3),
        strokeColor: Colors.blue,
        strokeWidth: 2,
      ),
    );
  }

  @override
  void dispose() {
    _positionSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_initialPosition == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: _initialPosition!,
        zoom: 16,
      ),
      onMapCreated: (controller) => _mapController = controller,
      markers: _markers,
      circles: _circles,
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: true,
    );
  }
}
