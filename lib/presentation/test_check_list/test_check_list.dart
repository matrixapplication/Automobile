import 'package:automobile_project/core/services/responsive/num_extensions.dart';
import 'package:flutter/material.dart';

class TestCheckList extends StatefulWidget {

  const TestCheckList({Key? key}) : super(key: key);

  @override
  State<TestCheckList> createState() => _TestCheckListState();
}

class _TestCheckListState extends State<TestCheckList> {

  List<String> titles = ["Specifications", "Safety", "Technologies"];
  List<List<String>> content = [
    [
      "Engine capacity",
      "Horse Power",
      "Maximum Speed",
    ],
    [
      "safety 1",
      "safety 2",
      "safety 3",
    ],
    [
      "Technologies 1",
      "Technologies 2",
      "Technologies 3",
    ],
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
           /* const SliverAppBar(
              title: Text('My App'),
              floating: true,
              snap: true,
            ),*/
            SliverAppBar(
              floating: true,
              title: Container(
                child: Text('Flutter Slivers Demo',style:
                TextStyle(fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),),
              ),
              backgroundColor: Colors.white,
              expandedHeight: 300,
              flexibleSpace: Padding(
                padding:  EdgeInsets.only(top: 70.h),
                child: FlexibleSpaceBar(
                  background: Image.network(
                      "https://images.unsplash.com/photo-1503376780353-7e6692767b70?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
                      fit: BoxFit.cover),
                ),
              ),
            ),
          /*  SliverPersistentHeader(
              pinned: true,
              delegate: _MyWidget(headerHeight: 50),
            ),*/
            SliverFixedExtentList(
              itemExtent: 75,
              delegate: SliverChildListDelegate([
                Container(color: Colors.blue),
                Container(color: Colors.pink),
                Container(color: Colors.yellow),
              ]),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _MyWidget(headerHeight: 50),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {


                  return ListTile(
                    title: Text('Item $index'),
                  );
                },
                childCount: 50,
              ),
            ),



            SliverToBoxAdapter(
              child: Container(
                color: Colors.orange,
                padding: const EdgeInsets.all(16.0),
                child: Text('Sliver Grid Header', style: TextStyle(fontSize: 28)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class _MyWidget extends SliverPersistentHeaderDelegate {
  final double headerHeight;

  _MyWidget({required this.headerHeight});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: headerHeight,
      color: Colors.blue,
      child: const Center(
        child: Text('My Widget'),
      ),
    );
  }

  @override
  double get maxExtent => headerHeight;

  @override
  double get minExtent => headerHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}