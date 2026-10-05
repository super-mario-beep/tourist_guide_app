import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:tourist_guide_app/core/services/maps_launcher.dart';
import 'package:tourist_guide_app/features/auth/data/firebase_auth_repository.dart';
import 'package:tourist_guide_app/features/auth/domain/auth_repository.dart';
import 'package:tourist_guide_app/features/favorites/data/hive_favorites_repository.dart';
import 'package:tourist_guide_app/features/favorites/domain/favorites_repository.dart';
import 'package:tourist_guide_app/features/places/data/api_places_repository.dart';
import 'package:tourist_guide_app/features/places/data/place_adapter.dart';
import 'package:tourist_guide_app/features/places/data/places_api.dart';
import 'package:tourist_guide_app/features/places/data/places_local_storage.dart';
import 'package:tourist_guide_app/features/places/domain/place.dart';
import 'package:tourist_guide_app/features/places/domain/places_repository.dart';

final getIt = GetIt.instance;

const _apiBaseUrl = 'http://144.91.87.48:8080';
const _apiTimeout = Duration(seconds: 15);

Future<void> setupServiceLocator() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PlaceAdapter());
  final placesBox = await Hive.openBox<Place>(PlacesLocalStorage.boxName);
  final favoritesBox = await Hive.openBox<Place>(
    HiveFavoritesRepository.boxName,
  );

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
    ..registerLazySingleton(() => PlacesLocalStorage(placesBox))
    ..registerLazySingleton<PlacesRepository>(
      () => ApiPlacesRepository(getIt(), getIt()),
    )
    ..registerLazySingleton<FavoritesRepository>(
      () => HiveFavoritesRepository(favoritesBox),
    )
    ..registerLazySingleton(MapsLauncher.new);
}
