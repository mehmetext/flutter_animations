import 'package:flutter/material.dart';

class CurvedAnimationView extends StatefulWidget {
  const CurvedAnimationView({Key? key}) : super(key: key);

  @override
  State<CurvedAnimationView> createState() => _CurvedAnimationViewState();
}

class _CurvedAnimationViewState extends State<CurvedAnimationView>
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
      duration: Duration(milliseconds: 1500),
    );

    CurvedAnimation elasticInOutAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.elasticInOut,
    );

    sizeAnimation = Tween<double>(
      begin: 40,
      end: 300,
    ).animate(elasticInOutAnimation);

    colorAnimation = ColorTween(
      begin: Colors.yellow,
      end: Colors.red,
    ).animate(elasticInOutAnimation);

    alignmentAnimation = AlignmentTween(
      begin: Alignment.topCenter,
      end: Alignment.center,
    ).animate(elasticInOutAnimation);

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
