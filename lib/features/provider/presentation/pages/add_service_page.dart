import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:khadamaty_app/core/di/injection_container.dart';
import 'package:khadamaty_app/core/theme/app_colors.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';
import 'package:khadamaty_app/core/utils/ui_helpers.dart';
import 'package:khadamaty_app/core/widgets/responsive_layout.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import '../cubits/add_service_cubit/add_service_cubit.dart';
import '../cubits/add_service_cubit/add_service_state.dart';
import '../cubits/my_services_cubit/my_services_cubit.dart';
import '../widgets/add_service_widgets/service_title_field.dart';
import '../widgets/add_service_widgets/service_description_field.dart';
import '../widgets/add_service_widgets/category_input_field.dart';
import '../widgets/add_service_widgets/price_input_section.dart';
import '../widgets/add_service_widgets/location_picker_section.dart';
import '../widgets/add_service_widgets/image_picker_section.dart';
import '../widgets/add_service_widgets/form_section_card.dart';
import '../widgets/add_service_widgets/service_type_selector.dart';
import '../widgets/add_service_widgets/duration_input_field.dart';
import '../widgets/add_service_widgets/availability_picker.dart';

/// Add Service page for creating new services
class AddServicePage extends StatelessWidget {
  /// Optional cubit for returning the created service
  final MyServicesCubit? myServicesCubit;

  const AddServicePage({
    super.key,
    this.myServicesCubit,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => AddServiceCubit(
        createServiceUseCase: sl(),
        uploadImageUseCase: sl(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(s.addServiceTitle),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => context.pop(),
          ),
        ),
        body: BlocConsumer<AddServiceCubit, AddServiceState>(
          listener: (context, state) {
            if (state.status == AddServiceStatus.success) {
              UIHelpers.showSuccessSnackbar(
                context: context,
                message: s.serviceAdded,
              );
              context.pop(true);
            }

            if (state.status == AddServiceStatus.error && state.error != null) {
              UIHelpers.showErrorSnackbar(
                context: context,
                message: state.error!,
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<AddServiceCubit>();
            final showErrors = state.hasAttemptedSubmit;

            return ResponsiveLayout(
              useCard: false,
              mobileMaxWidth: double.infinity,
              tabletMaxWidth: 600.0,
              desktopMaxWidth: 700.0,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(AppSpacing.page(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // ===== BASIC INFO SECTION =====
                    FormSectionCard(
                      title: s.serviceInfo,
                      subtitle: s.serviceInfoSubtitle,
                      icon: Icons.info_outline,
                      child: Column(
                        children: [
                          ServiceTitleField(
                            value: state.title,
                            onChanged: cubit.updateTitle,
                            showError: showErrors,
                          ),
                          SizedBox(height: AppSpacing.md(context)),
                          ServiceDescriptionField(
                            value: state.description,
                            onChanged: cubit.updateDescription,
                            showError: showErrors,
                          ),
                          SizedBox(height: AppSpacing.md(context)),
                          CategoryInputField(
                            value: state.category,
                            onChanged: cubit.updateCategory,
                            showError: showErrors,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: AppSpacing.lg(context)),

                    // ===== SERVICE TYPE SECTION =====
                    FormSectionCard(
                      title: s.serviceTypeSection,
                      subtitle: s.serviceTypeSectionSubtitle,
                      icon: Icons.category_outlined,
                      child: Column(
                        children: [
                          ServiceTypeSelector(
                            value: state.serviceType,
                            onChanged: cubit.updateServiceType,
                          ),
                          // Show duration field only for appointment services
                          if (state.isAppointmentService) ...[
                            SizedBox(height: AppSpacing.md(context)),
                            DurationInputField(
                              value: state.durationMinutes,
                              onChanged: cubit.updateDuration,
                              showError: showErrors,
                            ),
                            SizedBox(height: AppSpacing.md(context)),
                            AvailabilityPicker(
                              value: state.availability,
                              onChanged: cubit.updateAvailability,
                            ),
                          ],
                        ],
                      ),
                    ),

                    SizedBox(height: AppSpacing.lg(context)),

                    // ===== PRICING SECTION =====
                    FormSectionCard(
                      title: s.pricingTitle,
                      subtitle: s.pricingSubtitle,
                      icon: Icons.payments_outlined,
                      child: PriceInputSection(
                        price: state.price,
                        priceUnit: state.priceUnit,
                        onPriceChanged: cubit.updatePrice,
                        onUnitChanged: cubit.updatePriceUnit,
                        showError: showErrors,
                      ),
                    ),

                    SizedBox(height: AppSpacing.lg(context)),

                    // ===== LOCATION SECTION =====
                    FormSectionCard(
                      title: s.serviceLocation,
                      subtitle: s.locationSubtitle,
                      icon: Icons.location_on_outlined,
                      child: LocationPickerSection(
                        latitude: state.latitude,
                        longitude: state.longitude,
                        address: state.address,
                        onLocationSelected: (lat, lng, addr) {
                          cubit.updateLocation(
                            latitude: lat,
                            longitude: lng,
                            address: addr,
                          );
                        },
                        showError: showErrors,
                      ),
                    ),

                    SizedBox(height: AppSpacing.lg(context)),

                    // ===== IMAGE SECTION =====
                    FormSectionCard(
                      title: s.addServiceImage,
                      subtitle: s.imageSubtitle,
                      icon: Icons.photo_camera_outlined,
                      child: ImagePickerSection(
                        imageUrl: state.imageUrl,
                        onTap: cubit.pickAndUploadImage,
                      ),
                    ),

                    SizedBox(height: AppSpacing.xl(context)),

                    // ===== SUBMIT BUTTON =====
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryBlue,
                            AppColors.primaryBlue.withValues(alpha: 0.8),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryBlue.withValues(alpha: 0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: FilledButton.icon(
                        onPressed: state.status == AddServiceStatus.loading
                            ? null
                            : () => _submitForm(context, cubit),
                        icon: state.status == AddServiceStatus.loading
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: theme.colorScheme.onPrimary,
                                ),
                              )
                            : const Icon(Icons.check_circle_outline),
                        label: Text(
                          s.saveService,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(
                            vertical: AppSpacing.md(context),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: AppSpacing.xl(context)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _submitForm(
    BuildContext context,
    AddServiceCubit cubit,
  ) async {
    final service = await cubit.submitForm();
    if (service != null && myServicesCubit != null) {
      // Service will be added when we return and refresh
    }
  }
}
