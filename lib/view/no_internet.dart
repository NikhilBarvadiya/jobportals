import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Color?> _animationColor;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat(reverse: true);
    _animationColor = ColorTween(begin: Colors.grey, end: Colors.black).animate(_animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _animationColor,
                builder: (BuildContext context, Widget? child) {
                  return Icon(FontAwesomeIcons.triangleExclamation, color: _animationColor.value, size: 80);
                },
              ),
              const SizedBox(height: 15),
              const Text('Something wrong!', style: TextStyle(color: Colors.black, fontSize: 20, decoration: TextDecoration.none)),
              const SizedBox(height: 15),
              const Text('Please check your internet connection!', style: TextStyle(color: Colors.black, decoration: TextDecoration.none)),
            ],
          ),
        ),
      ),
    );
  }

}
