import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamaty_app/features/home/domain/usecases/get_service_by_id_usecase.dart';
import 'service_details_state.dart';

class ServiceDetailsCubit extends Cubit<ServiceDetailsState> {
  final GetServiceByIdUseCase _getServiceByIdUseCase;

  ServiceDetailsCubit({
    required GetServiceByIdUseCase getServiceByIdUseCase,
  })  : _getServiceByIdUseCase = getServiceByIdUseCase,
        super(const ServiceDetailsState());

  Future<void> loadService(String id) async {
    emit(state.copyWith(status: ServiceDetailsStatus.loading));

    final result = await _getServiceByIdUseCase(id);

    result.fold(
      (failure) => emit(state.copyWith(
        status: ServiceDetailsStatus.error,
        errorMessage: failure.message,
      )),
      (service) => emit(state.copyWith(
        status: ServiceDetailsStatus.success,
        service: service,
      )),
    );
  }
}
