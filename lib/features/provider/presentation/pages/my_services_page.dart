import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import 'package:khadamaty_app/core/utils/app_spacing.dart';
import 'package:khadamaty_app/core/utils/ui_helpers.dart';
import 'package:khadamaty_app/core/widgets/loading_indicator.dart';
import '../cubits/my_services_cubit/my_services_cubit.dart';
import '../cubits/my_services_cubit/my_services_state.dart';
import '../widgets/my_service_card.dart';
import '../widgets/empty_services_state.dart';

/// My Services page for managing user's services
class MyServicesPage extends StatelessWidget {
  const MyServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyServicesCubit()..loadMyServices(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).myServicesTitle),
        ),
        body: BlocBuilder<MyServicesCubit, MyServicesState>(
          builder: (context, state) {
            if (state.isLoading && state.myServices.isEmpty) {
              return Center(
                child: LoadingIndicator(message: S.of(context).loadingServices),
              );
            }

            if (state.myServices.isEmpty) {
              return const EmptyServicesState();
            }

            return RefreshIndicator(
              onRefresh: () =>
                  context.read<MyServicesCubit>().refreshServices(context),
              child: ListView.builder(
                padding: EdgeInsets.all(AppSpacing.page(context)),
                itemCount: state.myServices.length,
                itemBuilder: (context, index) {
                  final service = state.myServices[index];
                  return MyServiceCard(
                    service: service,
                    onEdit: () {
                      // TODO: Navigate to edit service
                      UIHelpers.showInfoSnackbar(
                        context: context,
                        message: 'Edit: ${service.title}',
                      );
                    },
                    onDelete: () => UIHelpers.deleteWithConfirmation(
                      context: context,
                      title: S.of(context).deleteService,
                      message: S.of(context).deleteServiceConfirmation,
                      itemName: service.title,
                      confirmText: S.of(context).delete,
                      cancelText: S.of(context).cancel,
                      onDelete: () => context
                          .read<MyServicesCubit>()
                          .deleteService(service.id),
                    ),
                  );
                },
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // TODO: Navigate to Add Service form
            UIHelpers.showInfoSnackbar(
              context: context,
              message: S.of(context).addService,
            );
          },
          icon: const Icon(Icons.add),
          label: Text(S.of(context).addService),
        ),
      ),
    );
  }
}
