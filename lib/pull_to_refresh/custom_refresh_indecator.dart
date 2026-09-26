import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class CustomRefreshAnimation extends StatelessWidget {
  const CustomRefreshAnimation({super.key});

  Future<void> _hundleRefresh() async =>
      await Future.delayed(const Duration(seconds: 3));

  final double _offsetToArmed = 220.0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xffCFEFF8),
      child: CustomRefreshIndicator(
        offsetToArmed: _offsetToArmed,
        onRefresh: _hundleRefresh,
        child: const MyList(),
        builder: (context, child, controller) => AnimatedCustomRefresh(
          offsetToArmed: _offsetToArmed,
          controller: controller,
          child: child,
        ),
      ),
    );
  }
}

class AnimatedCustomRefresh extends StatelessWidget {
  const AnimatedCustomRefresh({
    super.key,
    required double offsetToArmed,
    required this.child,
    required this.controller,
  }) : _offsetToArmed = offsetToArmed;

  final double _offsetToArmed;
  final Widget child;
  final IndicatorController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        child: child,
        builder: (context, child) {
          return Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: controller.value * _offsetToArmed,
                child: const RiveAnimation.asset(
                  'assets/images/rive/raster_graphics_example.riv',
                  fit: BoxFit.cover,
                ),
              ),
              Transform.translate(
                offset: Offset(0.0, controller.value * _offsetToArmed),
                child: child,
              ),
            ],
          );
        });
  }
}

class MyList extends StatelessWidget {
  const MyList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 8,
      itemBuilder: (context, index) {
        return Container(
          height: 300,
          margin: const EdgeInsets.all(30.0),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10.0),
          ),
        );
      },
    );
  }
}
