import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourist_guide_app/features/auth/domain/auth_exception.dart';
import 'package:tourist_guide_app/features/auth/domain/auth_repository.dart';
import 'package:tourist_guide_app/features/auth/domain/auth_user.dart';

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository(this._auth);

  final FirebaseAuth _auth;

  @override
  AuthUser? get currentUser => _toAuthUser(_auth.currentUser);

  @override
  Future<AuthUser?> getSignedInUser() async {
    final user = await _auth.authStateChanges().first;
    return _toAuthUser(user);
  }

  @override
  Future<void> signIn({required String email, required String password}) {
    return _guard(
      () => _auth.signInWithEmailAndPassword(email: email, password: password),
    );
  }

  @override
  Future<void> signUp({required String email, required String password}) {
    return _guard(
      () => _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<void> signOut() => _guard(_auth.signOut);

  AuthUser? _toAuthUser(User? user) {
    if (user == null) return null;
    return AuthUser(id: user.uid, email: user.email ?? '');
  }

  Future<void> _guard(Future<Object?> Function() action) async {
    try {
      await action();
    } on FirebaseAuthException catch (e) {
      throw AuthException(_messageFor(e.code));
    } catch (_) {
      throw const AuthException('Something went wrong. Please try again.');
    }
  }

  String _messageFor(String code) {
    return switch (code) {
      'invalid-credential' ||
      'wrong-password' ||
      'user-not-found' => 'Wrong email or password.',
      'invalid-email' => 'Please enter a valid email.',
      'email-already-in-use' => 'An account with this email already exists.',
      'weak-password' => 'Password is too weak.',
      'user-disabled' => 'This account has been disabled.',
      'too-many-requests' => 'Too many attempts. Please try again later.',
      'network-request-failed' => 'No internet connection.',
      _ => 'Something went wrong. Please try again.',
    };
  }
}
