import 'package:flutter/material.dart';
import 'package:tourist_guide_app/theme/app_colors.dart';
import 'package:tourist_guide_app/widgets/input_field.dart';
import 'package:tourist_guide_app/widgets/primary_button.dart';
import 'package:tourist_guide_app/widgets/top_bar.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  static const _textStyle = TextStyle(
    color: AppColors.text,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(title: 'Register'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 36, 20, 24),
          child: Column(
            children: [
              Image.asset('assets/images/sign_in_image.png', height: 145),
              const SizedBox(height: 24),
              const Text(
                'Please create an account to continue.',
                style: _textStyle,
              ),
              const SizedBox(height: 24),
              const InputField(
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 30),
              const InputField(
                label: 'Password',
                isPassword: true,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 30),
              const InputField(
                label: 'Confirm password',
                isPassword: true,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 80),
              PrimaryButton(label: 'Sign up', onPressed: () {}),
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
    );
  }
}
