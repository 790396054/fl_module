import 'package:fl_module/pages/my_page.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class NestedScrollViewDemo extends StatefulWidget {
  const NestedScrollViewDemo({Key? key}) : super(key: key);

  @override
  State<NestedScrollViewDemo> createState() => _NestedScrollViewDemoState();
}

class _NestedScrollViewDemoState extends State<NestedScrollViewDemo>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2010),
            lastDate: DateTime(2025),
            helpText: '选则日期',
            cancelText: '取消',
            confirmText: '确定',
            // initialEntryMode: DatePickerEntryMode.input,
          );
          showToast(result.toString());
        },
        child: const Icon(Icons.date_range),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 230.0,
              pinned: true,
              flexibleSpace: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: PageView(
                  children: <Widget>[
                    MyPage(Colors.deepOrangeAccent),
                    MyPage(Colors.tealAccent),
                    MyPage(Colors.yellowAccent),
                  ],
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: StickyTabBarDelegate(
                child: TabBar(
                  labelColor: Colors.black,
                  controller: this._tabController,
                  tabs: <Widget>[
                    Tab(text: '资讯'),
                    Tab(text: '技术'),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: this._tabController,
          children: <Widget>[
            RefreshIndicator(
              onRefresh: () {
                return Future.delayed(const Duration(seconds: 3));
              },
              child: _buildTabNewsList(),
            ),
            _buildTabNewsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildTabNewsList() {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text(
            'diyigezuixin  推荐',
            style: TextStyle(fontSize: 14.0),
          ),
        ),
        ListTile(
          title: Text('diyigezuixin  推荐'),
        ),
      ],
    );
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: this.child,
    );
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class MyPage extends StatelessWidget {
  Color bg;

  MyPage(this.bg, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: bg,
    );
  }
}
