import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String label;
  final IconData? icon;
  final IconData? trailing;
  final bool isPassword;
  final int maxLines;

  const CustomField({
    super.key,
    required this.label,
    this.icon,
    this.trailing,
    this.isPassword = false,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        obscureText: isPassword,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon != null ? Icon(icon) : null,
          suffixIcon: trailing != null ? Icon(trailing) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
        ),
      ),
    );
  }
}