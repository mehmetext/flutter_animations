import 'package:flutter/material.dart';

class AnimatedSelectableListWidget extends StatefulWidget {
  AnimatedSelectableListWidget({
    Key? key,
    required this.itemCount,
    required this.itemHeight,
    required this.onTap,
    required this.itemBuilder,
    this.activeIndex = 0,
    this.indicatorColor = Colors.red,
    this.indicatorWidth = 10,
  }) : super(key: key);

  int itemCount;
  double itemHeight;
  Function(int index) onTap;
  Color indicatorColor;
  Widget Function(int index) itemBuilder;
  int activeIndex;
  double indicatorWidth;

  @override
  State<AnimatedSelectableListWidget> createState() =>
      _AnimatedSelectableListWidgetState();
}

class _AnimatedSelectableListWidgetState
    extends State<AnimatedSelectableListWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> positionAnimation;
  late Tween<double> positionTween;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    )..addListener(() {
        setState(() {});
      });

    positionTween = Tween<double>(
      begin: widget.activeIndex * widget.itemHeight,
      end: widget.activeIndex * widget.itemHeight,
    );

    positionAnimation = positionTween.animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    )..addListener(() {});
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _changePosition(int i) {
    positionTween.end = i * widget.itemHeight;

    animationController.forward().whenComplete(() {
      positionTween.begin = positionTween.end;
      animationController.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.itemCount * widget.itemHeight,
      child: Stack(
        children: [
          Container(
            width: widget.indicatorWidth,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: Color(0xFFBABABA),
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          _indicatorWidget,
          Container(
            margin: EdgeInsets.only(left: widget.indicatorWidth),
            child: _listWidget,
          ),
        ],
      ),
    );
  }

  Widget get _listWidget => ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            if (!animationController.isAnimating) {
              widget.onTap(index);
              _changePosition(index);
            }
          },
          child: SizedBox(
            height: widget.itemHeight,
            child: widget.itemBuilder(index),
          ),
        ),
        itemCount: widget.itemCount,
      );

  Widget get _indicatorWidget => Positioned(
        top: positionAnimation.value,
        child: Container(
          height: widget.itemHeight,
          width: widget.indicatorWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: widget.indicatorColor,
          ),
        ),
      );
}
