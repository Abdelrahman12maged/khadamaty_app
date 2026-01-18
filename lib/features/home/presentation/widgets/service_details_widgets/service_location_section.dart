import 'package:flutter/material.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';
import 'package:khadamaty_app/core/widgets/map_view_widget.dart';
import 'package:khadamaty_app/features/provider/domain/entities/service_entity.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import 'package:latlong2/latlong.dart';

class ServiceLocationSection extends StatelessWidget {
  final ServiceEntity service;

  const ServiceLocationSection({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          s.location,
          style:
              theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: AppSpacing.sm(context)),
        Row(
          children: [
            const Icon(Icons.location_on, color: AppColors.errorRed, size: 20),
            SizedBox(width: AppSpacing.xs(context)),
            Expanded(child: Text(service.location.address)),
          ],
        ),
        SizedBox(height: AppSpacing.md(context)),
        MapViewWidget(
          height: 200,
          center: LatLng(service.location.latitude, service.location.longitude),
          markers: [
            MapViewWidget.createServiceMarker(
              position:
                  LatLng(service.location.latitude, service.location.longitude),
              onTap: null,
            ),
          ],
        ),
      ],
    );
  }
}
