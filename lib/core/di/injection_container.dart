import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:khadamaty_app/core/service/Api.dart';
import 'package:khadamaty_app/features/Payment/data/datasources/paypal_service.dart';
import 'package:khadamaty_app/features/provider/domain/repositories/image_repositry.dart';

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

// Explore imports
import '../../features/explore/presentation/cubits/explore_cubit/explore_cubit.dart';

// Provider imports
import '../../features/provider/domain/repositories/service_repository.dart';
import '../../features/provider/data/repositories/firebase_service_repository.dart';
import '../../features/provider/data/datasources/service_remote_data_source.dart';
import '../../features/provider/data/datasources/image_remote_data_source.dart';
import '../../features/provider/domain/usecases/create_service_usecase.dart';
import '../../features/provider/domain/usecases/get_provider_services_usecase.dart';
import '../../features/provider/domain/usecases/update_service_usecase.dart';
import '../../features/provider/domain/usecases/delete_service_usecase.dart';
import '../../features/provider/domain/usecases/toggle_service_status_usecase.dart';
import '../../features/provider/domain/usecases/upload_image_usecase.dart';
import '../../features/provider/data/repositories/Image_repositoryImp.dart';
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

// Payment imports
import '../../features/Payment/domain/repositories/payment_repository.dart';
import '../../features/Payment/data/repositories/payment_repository_impl.dart';
import '../../features/Payment/data/datasources/stripe_service.dart';
import '../../features/Payment/presentation/cubit/payment_cubit.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

// Chat imports
import 'package:hive/hive.dart';
import '../../features/chat_system/data/local_data_source/chat_local_datasourc.dart';
import '../../features/chat_system/data/models/local_models/chat_local_model.dart';
import '../../features/chat_system/data/models/local_models/chat_message_local_model.dart';
import '../../features/chat_system/data/remote_data_source/chat_remote_datasource.dart';
import '../../features/chat_system/data/repository/chat_repository_impl.dart';
import '../../features/chat_system/domain/repository/chat_repository.dart';
import '../../features/chat_system/domain/usecases/get_or_create_chat_usecase.dart';
import '../../features/chat_system/domain/usecases/get_user_chats_usecase.dart';
import '../../features/chat_system/domain/usecases/get_messages_usecase.dart';
import '../../features/chat_system/domain/usecases/send_message_usecase.dart';
import '../../features/chat_system/domain/usecases/mark_as_read_usecase.dart';
import '../../features/chat_system/presentation/cubits/chat_list_cubit/chat_list_cubit.dart';
import '../../features/chat_system/presentation/cubits/chat_cubit/chat_cubit.dart';
import '../../features/chat_system/presentation/cubits/open_chat_cubit/open_chat_cubit.dart';

/// Service Locator instance
final sl = GetIt.instance;

/// Initialize all dependencies
Future<void> initDependencies() async {
  // ============ CORE ============

  // Firebase instances
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);

  //supabase instance
  sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<Apiservice>(() => Apiservice(dio: sl()));
  // ============ DATA SOURCES ============

  // Auth Remote Data Source
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(firebaseAuth: sl()),
  );

  // User Remote Data Source
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(firestore: sl()),
  );

  // Service Remote Data Source
  sl.registerLazySingleton<ServiceRemoteDataSource>(
    () => ServiceRemoteDataSourceImpl(firestore: sl()),
  );

  // Image Remote Data Source
  sl.registerLazySingleton<ImageRemoteDataSource>(
    () => ImageRemoteDataSourceImpl(supabaseClient: sl()),
  );

  // Booking Remote Data Source
  sl.registerLazySingleton<BookingRemoteDataSource>(
    () => BookingRemoteDataSourceImpl(firestore: sl()),
  );

  // Stripe Service
  sl.registerLazySingleton<StripeServiceImp>(
      () => StripeServiceImp(apiservice: sl()));
  sl.registerLazySingleton<PaypalService>(() => PaypalService());
  sl.registerLazySingleton<PaymentServiceFactory>(() => PaymentServiceFactory(
      stripeService: sl<StripeServiceImp>(),
      paypalService: sl<PaypalService>()));

  // ─── Chat System (Hive local cache) ───
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(ChatLocalModelAdapter());
  }
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(ChatMessageLocalModelAdapter());
  }
  final chatsBox = await Hive.openBox<ChatLocalModel>("chats_box");
  final messagesBox = await Hive.openBox<ChatMessageLocalModel>("messages_box");

  sl.registerLazySingleton<ChatLocalDatasource>(
    () => ChatLocalDatasourceImpl(chatsBox: chatsBox, messagesBox: messagesBox),
  );

  // Chat Remote Data Source
  sl.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImpl(firestore: sl()),
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
    () => FirebaseServiceRepository(remoteDataSource: sl()),
  );

  // Image Repository
  sl.registerLazySingleton<ImageRepository>(
    () => ImageRepositoryImpl(remoteDataSource: sl()),
  );

  // Booking Repository
  sl.registerLazySingleton<BookingRepository>(
    () => FirebaseBookingRepositoryImp(remoteDataSource: sl()),
  );

  // Payment Repository
  sl.registerLazySingleton<PaymentRepository>(
    () => PaymentRepositoryImpl(paymentFactory: sl()),
  );

  // Chat Repository
  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
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
  sl.registerLazySingleton(() => UploadImageUseCase(sl()));

  // ============ HOME USECASES ============
  sl.registerLazySingleton(() => GetActiveServicesUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetServiceByIdUseCase(repository: sl()));

  // ============ BOOKING USECASES ============
  sl.registerLazySingleton(() => CreateBookingUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetUserBookingsUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateBookingStatusUseCase(repository: sl()));

  // ============ CHAT USECASES ============
  sl.registerLazySingleton(() => GetOrCreateChatUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetUserChatsUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetMessagesUseCase(repository: sl()));
  sl.registerLazySingleton(() => SendMessageUseCase(repository: sl()));
  sl.registerLazySingleton(() => MarkAsReadUseCase(repository: sl()));

  // ============ CUBITS ============
  sl.registerFactory(() => NavigationCubit());
  sl.registerFactory(() => HomeCubit(getActiveServicesUseCase: sl()));
  sl.registerFactory(() => ExploreCubit(getActiveServicesUseCase: sl()));
  sl.registerFactory(() => ServiceDetailsCubit(getServiceByIdUseCase: sl()));
  sl.registerFactory(() => BookingsCubit(
        getUserBookingsUseCase: sl(),
        authRepository: sl(),
      ));
  sl.registerFactory(() => CreateBookingCubit(
        createBookingUseCase: sl(),
        authRepository: sl(),
      ));
  sl.registerFactory(() => PaymentCubit(paymentRepository: sl()));
  sl.registerFactory(() => ChatListCubit(
        getUserChatsUseCase: sl(),
        authRepository: sl(),
      ));
  sl.registerFactory(() => ChatCubit(
        getMessagesUseCase: sl(),
        sendMessageUseCase: sl(),
        markAsReadUseCase: sl(),
      ));
  sl.registerFactory(() => OpenChatCubit(
        getOrCreateChatUseCase: sl(),
      ));
}

/// Reset all dependencies for testing
Future<void> resetDependencies() async {
  await sl.reset();
}
