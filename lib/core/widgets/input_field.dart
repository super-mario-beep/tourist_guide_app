import 'package:flutter/material.dart';
import 'package:tourist_guide_app/core/theme/app_colors.dart';

class InputField extends StatefulWidget {
  const InputField({
    super.key,
    this.controller,
    this.label,
    this.isPassword = false,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.onChanged,
  });

  final TextEditingController? controller;
  final String? label;
  final bool isPassword;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  static const _height = 60.0;
  static const _radius = BorderRadius.all(Radius.circular(20));
  static const _fontSize = 16.0;
  static const _lineHeight = 1.25;
  static const _verticalPadding = (_height - _fontSize * _lineHeight) / 2;

  static const _shadows = [
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 4),
      blurRadius: 4,
    ),
    BoxShadow(
      color: Color(0x26000000),
      offset: Offset(0, 5),
      blurRadius: 10,
    ),
  ];

  late bool _obscureText = widget.isPassword;

  OutlineInputBorder _border(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: _radius,
      borderSide: BorderSide(color: color, width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    final errorColor = Theme.of(context).colorScheme.error;

    return Stack(
      children: [
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: _height,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: _radius,
              boxShadow: _shadows,
            ),
          ),
        ),
        TextFormField(
          controller: widget.controller,
          obscureText: _obscureText,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          validator: widget.validator,
          onChanged: widget.onChanged,
          style: const TextStyle(
            color: AppColors.text,
            fontSize: _fontSize,
            height: _lineHeight,
          ),
          decoration: InputDecoration(
            labelText: widget.label,
            filled: true,
            fillColor: AppColors.background,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: _verticalPadding,
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () =>
                        setState(() => _obscureText = !_obscureText),
                  )
                : null,
            border: _border(Colors.black.withValues(alpha: 0.3)),
            enabledBorder: _border(Colors.black.withValues(alpha: 0.3)),
            focusedBorder: _border(AppColors.primary, width: 1.5),
            errorBorder: _border(errorColor),
            focusedErrorBorder: _border(errorColor, width: 1.5),
          ),
        ),
      ],
    );
  }
}
