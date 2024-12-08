import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  final AnimationController controller;
  final VoidCallback onSplashEnd; // Callback for when splash ends

  const SplashScreen({
    Key? key,
    required this.controller,
    required this.onSplashEnd,
  }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Add a listener to detect when the animation ends
    widget.controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onSplashEnd(); // Notify parent when animation finishes
      }
    });

    // Start the animation
    widget.controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    const Color arcticBlue = Color(0xFFB0C4DE);
    const Color darkerArcticBlue = Color(0xFF6EBED8);
    const Color pearlWhite = Color(0xFFFDFDFD);

    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        // Rotation effect to the left and right (windrose effect)
        double rotationValue = widget.controller.value *
            3.14159; // Range 0 to 2*pi for one full rotation
        rotationValue =
            (rotationValue % (3.14159 / 2)); // To ensure it loops correctly

        return Center(
          child: Stack(
            children: [
              DecoratedBox(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [darkerArcticBlue, pearlWhite],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 200,
                    left: 20,
                    right: 20,
                  ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 40,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Transform.rotate(
                      angle:
                          rotationValue, // Applying the rotation to the SVG only
                      child: SvgPicture.asset(
                        'assets/windrose.svg',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                top: MediaQuery.of(context).size.height * 0.6,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                  height: 100,
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.7,
                left: MediaQuery.of(context).size.width * 0.35,
                child: Column(
                  children: [
                    const Text(
                      'GoLocal',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: arcticBlue,
                        shadows: [
                          Shadow(
                            offset: Offset(2, 2),
                            blurRadius: 4,
                            color: Colors.black,
                          ),
                        ],
                        letterSpacing: 1.2,
                        fontFamily: 'Arial',
                      ),
                    ),
                  ],
                ),
              ),
              // Apply the rotation transform to the windrose (SVG) only
            ],
          ),
        );
      },
    );
  }
}
