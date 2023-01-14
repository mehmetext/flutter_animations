import 'package:flutter/material.dart';

class AnimationControllerTickerView extends StatefulWidget {
  const AnimationControllerTickerView({Key? key}) : super(key: key);

  @override
  State<AnimationControllerTickerView> createState() =>
      _AnimationControllerTickerViewState();
}

class _AnimationControllerTickerViewState
    extends State<AnimationControllerTickerView>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    // animationController.forward();
    animationController.repeat(reverse: true);

    animationController.addListener(() {
      // print("animationController.value = ${animationController.value}");
    });

    animationController.addStatusListener((status) {
      print("animationController.status = $status");

      /*if (status == AnimationStatus.completed) {
        animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }*/
    });
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
        title: Text("AnimationController - Ticker"),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
              animation: animationController,
              builder: (context, child) => Transform.scale(
                scale: 0.6 + 0.5 * animationController.value,
                child: Icon(
                  Icons.favorite,
                  size: MediaQuery.of(context).size.width,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
