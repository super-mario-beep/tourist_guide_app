import 'package:flutter/material.dart';
import 'package:tourist_guide_app/core/di/service_locator.dart';
import 'package:tourist_guide_app/core/theme/app_colors.dart';
import 'package:tourist_guide_app/core/utils/validators.dart';
import 'package:tourist_guide_app/core/widgets/input_field.dart';
import 'package:tourist_guide_app/core/widgets/primary_button.dart';
import 'package:tourist_guide_app/core/widgets/snack_bar.dart';
import 'package:tourist_guide_app/features/auth/presentation/sign_in_view_model.dart';
import 'package:tourist_guide_app/features/auth/presentation/sign_up_screen.dart';
import 'package:tourist_guide_app/features/main/presentation/main_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  static const _textStyle = TextStyle(
    color: AppColors.text,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  final _viewModel = SignInViewModel(getIt());
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var _autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    _viewModel.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    setState(() => _autovalidateMode = AutovalidateMode.onUserInteraction);
    if (!_formKey.currentState!.validate()) return;

    final success = await _viewModel.signIn(
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Form(
            key: _formKey,
            autovalidateMode: _autovalidateMode,
            child: Column(
              children: [
                Image.asset('assets/images/sign_in_image.png'),
                const SizedBox(height: 24),
                const Text('Please sign in to your account.', style: _textStyle),
                const SizedBox(height: 32),
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
                  textInputAction: TextInputAction.done,
                  validator: Validators.password,
                ),
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text('Forgot password?', style: _textStyle),
                ),
                const SizedBox(height: 44),
                ListenableBuilder(
                  listenable: _viewModel,
                  builder: (_, _) => PrimaryButton(
                    label: 'Sign in',
                    isLoading: _viewModel.isLoading,
                    onPressed: _signIn,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? ", style: _textStyle),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const SignUpScreen()),
                      ),
                      child: Text(
                        'Sign up',
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
