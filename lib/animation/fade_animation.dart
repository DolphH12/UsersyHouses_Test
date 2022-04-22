import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

enum AnyProps { opacidad, translate }

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    // final tween = MultiTween([
    //   Track('opacity').add(const Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
    //   Track('translateY').add(
    //     const Duration(milliseconds: 500), Tween(begin: -30.0, end: 0.0),
    //     curve: Curves.easeOut)
    // ]);
    final tween = MultiTween()
      ..add(AnyProps.opacidad, Tween(begin: 0.0, end: 1.0),
          const Duration(milliseconds: 500))
      ..add(AnyProps.translate, Tween(begin: -30.0, end: 0.0),
          Duration(milliseconds: 500));

    return PlayAnimation(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, child, animation) => Opacity(
        opacity: (animation as dynamic).get(AnyProps.opacidad),
        child: Transform.translate(
            offset: Offset(0, (animation as dynamic).get(AnyProps.translate)),
            child: child),
      ),
    );
  }
}
