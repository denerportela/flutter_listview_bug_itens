import 'styles.dart';
import 'package:flutter/material.dart';

class AppLayout extends StatelessWidget {
  AppLayout(
      {this.navBar,
      this.widget,
      this.colorBloco = const Color.fromRGBO(247, 249, 251, 1.0),
      this.enableScroll = true});

  final Widget navBar;
  final Widget widget;
  final Color colorBloco;
  final bool enableScroll;

  Widget _buildNavBar() {
    return navBar ?? Container();
  }

  Positioned _buildBgGradientFundo() {
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      height: screenHeight,
      child: Container(
        height: screenHeight,
        decoration: gradientColorFundo,
      ),
    );
  }

  Positioned _buildBloco(BuildContext context) {
    return Positioned(
      top: 85.0, // 85
      left: 10.0, // 20
      right: 10.0, // 20
      bottom: MediaQuery.of(context).viewInsets.bottom > 0.0 && enableScroll ? 0.0 : 10.0, // 50
      child: Container(
        decoration: BoxDecoration(
          color: this.colorBloco,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
            bottom: Radius.circular(
              MediaQuery.of(context).viewInsets.bottom > 0.0 && enableScroll ? 0.0 : 20.0,
            ),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Stack(
            children: <Widget>[widget],
          ),
        ),
      ),
    );
  }


  double screenHeight;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        _buildBgGradientFundo(),
        _buildNavBar(),
        _buildBloco(context)
      ],
    );
  }
}
