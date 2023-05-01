import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';

class DialogBackground extends StatelessWidget {
  final Widget? dialog;
  final bool? disable;
  final Function? onDismiss;
  final double? blur;
  final Color? barrierColor;

  const DialogBackground({
    Key? key,
    this.dialog,
    this.disable,
    this.blur,
    this.onDismiss,
    this.barrierColor,
  }) : super(key: key);

  Future<T?> show<T>(BuildContext context, {bool? disable}) {
    return showGeneralDialog<T>(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) => this,
      barrierColor: barrierColor ?? Colors.black.withOpacity(.5),
      barrierDismissible: disable ?? true,
      barrierLabel: "",
      transitionDuration: Duration.zero,
      useRootNavigator: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.canvas,
      color: Colors.transparent,
      child: WillPopScope(
        onWillPop: () async {
          if (disable ?? true) {
            if (onDismiss != null) onDismiss?.call();
            return true;
          }
          return false;
        },
        child: Stack(
          clipBehavior: Clip.antiAlias,
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: <Widget>[
            InkWell(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                if (disable ?? true) {
                  onDismiss?.call();
                  Navigator.pop(context);
                }
              },
              child: (blur ?? 0) < 1
                  ? Container()
                  : TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0.1, end: blur ?? 0),
                      duration: const Duration(milliseconds: 300),
                      builder: (context, double? val, Widget? child) {
                        return BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: val ?? 0, sigmaY: val ?? 0),
                          child: Container(color: Colors.transparent),
                        );
                      },
                    ),
            ),
            dialog ?? const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}

_dialogButton({onPressed, clickType, color}) {
  return AnimatedButton(
    height: 35,
    width: Get.width * 0.3,
    color: color,
    shadowDegree: ShadowDegree.light,
    enabled: true,
    shape: BoxShape.rectangle,
    onPressed: onPressed ?? () => Get.back(),
    child: Text(clickType, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
  );
}

dynamic infoDialog({
  final String? titleText,
  final String? contentText,
  final String? cancelText,
  final String? okText,
  final void Function()? onPressed,
  final void Function()? onCancel,
}) {
  dynamic context = Get.context;
  DialogBackground(
    blur: 5,
    disable: false,
    dialog: AlertDialog(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        titleText ?? "Information",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: contentText != null ? Text(contentText) : null,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
      actionsAlignment: MainAxisAlignment.center,
      actions: <Widget>[
        _dialogButton(clickType: cancelText ?? "Cancel", color: Colors.grey, onPressed: onCancel),
        _dialogButton(clickType: okText ?? "Okay", color: Colors.blueGrey, onPressed: onPressed),
      ],
    ),
  ).show(context);
}

dynamic errorDialog({final String? contentText, final String? titleText, final void Function()? onPressed}) {
  dynamic context = Get.context;
  DialogBackground(
    blur: 5,
    barrierColor: Colors.red.withOpacity(0.05),
    disable: false,
    dialog: AlertDialog(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        titleText ?? "Error",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: contentText != null ? Text(contentText) : null,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
      actions: <Widget>[
        _dialogButton(clickType: "ok", color: Colors.red, onPressed: onPressed),
      ],
    ),
  ).show(context);
}

dynamic warningDialog({final String? contentText, final void Function()? onPressed}) {
  dynamic context = Get.context;
  DialogBackground(
    blur: 5,
    barrierColor: Colors.amber.withOpacity(0.05),
    disable: false,
    dialog: AlertDialog(
      backgroundColor: Colors.white,
      elevation: 0,
      title: const Text(
        "Warning",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: contentText != null ? Text(contentText) : null,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
      actions: <Widget>[
        _dialogButton(clickType: "ok", color: Colors.amber, onPressed: onPressed),
      ],
    ),
  ).show(context);
}

dynamic successDialog({
  final String? contentText,
  final String? titleText,
  final void Function()? onPressed,
}) {
  dynamic context = Get.context;
  DialogBackground(
    blur: 5,
    barrierColor: Colors.green.withOpacity(0.05),
    disable: false,
    dialog: AlertDialog(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        titleText ?? 'Update success',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: contentText != null ? Text(contentText) : null,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
      actions: <Widget>[
        _dialogButton(clickType: "ok", color: Colors.green, onPressed: onPressed),
      ],
    ),
  ).show(context);
}
