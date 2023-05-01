import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jobportals/core/constants/app_assets.dart';

class NoDataAvailable extends StatefulWidget {
  final String topic;
  final bool isIconData;

  const NoDataAvailable({Key? key, required this.topic, required this.isIconData}) : super(key: key);

  @override
  State<NoDataAvailable> createState() => _NoDataAvailableState();
}

class _NoDataAvailableState extends State<NoDataAvailable> with TickerProviderStateMixin {
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.isIconData == false
              ? AnimatedBuilder(
                  animation: _animationColor,
                  builder: (BuildContext context, Widget? child) {
                    return Icon(FontAwesomeIcons.triangleExclamation, color: _animationColor.value, size: 50);
                  },
                )
              : Image.asset(AppAssets.noHistory, height: 250),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(5)),
            child: Text(widget.topic, textAlign: TextAlign.center, style: const TextStyle(fontSize: 15)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
