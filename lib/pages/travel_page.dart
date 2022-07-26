
import 'package:fl_module/dao/travel_tab_dao.dart';
import 'package:fl_module/model/travel_tab_model.dart';
import 'package:fl_module/pages/travel_tab_page.dart';
import 'package:flutter/material.dart';

class TravelPage extends StatefulWidget {
  const TravelPage({Key? key}) : super(key: key);

  @override
  State<TravelPage> createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> with TickerProviderStateMixin{
  late TabController _controller;
  List<TravelTab> tabs = [];
  TravelTabModel travelTabModel = TravelTabModel(tabs: []);

  @override
  void initState() {
    _controller = TabController(length: 0, vsync: this);
    TravelTabDao.fetch().then((TravelTabModel model) {
      _controller = TabController(length: model.tabs.length, vsync: this); //fix tab label 空白问题
      setState(() {
        tabs = model.tabs;
        travelTabModel = model;
      });
    }).catchError((e) {
      print(e);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 30),
              child: TabBar(
                  controller: _controller,
                  isScrollable: true,
                  labelColor: Colors.black,
                  labelPadding: EdgeInsets.fromLTRB(20, 0, 10, 5),
                  indicator: UnderlineTabIndicator(
                      // strokeCap: StrokeCap.round,
                      borderSide: BorderSide(
                        color: Color(0xff2fcfbb),
                        width: 3,
                      ),
                      insets: EdgeInsets.only(bottom: 10)),
                  tabs: tabs.map<Tab>((TravelTab tab) {
                    return Tab(
                      text: tab.labelName,
                    );
                  }).toList()),
            ),
            Flexible(
                child: TabBarView(
                    controller: _controller,
                    children: tabs.map((TravelTab tab) {
                      return TravelTabPage(
                        travelUrl: travelTabModel.url ?? '',
                        params: travelTabModel.params ?? {},
                        groupChannelCode: tab.groupChannelCode ?? '',
                      );
                    }).toList()))
          ],
        ));
  }
}
