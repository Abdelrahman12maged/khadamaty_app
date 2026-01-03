import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../../features/provider/domain/repositories/service_repository.dart';
import '../../features/provider/data/repositories/firebase_service_repository.dart';
import '../../features/provider/domain/usecases/create_service_usecase.dart';
import '../../features/provider/domain/usecases/get_provider_services_usecase.dart';
import '../../features/provider/domain/usecases/update_service_usecase.dart';
import '../../features/provider/domain/usecases/delete_service_usecase.dart';
import '../../features/provider/domain/usecases/toggle_service_status_usecase.dart';

/// Service Locator instance
final sl = GetIt.instance;

/// Initialize all dependencies
Future<void> initDependencies() async {
  // ============ CORE ============

  // Firebase instances
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  // ============ REPOSITORIES ============
  // To switch to Supabase: replace implementations here

  // Service Repository
  sl.registerLazySingleton<ServiceRepository>(
    () => FirebaseServiceRepository(
      firestore: sl(),
      auth: sl(),
    ),
  );

  // ============ USECASES ============

  // Service UseCases
  sl.registerLazySingleton(() => CreateServiceUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetProviderServicesUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateServiceUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteServiceUseCase(repository: sl()));
  sl.registerLazySingleton(() => ToggleServiceStatusUseCase(repository: sl()));

  // ============ CUBITS ============
  // Cubits are registered as Factory (new instance each time)
  // They will be created in the UI with BlocProvider
}

/// Reset all dependencies (useful for testing)
Future<void> resetDependencies() async {
  await sl.reset();
}
