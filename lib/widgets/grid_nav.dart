import 'package:fl_module/model/common_model.dart';
import 'package:fl_module/model/grid_nav_model.dart';
import 'package:fl_module/util/navigator_util.dart';
import 'package:fl_module/widgets/webview_page.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// 网格卡片
class GridNav extends StatelessWidget {
  final GridNavModel gridNavModel;

  const GridNav({Key? key, required this.gridNavModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias,
      color: Colors.transparent,
      child: Column(
        children: _gridNavItems(context),
      ),
    );
  }

  List<Widget> _gridNavItems(BuildContext context) {
    List<Widget> items = [];
    items.add(_gridNavItem(context, gridNavModel.hotel, true));
    items.add(_gridNavItem(context, gridNavModel.flight, false));
    items.add(_gridNavItem(context, gridNavModel.travel, false));

    return items;
  }

  _gridNavItem(BuildContext context, GridNavItem? gridNavItem, bool first) {
    List<Widget> items = [];
    if (gridNavItem == null) return items;

    items.add(_mainItem(context, gridNavItem.mainItem));
    items.add(_doubleItem(context, gridNavItem.item1, gridNavItem.item2));
    items.add(_doubleItem(context, gridNavItem.item3, gridNavItem.item4));

    List<Widget> expandItems = [];
    for (var item in items) {
      expandItems.add(Expanded(child: item, flex: 1));
    }

    Color startColor = Color(int.parse('0xff' + gridNavItem.startColor));
    Color endColor = Color(int.parse('0xff' + gridNavItem.endColor));
    return Container(
      height: 88,
      margin: first ? null : const EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
          //线性渐变
          gradient: LinearGradient(colors: [startColor, endColor])),
      child: Row(children: expandItems),
    );
  }

  _mainItem(BuildContext context, CommonModel? model) {
    if (model == null) return;
    return _wrapGesture(
        context,
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Image.network(
              model.icon,
              fit: BoxFit.contain,
              height: 88,
              width: 121,
              alignment: AlignmentDirectional.bottomEnd,
            ),
            Container(
              margin: EdgeInsets.only(top: 11),
              child: Text(
                model.title,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            )
          ],
        ),
        model);
  }

  _doubleItem(
      BuildContext context, CommonModel? topItem, CommonModel? bottomItem) {
    if (topItem == null || bottomItem == null) return Container();
    return Column(
      children: <Widget>[
        Expanded(
          child: _item(context, topItem, true),
        ),
        Expanded(
          child: _item(context, bottomItem, false),
        )
      ],
    );
  }

  _item(BuildContext context, CommonModel item, bool first) {
    BorderSide borderSide = BorderSide(width: 0.8, color: Colors.white);
    return FractionallySizedBox(
      //撑满父布局的宽度
      widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(
            border: Border(
          left: borderSide,
          bottom: first ? borderSide : BorderSide.none,
        )),
        child: _wrapGesture(
            context,
            Center(
              child: Text(
                item.title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            item),
      ),
    );
  }

  _wrapGesture(BuildContext context, Widget widget, CommonModel model) {
    return InkWell(
      onTap: () {
        NavigatorUtil.push(
            context,
            WebViewWidget(
              url: model.url ?? '',
              // statusBarColor: model.statusBarColor,
              // title: model.title,
              // hideAppBar: model.hideAppBar,
            ));
      },
      child: widget,
    );
  }
}
