import 'package:flutter/material.dart';
import 'package:tourist_guide_app/theme/app_colors.dart';
import 'package:tourist_guide_app/widgets/primary_button.dart';

// Temporary mock user until authentication is connected.
const _name = 'Helena Weasley';
const _email = 'helena.weasley@gmail.com';
const _avatarUrl = 'https://randomuser.me/api/portraits/women/44.jpg';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 32, 20, 24),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'My profile',
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const _Avatar(url: _avatarUrl),
              const SizedBox(height: 12),
              const Text(
                _name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                _email,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              PrimaryButton(label: 'Sign out', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.url});

  final String url;

  static const _size = 130.0;
  static const _placeholderColor = Color(0xFFD9D9D9);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size,
      height: _size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color(0x40000000),
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: ClipOval(
        child: Image.network(
          url,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => const ColoredBox(
            color: _placeholderColor,
            child: Icon(Icons.person, size: 72, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
