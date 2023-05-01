import 'package:flutter/material.dart';
import 'package:jobportals/core/theme/light.dart';

class TextBoxOutLine extends StatefulWidget {
  const TextBoxOutLine({
    super.key,
    this.icon,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.maxLength,
    this.radius,
    this.contentPadding,
    this.suffixIcon,
    this.errorText,
    this.onChanged,
    this.onEditingComplete,
    this.onTap,
    this.focusNode,
    this.fillColor,
    this.isBorder,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final IconData? icon;
  final Widget? suffixIcon;
  final String? hintText;
  final String? errorText;
  final TextInputType? keyboardType;
  final int? maxLength;
  final double? radius;
  final EdgeInsets? contentPadding;
  final Color? fillColor;
  final bool? isBorder;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final GestureTapCallback? onTap;

  @override
  State<TextBoxOutLine> createState() => _TextBoxOutLineState();
}

class _TextBoxOutLineState extends State<TextBoxOutLine> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      maxLength: widget.maxLength,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      cursorColor: lightColorScheme.secondary,
      decoration: InputDecoration(
        counterText: "",
        filled: true,
        isDense: widget.focusNode != null && widget.focusNode!.hasFocus == true ? true : false,
        fillColor: widget.fillColor ?? Colors.white,
        contentPadding: widget.contentPadding ?? const EdgeInsets.symmetric(vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(widget.radius ?? 4)),
          borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(widget.radius ?? 4)),
          borderSide: BorderSide(color: lightColorScheme.secondary, width: 1),
        ),
        border: widget.isBorder == null ? const OutlineInputBorder() : null,
        prefixIcon: widget.icon == null ? null : Icon(widget.icon, color: lightColorScheme.secondary),
        suffixIcon: widget.suffixIcon,
        hintText: widget.hintText,
        errorText: widget.errorText,
      ),
    );
  }
}
