import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

// Auth imports
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/repositories/user_repository.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/data/repositories/user_repository_impl.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/domain/usecases/verify_email_usecase.dart';
import '../../features/auth/domain/usecases/reset_password_usecase.dart';

// Provider imports
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

  // Auth Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(firebaseAuth: sl()),
  );

  // User Repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(firestore: sl()),
  );

  // Service Repository
  sl.registerLazySingleton<ServiceRepository>(
    () => FirebaseServiceRepository(
      firestore: sl(),
      auth: sl(),
    ),
  );

  // ============ AUTH USECASES ============

  sl.registerLazySingleton(() => RegisterUseCase(
        authRepository: sl(),
        userRepository: sl(),
      ));

  sl.registerLazySingleton(() => LoginUseCase(
        authRepository: sl(),
        userRepository: sl(),
      ));

  sl.registerLazySingleton(() => LogoutUseCase(authRepository: sl()));

  sl.registerLazySingleton(() => VerifyEmailUseCase(
        authRepository: sl(),
        userRepository: sl(),
      ));

  sl.registerLazySingleton(() => ResetPasswordUseCase(authRepository: sl()));

  // ============ SERVICE USECASES ============

  sl.registerLazySingleton(() => CreateServiceUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetProviderServicesUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateServiceUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteServiceUseCase(repository: sl()));
  sl.registerLazySingleton(() => ToggleServiceStatusUseCase(repository: sl()));

 
}

/// Reset all dependencies for testing
Future<void> resetDependencies() async {
  await sl.reset();
}
