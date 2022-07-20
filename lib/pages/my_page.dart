import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {

  List<SettingModel> list = [
    SettingModel(iconData: Icons.notifications,
        iconColor: Colors.blue,
        title: '消息中心',
        pageUrl: 'demo/chartPage',
        suffix: _NotificationsText(
          text: '2',
        )),
    SettingModel(iconData: Icons.thumb_up,
        iconColor: Colors.green,
        title: '我赞过的',
        suffix: _Suffix(
          text: '121篇',
        )),
    SettingModel(iconData: Icons.grade,
        iconColor: Colors.yellow,
        title: '收藏集',
        suffix: _Suffix(
          text: '2个',
        )),
    SettingModel(iconData: Icons.shopping_basket,
        iconColor: Colors.yellow,
        title: '已购小册',
        suffix: _Suffix(
          text: '100个',
        )),
    SettingModel(iconData: Icons.account_balance_wallet,
        iconColor: Colors.blue,
        title: '我的钱包',
        suffix: _Suffix(
          text: '10万',
        )),
    SettingModel(iconData: Icons.location_on,
        iconColor: Colors.grey,
        title: '阅读过的文章',
        suffix: _Suffix(
          text: '1034篇',
        )),
    SettingModel(iconData: Icons.local_offer,
        iconColor: Colors.grey,
        title: '标签管理',
        suffix: _Suffix(
          text: '27个',
        )),
  ];

  @override
  Widget build(BuildContext context) {
    // return WebViewWidget(url: "https://m.ctrip.com/webapp/myctrip/",);
    return Scaffold(
        appBar: AppBar(
          title: const Text("我的"),
        ),
        // floatingActionButton: DemoFlowPopMenu(),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Container(
          margin: const EdgeInsets.only(top: 10),
          child: RefreshIndicator(
            onRefresh: () {
              return Future.delayed(const Duration(seconds: 2));
            },
            child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return _SettingItem(settingModel: list[index]);
                },
                separatorBuilder: (BuildContext context,
                    int index) => const Divider(),
                itemCount: list.length
            ),
          ),
        )
    );
  }
}

class SettingModel {
  final IconData iconData;
  final Color iconColor;
  final String title;
  final Widget suffix;
  final String? pageUrl;

  SettingModel({required this.iconData,
    required this.iconColor,
    required this.title,
    required this.suffix,
  this.pageUrl});
}

class _SettingItem extends StatelessWidget {
  const _SettingItem({Key? key, required this.settingModel}) : super(key: key);

  final SettingModel settingModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (settingModel.pageUrl != null) {
          Navigator.pushNamed(context, settingModel.pageUrl!, arguments: settingModel.title);
        } else {
          showToast('无跳转页面');
        }
      },
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            const SizedBox(
              width: 30,
            ),
            Icon(
              settingModel.iconData,
              color: settingModel.iconColor,
            ),
            const SizedBox(
              width: 30,
            ),
            Expanded(
              child: Text(settingModel.title),
            ),
            settingModel.suffix,
            const SizedBox(
              width: 15,
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationsText extends StatelessWidget {
  final String text;

  const _NotificationsText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(50)),
            color: Colors.red),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      );
  }
}

class _Suffix extends StatelessWidget {
  final String text;

  const _Suffix({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: Colors.grey.withOpacity(.5)),
    );
  }
}
