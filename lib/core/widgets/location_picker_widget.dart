import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';
import 'package:khadamaty_app/core/utils/location_service.dart';
import 'package:khadamaty_app/core/utils/ui_helpers.dart';
import 'package:khadamaty_app/generated/l10n.dart';

/// Full-screen location picker for selecting service locations
class LocationPickerWidget extends StatefulWidget {
  /// Initial location to center the map on
  final LatLng? initialLocation;

  /// Callback when location is confirmed
  final void Function(LatLng location, String? address) onLocationSelected;

  const LocationPickerWidget({
    super.key,
    this.initialLocation,
    required this.onLocationSelected,
  });

  @override
  State<LocationPickerWidget> createState() => _LocationPickerWidgetState();

  /// Show the location picker as a full-screen modal
  static Future<void> show({
    required BuildContext context,
    LatLng? initialLocation,
    required void Function(LatLng location, String? address) onLocationSelected,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => LocationPickerWidget(
          initialLocation: initialLocation,
          onLocationSelected: onLocationSelected,
        ),
      ),
    );
  }
}

class _LocationPickerWidgetState extends State<LocationPickerWidget> {
  late final MapController _mapController;
  late LatLng _selectedLocation;
  String? _address;
  bool _isLoadingAddress = false;
  bool _isLoadingLocation = false;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _selectedLocation = widget.initialLocation ??
        const LatLng(
          LocationService.defaultLatitude,
          LocationService.defaultLongitude,
        );
    _fetchAddress();
  }

  Future<void> _fetchAddress() async {
    setState(() => _isLoadingAddress = true);
    try {
      final address = await LocationService.getAddressFromCoordinates(
        _selectedLocation.latitude,
        _selectedLocation.longitude,
      );
      if (mounted) {
        setState(() {
          _address = address;
          _isLoadingAddress = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() => _isLoadingAddress = false);
      }
    }
  }

  Future<void> _getCurrentLocation() async {
    setState(() => _isLoadingLocation = true);
    try {
      final position = await LocationService.getCurrentLocation();
      if (position != null && mounted) {
        final newLocation = LatLng(position.latitude, position.longitude);
        setState(() {
          _selectedLocation = newLocation;
          _isLoadingLocation = false;
        });
        _mapController.move(newLocation, 16);
        _fetchAddress();
      } else {
        if (mounted) {
          setState(() => _isLoadingLocation = false);
          UIHelpers.showErrorSnackbar(
            context: context,
            message: S.of(context).errorPermissionDenied,
          );
        }
      }
    } catch (_) {
      if (mounted) {
        setState(() => _isLoadingLocation = false);
      }
    }
  }

  void _onMapTap(LatLng position) {
    setState(() => _selectedLocation = position);
    _fetchAddress();
  }

  void _confirmLocation() {
    widget.onLocationSelected(_selectedLocation, _address);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(s.mapPickLocation),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          TextButton(
            onPressed: _confirmLocation,
            child: Text(
              s.confirm,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Map
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _selectedLocation,
              initialZoom: 15,
              onTap: (_, point) => _onMapTap(point),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.khadamaty.app',
              ),
              // Selected location marker
              MarkerLayer(
                markers: [
                  Marker(
                    point: _selectedLocation,
                    width: 50,
                    height: 50,
                    child: Icon(
                      Icons.location_on,
                      color: AppColors.errorRed,
                      size: 50,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Bottom card with address
          Positioned(
            left: AppSpacing.md(context),
            right: AppSpacing.md(context),
            bottom: AppSpacing.lg(context),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.md(context)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Address
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: theme.colorScheme.primary,
                        ),
                        SizedBox(width: AppSpacing.sm(context)),
                        Expanded(
                          child: _isLoadingAddress
                              ? Text(
                                  s.mapLoadingLocation,
                                  style: theme.textTheme.bodySmall,
                                )
                              : Text(
                                  _address ?? '',
                                  style: theme.textTheme.bodyMedium,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSpacing.md(context)),
                    // Use current location button
                    OutlinedButton.icon(
                      onPressed:
                          _isLoadingLocation ? null : _getCurrentLocation,
                      icon: _isLoadingLocation
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.my_location),
                      label: Text(s.mapUseCurrentLocation),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
