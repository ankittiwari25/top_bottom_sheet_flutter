library top_bottom_sheet_flutter;

/// Top Bottom Sheet
import 'dart:async';

import 'package:flutter/material.dart';

class TopModalSheet extends StatefulWidget {
  final Color closeButtonBackgroundColor;
  final Color? backgroundColor;
  final Widget? closeButtonIcon;
  final double closeButtonRadius;
  final bool isShowCloseButton;
  final Widget child;

  const TopModalSheet(
      {Key? key,
      required this.child,
      this.closeButtonBackgroundColor = Colors.white,
      this.backgroundColor,
      this.closeButtonIcon,
      this.closeButtonRadius = 20.0,
      this.isShowCloseButton = false})
      : super(key: key);

  @override
  _TopModalSheetState createState() => _TopModalSheetState();

  static show(
      {required BuildContext context,
      @required child,
      closeButtonIcon,
      closeButtonRadius,
      isShowCloseButton,
      closeButtonBackgroundColor}) {
    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (_, __, ___) {
              return TopModalSheet(
                child: child,
                closeButtonBackgroundColor: closeButtonBackgroundColor ?? Colors.white,
                closeButtonIcon: closeButtonIcon,
                closeButtonRadius: double.parse(closeButtonRadius.toString()),
                isShowCloseButton: isShowCloseButton,
              );
            },
            opaque: false));
  }
}

class _TopModalSheetState extends State<TopModalSheet> with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  final GlobalKey _childKey = GlobalKey();

  dynamic get _childHeight {
    final renderBox = _childKey.currentContext!.findRenderObject() as RenderBox;
    return renderBox.size.height;
  }

  bool get _dismissUnderway => _animationController.status == AnimationStatus.reverse;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));

    _animation = Tween<double>(begin: _isDirectionTop() ? -1 : 1, end: 0).animate(_animationController);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) Navigator.pop(context);
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (_dismissUnderway) return;

    var change = details.primaryDelta! / (_childHeight ?? details.primaryDelta!);
    if (_isDirectionTop()) {
      _animationController.value += change;
    } else {
      _animationController.value -= change;
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_dismissUnderway) return;

    if (details.velocity.pixelsPerSecond.dy > 0 && _isDirectionTop()) return;
    if (details.velocity.pixelsPerSecond.dy < 0 && !_isDirectionTop()) return;

    if (details.velocity.pixelsPerSecond.dy > 700) {
      final double flingVelocity = -details.velocity.pixelsPerSecond.dy / _childHeight;
      if (_animationController.value > 0.0) {
        _animationController.fling(velocity: flingVelocity);
      }
    } else if (_animationController.value < 0.5) {
      if (_animationController.value > 0.0) {
        _animationController.fling(velocity: -1.0);
      }
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: onBackPressed,
        child: GestureDetector(
          onVerticalDragUpdate: _handleDragUpdate,
          onVerticalDragEnd: _handleDragEnd,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: widget.backgroundColor ?? Colors.black38,
              body: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      key: _childKey,
                      children: <Widget>[
                        AnimatedBuilder(
                            animation: _animation,
                            builder: (context, _) {
                              return Transform(
                                transform: Matrix4.translationValues(0.0, width * _animation.value, 0.0),
                                child: SizedBox(
                                  width: width,
                                  child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {},
                                      child: SizedBox(child: widget.child)),
                                ),
                              );
                            }),
                        const SizedBox(height: kToolbarHeight),
                      ],
                    ),
                  ),
                  if (_isDirectionTop())
                    Visibility(
                      visible: widget.isShowCloseButton,
                      child: Positioned(
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () => _animationController.reverse(),
                          child: Container(
                              height: kToolbarHeight,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.transparent,
                              child: Center(child: closeButtonIcon())),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
          excludeFromSemantics: true,
        ));
  }

  Widget? closeButtonIcon() {
    if (widget.closeButtonIcon == null) {
      return CircleAvatar(
        radius: double.parse(widget.closeButtonRadius.toString()),
        backgroundColor: widget.closeButtonBackgroundColor,
        child: const Icon(Icons.close),
      );
    }
    return widget.closeButtonIcon;
  }

  bool _isDirectionTop() {
    return true;
  }

  Future<bool> onBackPressed() {
    _animationController.reverse();
    return Future<bool>.value(false);
  }
}

enum TopModalSheetDirection { top, bottom }
