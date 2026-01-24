import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:khadamaty_app/core/utils/router/app_router.dart';
import 'package:khadamaty_app/core/di/injection_container.dart';
import 'package:khadamaty_app/features/bookings/domain/repositories/booking_repository.dart';
import 'package:khadamaty_app/features/bookings/domain/usecases/create_booking_usecase.dart';
import 'package:khadamaty_app/features/provider/data/repositories/firebase_service_repository.dart';
import 'package:khadamaty_app/generated/l10n.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize dependency injection
  await initDependencies();



// final repository = FirebaseServiceRepository();

  
//     final result = await repository.getActiveServices();

//     result.fold(
//       (failure) => print('❌ فشل الاتصال: ${failure.message}'),
//       (services) {
//         print('✅ نجاح! تم جلب ${services.length} خدمة من السيرفر.');
//         for (var s in services) {
//           print('--- الخدمة: ${s} | التقييم: ${s.rating}');
//         }
//       },
//     );
  










  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const KhadamatyApp(),
    ),
  );
}

class KhadamatyApp extends StatelessWidget {
  const KhadamatyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(
        registerUseCase: sl(),
        loginUseCase: sl(),
        logoutUseCase: sl(),
        verifyEmailUseCase: sl(),
        resetPasswordUseCase: sl(),
      ),
      child: MaterialApp.router(
        // DevicePreview package to test app in mobile,tablet and dektop
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,

        title: 'Khadamaty',
        theme: AppTheme.lightTheme(context),
        darkTheme: AppTheme.darkTheme(context),
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
      ),
    );
  }
}
