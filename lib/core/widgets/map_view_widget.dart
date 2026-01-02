import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';
import 'package:khadamaty_app/core/utils/location_service.dart';

/// A reusable map view widget using OpenStreetMap
class MapViewWidget extends StatelessWidget {
  /// Center point of the map
  final LatLng center;

  /// Initial zoom level (1-18, default 15)
  final double zoom;

  /// List of markers to display on the map
  final List<Marker> markers;

  /// Whether to show user's current location
  final bool showCurrentLocation;

  /// Callback when map is tapped
  final void Function(LatLng)? onTap;

  /// Map controller for external control
  final MapController? controller;

  /// Height of the map widget
  final double? height;

  const MapViewWidget({
    super.key,
    LatLng? center,
    this.zoom = 15.0,
    this.markers = const [],
    this.showCurrentLocation = false,
    this.onTap,
    this.controller,
    this.height,
  }) : center = center ??
            const LatLng(
              LocationService.defaultLatitude,
              LocationService.defaultLongitude,
            );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSpacing.sm(context)),
        child: FlutterMap(
          mapController: controller,
          options: MapOptions(
            initialCenter: center,
            initialZoom: zoom,
            minZoom: 5,
            maxZoom: 18,
            onTap: onTap != null ? (tapPosition, point) => onTap!(point) : null,
          ),
          children: [
            // OpenStreetMap tile layer
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.khadamaty.app',
              maxZoom: 19,
            ),
            // Markers layer
            if (markers.isNotEmpty) MarkerLayer(markers: markers),
          ],
        ),
      ),
    );
  }

  /// Create a standard marker for service locations
  static Marker createServiceMarker({
    required LatLng position,
    required VoidCallback? onTap,
    Color color = AppColors.errorRed,
  }) {
    return Marker(
      point: position,
      width: 40,
      height: 40,
      child: GestureDetector(
        onTap: onTap,
        child: Icon(
          Icons.location_on,
          color: color,
          size: 40,
        ),
      ),
    );
  }

  /// Create a marker for user's current location
  static Marker createCurrentLocationMarker(LatLng position) {
    return Marker(
      point: position,
      width: 24,
      height: 24,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryBlue,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.surfaceLight, width: 3),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryBlue.withOpacity(0.3),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
      ),
    );
  }
}
