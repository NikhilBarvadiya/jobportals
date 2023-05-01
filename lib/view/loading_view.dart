// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingView extends StatefulWidget {
  const LoadingView({Key? key, required this.isLoading, required this.child}) : super(key: key);
  final bool isLoading;
  final Widget child;

  @override
  State<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (widget.isLoading)
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.black.withOpacity(.2)),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: kElevationToShadow[2]),
                    child: Column(
                      children: [
                        LoadingAnimationWidget.fourRotatingDots(color: Theme.of(context).primaryColor, size: 30),
                        const SizedBox(height: 6),
                        const Text("Loading", style: TextStyle(fontSize: 12, color: Colors.black, decoration: TextDecoration.none)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
