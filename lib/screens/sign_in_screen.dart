import 'package:flutter/material.dart';
import 'package:tourist_guide_app/screens/sign_up_screen.dart';
import 'package:tourist_guide_app/theme/app_colors.dart';
import 'package:tourist_guide_app/widgets/input_field.dart';
import 'package:tourist_guide_app/widgets/primary_button.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  static const _textStyle = TextStyle(
    color: AppColors.text,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            children: [
              Image.asset('assets/images/sign_in_image.png'),
              const SizedBox(height: 24),
              const Text('Please sign in to your account.', style: _textStyle),
              const SizedBox(height: 32),
              const InputField(
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 30),
              const InputField(
                label: 'Password',
                isPassword: true,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerRight,
                child: Text('Forgot password?', style: _textStyle),
              ),
              const SizedBox(height: 44),
              PrimaryButton(label: 'Sign in', onPressed: () {}),
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
    );
  }
}
