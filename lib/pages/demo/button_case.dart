
import 'package:flutter/material.dart';

class ButtonCase extends StatefulWidget {
  const ButtonCase({Key? key}) : super(key: key);

  @override
  State<ButtonCase> createState() => _ButtonCaseState();
}

class _ButtonCaseState extends State<ButtonCase> {
  ButtonStatus _buttonStatus = ButtonStatus.none;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("登录进度按钮"),),
      body: Center(
        child: MaterialButton(
          color: Colors.blue,
          minWidth: 240,
          height: 48,
          onPressed: () {
            setState(() {
              _buttonStatus = ButtonStatus.loading;
              Future.delayed(const Duration(seconds: 2), () {
                setState(() {
                  _buttonStatus = ButtonStatus.done;
                });
              });
              Future.delayed(const Duration(seconds: 3), () {
                setState(() {
                  _buttonStatus = ButtonStatus.none;
                });
              });
            });
          },
          child: _buildChild(),
        ),
      ),
    );
  }

  _buildChild() {
    if (_buttonStatus == ButtonStatus.none) {
      return const Text(
        '登 录',
        style: TextStyle(color: Colors.white,fontSize: 18),
      );
    } else if (_buttonStatus == ButtonStatus.loading) {
      return const CircularProgressIndicator(
        backgroundColor: Colors.white,
        strokeWidth: 2,
      );
    } else if (_buttonStatus == ButtonStatus.done) {
      return const Icon(
        Icons.check,
        color: Colors.white,
      );
    }
  }
}

enum ButtonStatus{none, loading, done}