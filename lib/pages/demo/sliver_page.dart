import 'package:flutter/material.dart';

class SliverListPage extends StatefulWidget {
  const SliverListPage({Key? key}) : super(key: key);

  @override
  State<SliverListPage> createState() => _SliverListPageState();
}

class _SliverListPageState extends State<SliverListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // title: const Text('Sliver Demo'),
      // ),
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          floating: true,
          expandedHeight: 200.0,
          flexibleSpace: FlexibleSpaceBar(
            title: const Text('复仇者联盟'),
            background: Image.network(
              'http://img.haote.com/upload/20180918/2018091815372344164.jpg',
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, crossAxisSpacing: 5, mainAxisSpacing: 3),
          delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              color: Colors.primaries[index % Colors.primaries.length],
              child: Text("$index", style: const TextStyle(color: Colors.white, fontSize: 20),),
            );
          }, childCount: 10),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((content, index) {
            return Container(
              height: 65,
              color: Colors.primaries[index % Colors.primaries.length],
            );
          }, childCount: 5),
        ),
      ])
    );
  }
}
