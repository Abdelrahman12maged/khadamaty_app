import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

// Auth imports
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/repositories/user_repository.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/data/repositories/user_repository_impl.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/datasources/user_remote_data_source.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/domain/usecases/verify_email_usecase.dart';
import '../../features/auth/domain/usecases/reset_password_usecase.dart';
import '../../features/home/presentation/cubits/home_cubit/home_cubit.dart';
import '../../features/home/presentation/cubits/navigation_cubit.dart';
import '../../features/home/presentation/cubits/service_details_cubit/service_details_cubit.dart';

// Provider imports
import '../../features/provider/domain/repositories/service_repository.dart';
import '../../features/provider/data/repositories/firebase_service_repository.dart';
import '../../features/provider/domain/usecases/create_service_usecase.dart';
import '../../features/provider/domain/usecases/get_provider_services_usecase.dart';
import '../../features/provider/domain/usecases/update_service_usecase.dart';
import '../../features/provider/domain/usecases/delete_service_usecase.dart';
import '../../features/provider/domain/usecases/toggle_service_status_usecase.dart';
import '../../features/provider/domain/usecases/upload_image_usecase.dart';
import '../../features/provider/data/repositories/firebase_image_repository.dart';
import '../../features/home/domain/usecases/get_active_services_usecase.dart';
import '../../features/home/domain/usecases/get_service_by_id_usecase.dart';
// Booking imports
import '../../features/bookings/data/datasources/booking_remote_data_source.dart';
import '../../features/bookings/data/repositories/firebase_booking_repository.dart';
import '../../features/bookings/domain/repositories/booking_repository.dart';
import '../../features/bookings/domain/usecases/create_booking_usecase.dart';
import '../../features/bookings/domain/usecases/get_user_bookings_usecase.dart';
import '../../features/bookings/domain/usecases/update_booking_status_usecase.dart';
import '../../features/bookings/presentation/cubits/bookings_cubit/bookings_cubit.dart';
import '../../features/bookings/presentation/cubits/create_booking_cubit/create_booking_cubit.dart';

/// Service Locator instance
final sl = GetIt.instance;

/// Initialize all dependencies
Future<void> initDependencies() async {
  // ============ CORE ============

  // Firebase instances
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);

  // ============ DATA SOURCES ============

  // Auth Remote Data Source
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(firebaseAuth: sl()),
  );

  // User Remote Data Source
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(firestore: sl()),
  );

  // Booking Remote Data Source
  sl.registerLazySingleton<BookingRemoteDataSource>(
    () => BookingRemoteDataSourceImpl(firestore: sl()),
  );

  // ============ REPOSITORIES ============

  // Auth Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  // User Repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(remoteDataSource: sl()),
  );

  // Service Repository
  sl.registerLazySingleton<ServiceRepository>(
    () => FirebaseServiceRepository(firestore: sl(), auth: sl()),
  );

  // Image Repository
  sl.registerLazySingleton<ImageRepository>(
    () => FirebaseImageRepository(storage: sl()),
  );

  // Booking Repository
  sl.registerLazySingleton<BookingRepository>(
    () => FirebaseBookingRepositoryImp(remoteDataSource: sl()),
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
  sl.registerLazySingleton(() => UploadImageUseCase(sl()));

  // ============ HOME USECASES ============
  sl.registerLazySingleton(() => GetActiveServicesUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetServiceByIdUseCase(repository: sl()));

  // ============ BOOKING USECASES ============
  sl.registerLazySingleton(() => CreateBookingUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetUserBookingsUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateBookingStatusUseCase(repository: sl()));

  // ============ CUBITS ============
  sl.registerFactory(() => NavigationCubit());
  sl.registerFactory(() => HomeCubit(getActiveServicesUseCase: sl()));
  sl.registerFactory(() => ServiceDetailsCubit(getServiceByIdUseCase: sl()));
  sl.registerFactory(() => BookingsCubit(
        getUserBookingsUseCase: sl(),
        authRepository: sl(),
      ));
  sl.registerFactory(() => CreateBookingCubit(
        createBookingUseCase: sl(),
        authRepository: sl(),
      ));
}

/// Reset all dependencies for testing
Future<void> resetDependencies() async {
  await sl.reset();
}
