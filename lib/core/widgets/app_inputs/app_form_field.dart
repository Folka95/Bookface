import 'package:flutter/material.dart';

class AppFormField extends StatefulWidget {
  final String? hintText;
  final String? labelText;

  final TextEditingController controller;

  final String? Function(String?)? validator;

  final TextInputType? keyboardType;

  final bool enabled;
  final bool isPassword;
  final bool readOnly;
  final bool isMust;

  final int maxLines;
  final int? maxLength;

  final ValueChanged<String>? onChanged;
  final void Function(String)? onFieldSubmitted;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  AppFormField({
    super.key,
    this.hintText,
    this.isPassword = false,
    this.labelText,
    required this.controller,
    this.validator,
    this.keyboardType,
    this.enabled = true,
    this.readOnly = false,
    this.isMust = false,
    this.maxLines = 1,
    this.maxLength,
    this.onChanged,
    this.onFieldSubmitted,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  State<AppFormField> createState() => _AppFormFieldState();
}

class _AppFormFieldState extends State<AppFormField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Color(0xFF201C18)),
      controller: widget.controller,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword ? obscureText : false,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      maxLines: widget.maxLines,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      maxLength: widget.maxLength,

      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFFFFFFF),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),

        hintText: widget.hintText,

        labelText: widget.isMust
            ? '${widget.labelText} *'
            : widget.labelText,

        prefixIcon: widget.prefixIcon,

        suffixIcon: widget.isPassword
            ? IconButton(
          onPressed: () {
            obscureText = !obscureText;
            setState(() {});
          },
          icon: Icon(
            obscureText
                ? Icons.visibility_off_outlined
                : Icons.visibility,
          ),
        )
            : widget.suffixIcon,
      ),
    );
  }
}