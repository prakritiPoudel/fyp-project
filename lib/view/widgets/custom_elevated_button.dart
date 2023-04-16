import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.text,
    this.color,
    this.elevation = 0,
    this.borderRadius = 8,
    this.onPressed,
    this.loading = false,
  });

  final String text;
  final Color? color;
  final double elevation;
  final double borderRadius;
  final VoidCallback? onPressed;
  final bool loading;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: elevation,
        backgroundColor: color ?? Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius,
          ),
        ),
      ),
      onPressed: loading
          ? null
          : () {
              FocusScope.of(context).unfocus();
              if (onPressed != null) {
                onPressed!();
              }
            },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
      ),
    );
  }
}
