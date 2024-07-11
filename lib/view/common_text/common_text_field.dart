import 'package:flutter/material.dart';

class CommonTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Function(String)? onChanged;
  final String? helperText;
  final String? labelText;
  final int? maxLines;
  final bool hasError;
  final IconData? prefixIconData;
  final IconData? passwordHideIcon;
  final IconData? passwordShowIcon;
  final TextInputAction? textInputAction;
  final Color? textColor;
  final Color? accentColor;

  const CommonTextField({
    Key? key,
    required this.controller,
    this.hintText,
    this.keyboardType,
    this.obscureText = false,
    this.onChanged,
    this.helperText,
    this.labelText,
    this.hasError = false,
    this.prefixIconData,
    this.passwordHideIcon,
    this.passwordShowIcon,
    this.textInputAction,
    this.textColor,
    this.maxLines = 1,
    this.accentColor,
  }) : super(key: key);

  @override
  _CommonTextFieldState createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  bool _isObscure = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: _isObscure,
      onChanged: widget.onChanged,
      textInputAction: widget.textInputAction,
      maxLines: !_isObscure ? widget.maxLines : 1,
      style:
          TextStyle(color: widget.textColor ?? Colors.black), // Set text color
      decoration: InputDecoration(
        hintText: widget.hintText,
        // labelText: widget.labelText ??'', // Use confirmation text as label if provided, else use default label text
        labelStyle: TextStyle(
            color: widget.accentColor ?? Colors.black), // Set accent color
        helperText: widget.helperText,
        prefixIcon: widget.prefixIconData != null
            ? Icon(widget.prefixIconData,
                color: widget.accentColor ??
                    theme.colorScheme
                        .primary) // Set accent color for prefix icon
            : null,
        suffixIcon: widget.obscureText
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
                icon: Icon(_isObscure
                    ? widget.passwordShowIcon ?? Icons.visibility
                    : widget.passwordHideIcon ?? Icons.visibility_off),
                color: widget.accentColor ?? theme.colorScheme.primary,
              )
            : null,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          // borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: theme.primaryColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          // borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: theme.colorScheme.secondary, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          // borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: theme.disabledColor, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          // borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        // You can add more customization to the decoration as needed
        // For example, adding icons, labels, etc.
      ),
    );
  }
}
