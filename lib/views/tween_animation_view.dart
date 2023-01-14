import 'package:flutter/material.dart';

class TweenAnimationView extends StatefulWidget {
  const TweenAnimationView({Key? key}) : super(key: key);

  @override
  State<TweenAnimationView> createState() => _TweenAnimationViewState();
}

class _TweenAnimationViewState extends State<TweenAnimationView>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation sizeAnimation;
  late Animation colorAnimation;
  late Animation alignmentAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    sizeAnimation = Tween<double>(
      begin: 40,
      end: 300,
    ).animate(animationController);

    colorAnimation = ColorTween(
      begin: Colors.yellow,
      end: Colors.red,
    ).animate(animationController);

    alignmentAnimation = AlignmentTween(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).animate(animationController);

    animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animation - Tween"),
      ),
      body: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) => Align(
          alignment: alignmentAnimation.value,
          child: Icon(
            Icons.favorite,
            size: sizeAnimation.value,
            color: colorAnimation.value,
          ),
        ),
      ),
    );
  }
}
