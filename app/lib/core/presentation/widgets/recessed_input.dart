import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class RecessedInput extends StatefulWidget {
  final String label;
  final String hintText;
  final IconData prefixIcon;
  final bool isPassword;
  final TextEditingController? controller;

  const RecessedInput({
    super.key,
    required this.label,
    required this.hintText,
    required this.prefixIcon,
    this.isPassword = false,
    this.controller,
  });

  @override
  State<RecessedInput> createState() => _RecessedInputState();
}

class _RecessedInputState extends State<RecessedInput> {
  bool _obscureText = true;
  bool _isFocused = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0, bottom: 6.0),
          child: Text(
            widget.label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppTheme.onSurface,
                ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 56,
          decoration: BoxDecoration(
            color: _isFocused ? Colors.white : AppTheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(9999),
            boxShadow: _isFocused
                ? [
                    BoxShadow(
                      color: AppTheme.primaryContainer.withOpacity(0.15),
                      spreadRadius: 4,
                      blurRadius: 0,
                    )
                  ]
                : null,
          ),
          child: Center(
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              obscureText: _obscureText,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.outline,
                    ),
                prefixIcon: Icon(
                  widget.prefixIcon,
                  color: AppTheme.outline,
                  size: 20,
                ),
                suffixIcon: widget.isPassword
                    ? IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: _isFocused ? AppTheme.primary : AppTheme.outline,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
