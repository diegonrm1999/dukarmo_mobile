import 'package:flutter/material.dart';

class BackgroundScaffold extends StatelessWidget {
  final Widget child;
  final String backgroundPath;
  final double transparency;

  const BackgroundScaffold({
    super.key,
    required this.child,
    required this.backgroundPath,
    this.transparency = 0.6,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          backgroundPath,
          fit: BoxFit.cover,
          alignment: Alignment(-0.5, -0.5),
          filterQuality: FilterQuality.low,
        ),
        Container(color: Colors.white.withAlpha((transparency * 255).round())),
        SafeArea(child: child),
      ],
    );
  }
}
