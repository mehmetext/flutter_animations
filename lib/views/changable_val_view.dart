import 'package:flutter/material.dart';
import 'package:simple_animations/widgets/animated_selectable_list_widget.dart';

class ChangableValView extends StatefulWidget {
  const ChangableValView({Key? key}) : super(key: key);

  @override
  State<ChangableValView> createState() => _ChangableValViewState();
}

class _ChangableValViewState extends State<ChangableValView>
    with SingleTickerProviderStateMixin {
  List<String> list1 = [
    "Liste değer 1",
    "Liste değer 2",
    "Liste değer 3",
    "Liste değer 4",
  ];
  List<String> list2 = ["Mehmet", "Bi Kodist"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Changable Value"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            AnimatedSelectableListWidget(
              itemCount: list1.length,
              itemHeight: 40,
              indicatorColor: Colors.red,
              onTap: (index) {
                print("list1 selected: $index");
              },
              itemBuilder: (i) => _itemWidget(list1[i], i),
              activeIndex: 1,
            ),
            SizedBox(height: 10),
            AnimatedSelectableListWidget(
              itemCount: list2.length,
              itemHeight: 60,
              indicatorColor: Colors.indigo,
              onTap: (index) {
                print("list2 selected: $index");
              },
              itemBuilder: (i) => _itemWidget(list2[i], i, padding: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemWidget(String item, int i, {double padding = 10}) => Container(
        padding: EdgeInsets.symmetric(horizontal: padding),
        decoration: BoxDecoration(
          color: i % 2 == 0 ? Color(0xFFF8F8F8) : Colors.white,
          borderRadius: BorderRadius.horizontal(right: Radius.circular(6)),
        ),
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(item),
            Icon(
              Icons.abc,
            ),
          ],
        ),
      );
}
