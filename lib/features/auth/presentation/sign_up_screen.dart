import 'package:flutter/material.dart';
import 'package:tourist_guide_app/core/di/service_locator.dart';
import 'package:tourist_guide_app/core/theme/app_colors.dart';
import 'package:tourist_guide_app/core/utils/validators.dart';
import 'package:tourist_guide_app/core/widgets/input_field.dart';
import 'package:tourist_guide_app/core/widgets/primary_button.dart';
import 'package:tourist_guide_app/core/widgets/snack_bar.dart';
import 'package:tourist_guide_app/core/widgets/top_bar.dart';
import 'package:tourist_guide_app/features/auth/presentation/sign_up_view_model.dart';
import 'package:tourist_guide_app/features/main/presentation/main_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  static const _textStyle = TextStyle(
    color: AppColors.text,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  final _viewModel = SignUpViewModel(getIt());
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  var _autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    _viewModel.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    // After the first attempt, errors update while the user types.
    setState(() => _autovalidateMode = AutovalidateMode.onUserInteraction);
    if (!_formKey.currentState!.validate()) return;

    final success = await _viewModel.signUp(
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (!mounted) return;

    if (success) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const MainScreen()),
        (_) => false,
      );
    } else {
      context.showSnackBar(_viewModel.errorMessage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(title: 'Register'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 36, 20, 24),
          child: Form(
            key: _formKey,
            autovalidateMode: _autovalidateMode,
            child: Column(
              children: [
                Image.asset('assets/images/sign_in_image.png', height: 145),
                const SizedBox(height: 24),
                const Text(
                  'Please create an account to continue.',
                  style: _textStyle,
                ),
                const SizedBox(height: 24),
                InputField(
                  controller: _emailController,
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: Validators.email,
                ),
                const SizedBox(height: 30),
                InputField(
                  controller: _passwordController,
                  label: 'Password',
                  isPassword: true,
                  textInputAction: TextInputAction.next,
                  validator: Validators.password,
                ),
                const SizedBox(height: 30),
                InputField(
                  controller: _confirmPasswordController,
                  label: 'Confirm password',
                  isPassword: true,
                  textInputAction: TextInputAction.done,
                  validator: (value) => Validators.confirmPassword(
                    value,
                    _passwordController.text,
                  ),
                ),
                const SizedBox(height: 80),
                ListenableBuilder(
                  listenable: _viewModel,
                  builder: (_, _) => PrimaryButton(
                    label: 'Sign up',
                    isLoading: _viewModel.isLoading,
                    onPressed: _signUp,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account? ', style: _textStyle),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Text(
                        'Sign in',
                        style: _textStyle.copyWith(color: AppColors.secondary),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
