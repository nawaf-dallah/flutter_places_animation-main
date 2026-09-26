import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class LiquidRefresh extends StatelessWidget {
  const LiquidRefresh({super.key});

  Future<void> _refreshindicator() async =>
      await Future.delayed(const Duration(seconds: 3));

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.green[300],
      child: LiquidPullToRefresh(
        onRefresh: _refreshindicator,
        color: Colors.green,
        backgroundColor: Colors.green[300],
        height: 300,
        child: ListView.builder(
          itemCount: 6,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(15.0),
              ),
              height: 300,
            );
          },
        ),
      ),
    );
  }
}
