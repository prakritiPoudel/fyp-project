import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.hint = "",
    this.title = "",
    this.keyboardType,
    this.validator,
    this.controller,
    this.maxLines = 1,
    this.radius = 360,
    this.onChanged,
    this.action,
    this.isPasswordField = false,
    this.prefixIcon,
  });
  final String hint;
  final String title;
  final TextInputType? keyboardType;
  final FormFieldValidator? validator;
  final TextEditingController? controller;
  final int maxLines;
  final double radius;
  final TextInputAction? action;
  final Function(String)? onChanged;
  final bool isPasswordField;
  final Widget? prefixIcon;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obsecured = true;
  toggle() {
    obsecured = !obsecured;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          onChanged: widget.onChanged,
          maxLines: widget.maxLines,
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          validator: widget.validator,
          obscureText: widget.isPasswordField ? obsecured : false,
          textInputAction: widget.action,
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: widget.isPasswordField
                ? IconButton(
                    onPressed: () {
                      toggle();
                    },
                    icon: Icon(
                      obsecured ? Icons.visibility_off : Icons.visibility,
                    ),
                  )
                : null,
            hintText: widget.hint,
            labelText: widget.title,
            isCollapsed: true,
            contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            border: border(),
            errorBorder: border(color: Colors.red),
            enabledBorder: border(),
            focusedBorder: border(),
            focusedErrorBorder: border(color: Colors.red),
            disabledBorder: border(),
          ),
        ),
      ],
    );
  }
}

OutlineInputBorder border({Color? color}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(
      color: color ?? const Color(0xffD9D9D9),
    ),
  );
}
