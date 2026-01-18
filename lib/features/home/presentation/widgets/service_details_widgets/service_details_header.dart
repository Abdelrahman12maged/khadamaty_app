import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';
import 'package:khadamaty_app/core/utils/responsive_value.dart';
import 'package:khadamaty_app/features/provider/domain/entities/service_entity.dart';

class ServiceDetailsHeader extends StatelessWidget {
  final ServiceEntity service;

  const ServiceDetailsHeader({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight:
          context.responsive(mobile: 300.0, tablet: 400.0, desktop: 450.0),
      pinned: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.zoomBackground],
        background: Stack(
          fit: StackFit.expand,
          children: [
            if (service.imageUrl != null)
              Image.network(
                service.imageUrl!,
                fit: BoxFit.cover,
              )
            else
              Container(
                color: AppColors.primaryBlue.withOpacity(0.1),
                child: Icon(
                  Icons.image_outlined,
                  size: 80,
                  color: AppColors.primaryBlue.withOpacity(0.5),
                ),
              ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black54,
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black54,
                  ],
                  stops: [0.0, 0.3, 0.7, 1.0],
                ),
              ),
            ),
          ],
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => context.pop(),
          ),
        ),
      ),
    );
  }
}
