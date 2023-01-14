import 'package:flutter/material.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';

class MenuView extends StatefulWidget {
  const MenuView({Key? key}) : super(key: key);

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> with TickerProviderStateMixin {
  late AnimationController animationController;
  late SequenceAnimation sequenceAnimation;

  List<String> menuItems = [
    "Ana Sayfa",
    "Blog",
    "Hakkımızda",
    "İletişim",
  ];

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
    );

    SequenceAnimationBuilder sequenceAnimationBuilder =
        SequenceAnimationBuilder()
            .addAnimatable(
              animatable: Tween<double>(
                begin: 0,
                end: 1,
              ),
              from: Duration.zero,
              to: Duration(milliseconds: 375),
              curve: Curves.easeInCubic,
              tag: "body",
            )
            .addAnimatable(
              animatable: Tween<double>(begin: 0, end: 1),
              curve: Curves.easeInCubic,
              from: Duration(milliseconds: 125),
              to: Duration(milliseconds: 500),
              tag: "menu",
            );

    for (int i = 0; i < menuItems.length; i++) {
      sequenceAnimationBuilder.addAnimatable(
        animatable: Tween<double>(
          begin: 0,
          end: 1,
        ),
        from: Duration(milliseconds: 500 + (i * 50)),
        to: Duration(milliseconds: 625 + (i * 50)),
        tag: "menuItem-$i",
      );
    }

    sequenceAnimation = sequenceAnimationBuilder.animate(animationController);

    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void toggleMenu() {
    if (animationController.isCompleted) {
      animationController.reverse();
    } else if (animationController.isDismissed) {
      animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!animationController.isDismissed) {
          animationController.reverse();
        } else {
          return true;
        }
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            _menuWidget,
            _bodyWidget,
          ],
        ),
      ),
    );
  }

  Widget get _bodyWidget => Positioned(
        left: sequenceAnimation["body"].value *
            MediaQuery.of(context).size.width *
            0.5,
        child: Transform.scale(
          scale: 1 - (0.4 * sequenceAnimation["body"].value),
          child: IgnorePointer(
            ignoring: animationController.isCompleted,
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(sequenceAnimation["body"].value * 20),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6,
                    color: Colors.black
                        .withOpacity(sequenceAnimation["body"].value * 0.2),
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () {
                        toggleMenu();
                      },
                    ),
                    title: Text("AppBar"),
                  ),
                  body: ListView.builder(
                    itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(
                        color: index % 2 == 0 ? Colors.black12 : Colors.white,
                      ),
                      padding: EdgeInsets.all(20),
                      child: Text("Deneme $index"),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget get _menuWidget => SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int i = 0; i < menuItems.length; i++)
                      Opacity(
                        opacity: sequenceAnimation["menuItem-$i"].value,
                        child: listItemWidget(menuItems[i]),
                      ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  animationController.reverse();
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      );

  Widget listItemWidget(String title) => Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
}
