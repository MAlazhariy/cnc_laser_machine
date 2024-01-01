import 'dart:async';

import 'package:elaser/data/repository/splash_repo.dart';
import 'package:elaser/provider/splash_provider.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:elaser/data/data_source/remote/dio/dio_client.dart';
import 'package:elaser/data/data_source/remote/dio/logging_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This di container is for providers, repositories and other services
/// BUT screens are handled in ROUTES MANAGER.

class Di {
  static final sl = GetIt.instance;

  static Future<void> init() async {
    // Core
    sl.registerLazySingleton(() => DioClient(sl(), sharedPreferences: sl(), loggingInterceptor: sl()));

    // Repositories
    sl.registerLazySingleton(() => SplashRepo(sharedPreferences: sl(), dioClient: sl()));

    // Providers
    sl.registerFactory(() => SplashProvider(splashRepo: sl()));

    // External
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);
    sl.registerLazySingleton(() => LoggingInterceptor());
    sl.registerLazySingleton(() => Dio());
  }
}
