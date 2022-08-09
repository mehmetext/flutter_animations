import 'package:flutter/material.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';

class StaggeredAnimationsView extends StatefulWidget {
  const StaggeredAnimationsView({Key? key}) : super(key: key);

  @override
  State<StaggeredAnimationsView> createState() =>
      _StaggeredAnimationsViewState();
}

class _StaggeredAnimationsViewState extends State<StaggeredAnimationsView>
    with TickerProviderStateMixin {
  late AnimationController sequenceAnimationController;
  late SequenceAnimation sequenceAnimation;

  late AnimationController heartAnimationController;
  late Animation<double> heartSizeAnimation;

  @override
  void initState() {
    super.initState();
    sequenceAnimationController = AnimationController(vsync: this);

    heartAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 750),
    );

    sequenceAnimation = SequenceAnimationBuilder()
        .addAnimatable(
          animatable: AlignmentTween(
            begin: Alignment.topCenter,
            end: Alignment.center,
          ),
          from: Duration(milliseconds: 0),
          to: Duration(milliseconds: 1500),
          curve: Curves.elasticInOut,
          tag: "alignment",
        )
        .addAnimatable(
          animatable: Tween<double>(
            begin: 80,
            end: 300,
          ),
          from: Duration(milliseconds: 750),
          to: Duration(milliseconds: 1000),
          tag: "size",
        )
        .addAnimatable(
          animatable: ColorTween(
            begin: Colors.black,
            end: Colors.red,
          ),
          from: Duration(milliseconds: 750),
          to: Duration(milliseconds: 850),
          tag: "color",
        )
        .animate(sequenceAnimationController);

    heartSizeAnimation = Tween<double>(
      begin: 1,
      end: 1.3,
    ).animate(CurvedAnimation(
      parent: heartAnimationController,
      curve: Curves.elasticIn,
    ));

    sequenceAnimationController.forward();

    sequenceAnimationController.addListener(() {
      setState(() {});
    });

    sequenceAnimationController.addStatusListener((status) async {
      if (sequenceAnimationController.isCompleted) {
        heartAnimationController.repeat(reverse: true);
      } else {
        heartAnimationController.stop();
      }
    });

    heartAnimationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    sequenceAnimationController.dispose();
    heartAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Staggered Animations"),
        actions: [
          IconButton(
            onPressed: sequenceAnimationController.isAnimating
                ? null
                : () async {
                    if (sequenceAnimationController.isCompleted) {
                      sequenceAnimationController.reverse();
                    } else if (sequenceAnimationController.isDismissed) {
                      sequenceAnimationController.forward();
                    }
                  },
            icon: Icon(Icons.play_arrow),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Align(
              alignment: sequenceAnimation["alignment"].value,
              child: Transform.scale(
                scale: heartSizeAnimation.value,
                child: Icon(
                  (sequenceAnimationController.status !=
                          AnimationStatus.dismissed)
                      ? Icons.favorite
                      : Icons.heart_broken,
                  size: sequenceAnimation["size"].value,
                  color: sequenceAnimation["color"].value,
                ),
              ),
            ),
          ),
          Slider(
            value: sequenceAnimationController.value,
            onChanged: null,
          ),
        ],
      ),
    );
  }
}
