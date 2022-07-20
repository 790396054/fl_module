import 'package:fl_module/dao/home_dao.dart';
import 'package:fl_module/model/common_model.dart';
import 'package:fl_module/model/grid_nav_model.dart';
import 'package:fl_module/model/home_model.dart';
import 'package:fl_module/model/sales_box_model.dart';
import 'package:fl_module/pages/search_page.dart';
import 'package:fl_module/pages/speak_page.dart';
import 'package:fl_module/util/navigator_util.dart';
import 'package:fl_module/widgets/grid_nav.dart';
import 'package:fl_module/widgets/local_nav.dart';
import 'package:fl_module/widgets/sales_box.dart';
import 'package:fl_module/widgets/search_bar.dart';
import 'package:fl_module/widgets/sub_nav.dart';
import 'package:flutter/material.dart';
import 'package:fl_module/widgets/loading_view.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';

const SEARCH_BAR_DEFAULT_TEXT = '网红打卡地 景点 酒店 美食';
const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double appBarAlpha = 0;

  List<CommonModel> bannerList = [];
  List<CommonModel> localNavList = [];
  List<CommonModel> subNavList = [];
  GridNavModel gridNavModel = GridNavModel();
  SalesBoxModel salesBoxModel = SalesBoxModel();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  Future<void> _handleRefresh() async {
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        localNavList = model.localNavList ?? [];
        subNavList = model.subNavList ?? [];
        gridNavModel = model.gridNav ?? GridNavModel();
        salesBoxModel = model.salesBox ?? SalesBoxModel();
        bannerList = model.bannerList ?? [];
        _loading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _loading = false;
      });
    }
  }

  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
    print(appBarAlpha);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: LoadingContainer(
        isLoading: _loading,
        child: Stack(
          children: [
            MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: RefreshIndicator(
                onRefresh: _handleRefresh,
                child: NotificationListener(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollUpdateNotification &&
                        scrollNotification.depth == 0) {
                      //滚动且是列表滚动的时候
                      _onScroll(scrollNotification.metrics.pixels);
                    }
                    return false;
                  },
                  child: _listView,
                ),
              ),
            ),
            _appBar
          ],
        ),
      ),
    );
  }

  Widget get _listView {
    return ListView(
      children: [
        _banner(),
        Padding(
          padding: const EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: LocalNav(localNavList: localNavList),
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(7, 4, 7, 4),
            child: GridNav(gridNavModel: gridNavModel)),
        Padding(
            padding: const EdgeInsets.fromLTRB(7, 0, 7, 4),
            child: SubNav(subNavList: subNavList)),
        Padding(
            padding: const EdgeInsets.fromLTRB(7, 0, 7, 4),
            child: SalesBox(salesBox: salesBoxModel)),
      ],
    );
  }

  Widget get _appBar {
    return Column(
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              //AppBar渐变遮罩背景
              colors: [Color(0x66000000), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: 80.0,
            decoration: BoxDecoration(
              color: Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255),
            ),
            child: SearchBar(
              searchBarType: appBarAlpha > 0.2
                  ? SearchBarType.homeLight
                  : SearchBarType.home,
              inputBoxClick: _jumpToSearch,
              speakClick: _jumpToSpeak,
              defaultText: SEARCH_BAR_DEFAULT_TEXT,
              leftButtonClick: () {},
            ),
          ),
        ),
        Container(
            height: appBarAlpha > 0.2 ? 0.5 : 0,
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]))
      ],
    );
  }

  Widget _banner() {
    return SizedBox(
      height: 160,
      child: Swiper(
        onTap: (index) {
          print(index);
        },
        autoplay: true,
        itemCount: bannerList.length,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            bannerList[index].icon,
            fit: BoxFit.fill,
          );
        },
        pagination: const SwiperPagination(),
      ),
    );
  }

  _jumpToSearch() {
    NavigatorUtil.push(
        context,
        SearchPage(
          hint: SEARCH_BAR_DEFAULT_TEXT,
        ));
  }

  _jumpToSpeak() {
    NavigatorUtil.push(context, SpeakPage());
  }
}
