import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobportals/core/theme/light.dart';

class RoundedButton extends StatefulWidget {
  const RoundedButton({
    super.key,
    required this.text,
    required this.onTap,
    this.color,
    this.textColor,
    this.borderRadius,
    this.prefixIcon,
    this.suffixIcon,
    this.isLoading,
  });

  final String text;
  final Function onTap;
  final Color? color;
  final Color? textColor;
  final double? borderRadius;
  final bool? isLoading;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  State<RoundedButton> createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => widget.onTap(),
      color: widget.color ?? lightColorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 5.0),
      ),
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.prefixIcon ?? Container(),
          _validation(),
          widget.suffixIcon ?? Container(),
        ],
      ),
    );
  }

  Color? _getColor() {
    if (widget.textColor != null) {
      return widget.textColor;
    } else {
      return Colors.white;
    }
  }

  _validation() {
    if (widget.isLoading == false) {
      return Text(widget.text, style: TextStyle(color: _getColor(), letterSpacing: 1));
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(
            height: 18,
            width: 18,
            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
          ).paddingOnly(right: 10),
        ],
      );
    }
  }
}
