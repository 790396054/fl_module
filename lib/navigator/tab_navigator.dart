import 'package:fl_module/pages/home_page.dart';
import 'package:fl_module/pages/my_page.dart';
import 'package:fl_module/pages/search_page.dart';
import 'package:fl_module/pages/travel_page.dart';
import 'package:flutter/material.dart';

class TabNavigator extends StatefulWidget {
  const TabNavigator({Key? key}) : super(key: key);

  @override
  State<TabNavigator> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {

  final PageController _controller = PageController(initialPage: 0);
  int _currentIndex = 0;
  final Color _defaultColor = Colors.grey;
  final Color _activeColor = Colors.blue;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          HomePage(),
          SearchPage(),
          TravelPage(),
          MyPage()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          _bottomItem('首页', Icons.home, 0),
          _bottomItem('搜索', Icons.search, 1),
          _bottomItem('旅拍', Icons.camera_alt, 2),
          _bottomItem('我的', Icons.account_circle, 3),
        ],
      ),
    );
  }

  _bottomItem(String name, IconData icon, int index) {
    return BottomNavigationBarItem(
        icon: Icon(icon, color: _defaultColor,),
        activeIcon: Icon(icon, color: _activeColor,),
        title: Text(name, style: TextStyle(
            color: _currentIndex != index ? _defaultColor : _activeColor),)
    );
  }
}
