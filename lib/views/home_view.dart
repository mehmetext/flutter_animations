import 'package:flutter/material.dart';
import 'package:simple_animations/views/animation_controller_ticker_view.dart';
import 'package:simple_animations/views/changable_val_view.dart';
import 'package:simple_animations/views/menu_view.dart';

import 'curved_animation_view.dart';
import 'staggered_animations_view.dart';
import 'tween_animation_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animasyonlar"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnimationControllerTickerView(),
                  ),
                );
              },
              child: Text("AnimationController - Ticker"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TweenAnimationView(),
                  ),
                );
              },
              child: Text("Tween Animation"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CurvedAnimationView(),
                  ),
                );
              },
              child: Text("Curved Animation"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StaggeredAnimationsView(),
                  ),
                );
              },
              child: Text("Staggered Animations"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MenuView(),
                  ),
                );
              },
              child: Text("Custom Menu"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangableValView(),
                  ),
                );
              },
              child: Text("Changable Value"),
            )
          ],
        ),
      ),
    );
  }
}
