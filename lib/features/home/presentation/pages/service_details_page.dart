import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamaty_app/core/di/injection_container.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';
import 'package:khadamaty_app/core/utils/responsive_value.dart';
import 'package:khadamaty_app/core/widgets/loading_indicator.dart';
import 'package:khadamaty_app/core/widgets/error_display.dart';
import '../cubits/service_details_cubit/service_details_cubit.dart';
import '../cubits/service_details_cubit/service_details_state.dart';
import '../widgets/service_details_widgets/service_details_header.dart';
import '../widgets/service_details_widgets/service_info_section.dart';
import '../widgets/service_details_widgets/service_description_section.dart';
import '../widgets/service_details_widgets/provider_info_card.dart';
import '../widgets/service_details_widgets/service_location_section.dart';
import '../widgets/service_details_widgets/booking_bottom_bar.dart';
import '../../../provider/domain/entities/service_entity.dart';

class ServiceDetailsPage extends StatelessWidget {
  final String serviceId;

  const ServiceDetailsPage({super.key, required this.serviceId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ServiceDetailsCubit>()..loadService(serviceId),
      child: Scaffold(
        body: BlocBuilder<ServiceDetailsCubit, ServiceDetailsState>(
          builder: (context, state) {
            if (state.status == ServiceDetailsStatus.loading) {
              return const LoadingIndicator();
            }

            if (state.status == ServiceDetailsStatus.error) {
              return ErrorDisplay(
                message: state.errorMessage ?? 'Error loading service',
                onRetry: () =>
                    context.read<ServiceDetailsCubit>().loadService(serviceId),
              );
            }

            if (state.status == ServiceDetailsStatus.success &&
                state.service != null) {
              return _ServiceDetailsContent(service: state.service!);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _ServiceDetailsContent extends StatelessWidget {
  final ServiceEntity service;

  const _ServiceDetailsContent({required this.service});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.responsive(
      mobile: 20.0,
      tablet: 40.0,
      desktop: 100.0,
    );

    return Stack(
      children: [
        CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            ServiceDetailsHeader(service: service),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: AppSpacing.md(context),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ServiceInfoSection(service: service),
                    const Divider(height: 32),
                    ServiceDescriptionSection(service: service),
                    const Divider(height: 32),
                    ProviderInfoCard(service: service),
                    const Divider(height: 32),
                    ServiceLocationSection(service: service),
                    SizedBox(height: AppSpacing.xl(context) * 3),
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: BookingBottomBar(service: service),
        ),
      ],
    );
  }
}
