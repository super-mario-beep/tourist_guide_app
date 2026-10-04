import 'package:flutter/foundation.dart';
import 'package:tourist_guide_app/features/auth/domain/auth_exception.dart';
import 'package:tourist_guide_app/features/auth/domain/auth_repository.dart';

class SignUpViewModel extends ChangeNotifier {
  SignUpViewModel(this._authRepository);

  final AuthRepository _authRepository;

  bool isLoading = false;
  String? errorMessage;

  /// Returns true when the account is created and the user is signed in.
  Future<bool> signUp({required String email, required String password}) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      await _authRepository.signUp(email: email.trim(), password: password);
      return true;
    } on AuthException catch (e) {
      errorMessage = e.message;
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
