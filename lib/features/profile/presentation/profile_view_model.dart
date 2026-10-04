import 'package:tourist_guide_app/features/auth/domain/auth_repository.dart';

class ProfileViewModel {
  ProfileViewModel(this._authRepository);

  final AuthRepository _authRepository;

  String get email => _authRepository.currentUser?.email ?? '';

  /// Firebase email accounts have no name, so the part before "@" is used.
  String get displayName => email.split('@').first;

  Future<void> signOut() => _authRepository.signOut();
}
