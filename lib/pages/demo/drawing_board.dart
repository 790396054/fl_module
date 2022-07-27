
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawingBoard extends StatefulWidget {
  const DrawingBoard({Key? key}) : super(key: key);

  @override
  State<DrawingBoard> createState() => _DrawingBoardState();
}

class _DrawingBoardState extends State<DrawingBoard> {
  final List<List<Offset>> _path = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('画板'),),
      floatingActionButton: FloatingActionButton(
        child: const Text("清除"),
        onPressed: () {
          setState(() {
            _path.clear();
          });
        },
      ),
      body: Listener(
        onPointerDown: (PointerDownEvent event) {
          setState(() {
            _path.add([event.localPosition]);
          });
        },
        onPointerMove: (PointerMoveEvent event) {
          setState(() {
            _path[_path.length-1].add(event.localPosition);
          });
        },
        onPointerUp: (PointerUpEvent event) {
          setState(() {
            _path[_path.length-1].add(event.localPosition);
          });
        },
        onPointerCancel: (PointerCancelEvent event) {
          setState(() {
            _path[_path.length-1].add(event.localPosition);
          });
        },
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(
            painter: DrawingBoardPainter(_path),
          ),
        ),
      ),
    );
  }
}

class DrawingBoardPainter extends CustomPainter {
  final List<List<Offset>> path;

  DrawingBoardPainter(this.path);

  final Paint _paint = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3;

  @override
  void paint(Canvas canvas, Size size) {
    for (var list in path) {
      Path _path = Path();
      for (int i = 0; i < list.length; i++) {
        if (i == 0) {
          _path.moveTo(list[i].dx, list[i].dy);
        } else {
          _path.lineTo(list[i].dx, list[i].dy);
        }
      }
      canvas.drawPath(_path, _paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

}
