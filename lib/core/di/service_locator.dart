import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:tourist_guide_app/features/auth/data/firebase_auth_repository.dart';
import 'package:tourist_guide_app/features/auth/domain/auth_repository.dart';
import 'package:tourist_guide_app/features/places/data/api_places_repository.dart';
import 'package:tourist_guide_app/features/places/data/places_api.dart';
import 'package:tourist_guide_app/features/places/domain/places_repository.dart';

final getIt = GetIt.instance;

const _apiBaseUrl = 'http://144.91.87.48:8080';
const _apiTimeout = Duration(seconds: 15);

void setupServiceLocator() {
  getIt
    ..registerLazySingleton<AuthRepository>(
      () => FirebaseAuthRepository(FirebaseAuth.instance),
    )
    ..registerLazySingleton(
      () => Dio(
        BaseOptions(
          baseUrl: _apiBaseUrl,
          connectTimeout: _apiTimeout,
          receiveTimeout: _apiTimeout,
        ),
      ),
    )
    ..registerLazySingleton(() => PlacesApi(getIt()))
    ..registerLazySingleton<PlacesRepository>(
      () => ApiPlacesRepository(getIt()),
    );
}
