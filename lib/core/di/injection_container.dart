import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../../features/provider/domain/repositories/i_service_repository.dart';
import '../../features/provider/data/repositories/firebase_service_repository.dart';

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
  sl.registerLazySingleton<IServiceRepository>(
    () => FirebaseServiceRepository(
      firestore: sl(),
      auth: sl(),
    ),
  );

  // Booking Repository (TODO: uncomment when created)
  // sl.registerLazySingleton<IBookingRepository>(
  //   () => FirebaseBookingRepository(firestore: sl()),
  // );

  // ============ USECASES ============
  // Will be added as we create them

  // ============ CUBITS ============
  // Will register cubits that need injected dependencies
}

/// Reset all dependencies (useful for testing)
Future<void> resetDependencies() async {
  await sl.reset();
}
