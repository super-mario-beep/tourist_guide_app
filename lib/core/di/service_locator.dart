import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:tourist_guide_app/features/auth/data/firebase_auth_repository.dart';
import 'package:tourist_guide_app/features/auth/domain/auth_repository.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<AuthRepository>(
    () => FirebaseAuthRepository(FirebaseAuth.instance),
  );
}
