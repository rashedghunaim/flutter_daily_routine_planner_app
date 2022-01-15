import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodayCircleAnimation extends StatelessWidget {
  final int length;

  final String title;

  TodayCircleAnimation(this.title, this.length);

  final size = 70.0;
  static const TWO_PI = 3.14 * 2;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(seconds: 3),
      builder: (context, value, child) {
        return Container(
          width: size,
          height: size,
          child: Stack(
            children: [
              ShaderMask(
                shaderCallback: (rect) {
                  return SweepGradient(
                    startAngle: 0.0,
                    endAngle: TWO_PI,
                    stops: [value as double, value],
                    center: Alignment.center,
                    colors: [
                      // Colors.white,
                      // Colors.transparent
                      Theme.of(context).colorScheme.onPrimary,
                      Theme.of(context).colorScheme.surface,
                    ],
                  ).createShader(rect);
                },
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: Image.asset(
                        'lib/assets/images/istockphoto-1140647489-612x612.jpg',
                        fit: BoxFit.cover,
                      ).image,
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: size - 1,
                  height: size - 1,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        length.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          decorationStyle: TextDecorationStyle.wavy,
                        ),
                      ),
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          decorationStyle: TextDecorationStyle.wavy,
                          debugLabel: 'hey there',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
