import 'package:tourist_guide_app/features/auth/domain/auth_user.dart';

/// Methods throw [AuthException] when something goes wrong.
abstract interface class AuthRepository {
  AuthUser? get currentUser;

  /// Waits until the saved session is restored after app start.
  Future<AuthUser?> getSignedInUser();

  Future<void> signIn({required String email, required String password});

  Future<void> signUp({required String email, required String password});

  Future<void> signOut();
}
