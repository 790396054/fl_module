
import 'package:fl_module/model/common_model.dart';
import 'package:flutter/material.dart';

class LocalNav extends StatelessWidget {
  final List<CommonModel> localNavList;

  const LocalNav({Key? key, required this.localNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  Widget _items(BuildContext context) {
    List<Widget> items = [];
    for (var model in localNavList) {
      items.add(_item(context, model));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items,
    );
  }

  Widget _item(BuildContext context, CommonModel model) {
    return Column(
      children: <Widget>[
        Image.network(
          model.icon,
          width: 32,
          height: 32,
        ),
        Text(
          model.title,
          style: const TextStyle(fontSize: 12),
        )
      ],
    );
  }
}
