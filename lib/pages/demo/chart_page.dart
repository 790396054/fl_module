
import 'package:fl_module/pages/my_page.dart';
import 'package:flutter/material.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  final double _width = 20.0;
  List<double> _heightList = [60.0, 80.0, 100.0, 120.0, 140.0];

  @override
  Widget build(BuildContext context) {
    var arguments = ModalRoute.of(context)!.settings.arguments;
    String title = '图标示例';
    if (arguments != null && arguments is String) {
      title = arguments;
    }
    return Scaffold(
      appBar: AppBar(title: Text(title),),
      body: Center(
        child: Container(
          height: 200,
          width: 250,
          child: Stack(
            children: <Widget>[
              _Axis(),
              Positioned.fill(
                left: 5,
                right: 5,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(_heightList.length, (index) {
                      return _Cylinder(
                        height: _heightList[index],
                        width: _width,
                        color: Colors.primaries[index % Colors.primaries.length],
                      );
                    })),
              ),
              Positioned(
                top: 0,
                left: 30,
                child: OutlineButton(
                  child: Text('反转'),
                  onPressed: () {
                    setState(() {
                      _heightList = _heightList.reversed.toList();
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Axis extends StatelessWidget {
  final Widget? child;

  const _Axis({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: Colors.black, width: 2),
          bottom: BorderSide(color: Colors.black, width: 2),
        ),
      ),
      child: child,
    );
  }
}

class _Cylinder extends StatelessWidget {
  final double height;
  final double width;
  final Color color;

  const _Cylinder({Key? key, required this.height, required this.width, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      height: height,
      width: width,
      color: color,
    );
  }
}
