import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';
import 'package:khadamaty_app/core/widgets/location_picker_widget.dart';
import 'package:khadamaty_app/generated/l10n.dart';

/// Location picker section for Add Service form
class LocationPickerSection extends StatelessWidget {
  final double? latitude;
  final double? longitude;
  final String? address;
  final void Function(double lat, double lng, String? address)
      onLocationSelected;
  final bool showError;

  const LocationPickerSection({
    super.key,
    this.latitude,
    this.longitude,
    this.address,
    required this.onLocationSelected,
    this.showError = false,
  });

  bool get hasLocation => latitude != null && longitude != null;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Location card
        InkWell(
          onTap: () =>  _openLocationPicker(context),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: EdgeInsets.all(AppSpacing.md(context)),
            decoration: BoxDecoration(
              border: Border.all(
                color: showError && !hasLocation
                    ? AppColors.errorRed
                    : AppColors.divider(context),
                width: showError && !hasLocation ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(12),
              color: AppColors.surface(context),
            ),
            child: Row(
              children: [
                // Icon
                Container(
                  padding: EdgeInsets.all(AppSpacing.sm(context)),
                  decoration: BoxDecoration(
                    color: hasLocation
                        ? AppColors.primaryBlue.withValues(alpha: 0.1)
                        : AppColors.divider(context),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    hasLocation
                        ? Icons.location_on
                        : Icons.location_on_outlined,
                    color: hasLocation
                        ? AppColors.primaryBlue
                        : AppColors.textSecondary(context),
                  ),
                ),

                SizedBox(width: AppSpacing.md(context)),

                // Address or placeholder
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hasLocation
                            ? (address ??
                                '${latitude!.toStringAsFixed(4)}, ${longitude!.toStringAsFixed(4)}')
                            : s.tapToSelectLocation,
                        style: hasLocation
                            ? theme.textTheme.bodyMedium
                            : theme.textTheme.bodyMedium?.copyWith(
                                color: AppColors.textSecondary(context),
                              ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (hasLocation) ...[
                        SizedBox(height: AppSpacing.xs(context)),
                        Text(
                          s.mapPickLocation,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: AppColors.primaryBlue,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Arrow icon
                Icon(
                  Icons.chevron_right,
                  color: AppColors.textSecondary(context),
                ),
              ],
            ),
          ),
        ),

        // Error message
        if (showError && !hasLocation) ...[
          SizedBox(height: AppSpacing.xs(context)),
          Text(
            s.pleaseSelectLocation,
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.errorRed,
            ),
          ),
        ],
      ],
    );
  }

  void _openLocationPicker(BuildContext context) {
    LocationPickerWidget.show(
      context: context,
      initialLocation: hasLocation ? LatLng(latitude!, longitude!) : null,
      onLocationSelected: (location, addr) {
        onLocationSelected(location.latitude, location.longitude, addr);
      },
    );
  }
}
