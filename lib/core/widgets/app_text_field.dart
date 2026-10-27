import 'package:flutter/material.dart';

import '../../app/theme/app_tokens.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.label,
    this.hint,
    this.errorText,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.autofillHints,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
    this.enabled = true,
    this.readOnly = false,
    this.obscureText = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    super.key,
  }) : assert(
         controller == null || initialValue == null,
         'Provide a controller or initialValue, not both.',
       ),
       assert(
         !obscureText || maxLines == 1,
         'Obscured fields must use a single line.',
       );

  final String label;
  final String? hint;
  final String? errorText;
  final TextEditingController? controller;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final Iterable<String>? autofillHints;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final bool enabled;
  final bool readOnly;
  final bool obscureText;
  final bool autocorrect;
  final bool enableSuggestions;
  final int? maxLines;
  final int? minLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      onChanged: onChanged,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      autofillHints: autofillHints,
      focusNode: focusNode,
      enabled: enabled,
      readOnly: readOnly,
      obscureText: obscureText,
      autocorrect: autocorrect,
      enableSuggestions: enableSuggestions,
      maxLines: maxLines,
      minLines: minLines,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        errorText: errorText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.all(AppTokens.space16),
      ),
    );
  }
}
