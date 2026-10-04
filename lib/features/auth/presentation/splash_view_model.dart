import 'package:tourist_guide_app/features/auth/domain/auth_repository.dart';

class SplashViewModel {
  SplashViewModel(this._authRepository);

  final AuthRepository _authRepository;

  static const _minimumDuration = Duration(seconds: 2);

  /// Checks the saved session, but keeps the splash visible for at least
  /// [_minimumDuration] so it doesn't just flash.
  Future<bool> isSignedIn() async {
    final (user, _) = await (
      _authRepository.getSignedInUser(),
      Future<void>.delayed(_minimumDuration),
    ).wait;
    return user != null;
  }
}
