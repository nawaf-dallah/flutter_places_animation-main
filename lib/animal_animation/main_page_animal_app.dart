import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/responsive.dart';
import 'vulture_page.dart';
import 'widget/camp_time_and_lapel.dart';
import 'widget/dots.dart';
import 'leopard_page.dart';
import 'styles.dart';
import 'dart:math' as math;

import 'widget/header.dart';

class MainPageAnimal extends StatefulWidget {
  const MainPageAnimal({super.key});

  @override
  State<MainPageAnimal> createState() => _MainPageAnimalState();
}

class _MainPageAnimalState extends State<MainPageAnimal>
    with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  late final ValueNotifier<double> _pageListener;
  late final AnimationController _animationController;

  @override
  void initState() {
    _pageController = PageController()..addListener(_listenToPage);
    _pageListener = ValueNotifier(0.0);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    super.initState();
  }

  _listenToPage() => _pageListener.value = _pageController.offset;

  @override
  void dispose() {
    _pageController
      ..removeListener(_listenToPage)
      ..dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    final animationHeight = MediaQuery.sizeOf(context).height / 2;
    if (_pageController.page != 1.0) {
      return;
    } else {
      _animationController.value -= details.primaryDelta! / animationHeight;
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    final animationHeight = MediaQuery.sizeOf(context).height / 2;
    if (_animationController.isAnimating ||
        _animationController.isCompleted ||
        _pageController.page != 1.0) {
      return;
    }

    final double flingVelocity =
        details.velocity.pixelsPerSecond.dy / animationHeight;
    if (flingVelocity < 0.0) {
      _animationController.fling(
          velocity: math.max(1.0, -flingVelocity),
          springDescription: const SpringDescription(
              mass: 1.0, stiffness: 500.0, damping: 50.0));
    } else if (flingVelocity > 0.0) {
      _animationController.fling(
          velocity: math.min(-1.0, -flingVelocity),
          springDescription: const SpringDescription(
              mass: 1.0, stiffness: 500.0, damping: 50.0));
    } else {
      _animationController.fling(
          velocity: _animationController.value < 0.5 ? -2.0 : 2.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBlack,
      body: GestureDetector(
        onVerticalDragUpdate: _handleDragUpdate,
        onVerticalDragEnd: _handleDragEnd,
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                final isAnimated = _animationController.isAnimating ||
                    _animationController.isCompleted;
                return AbsorbPointer(absorbing: isAnimated, child: child);
              },
              child: PageView(
                controller: _pageController,
                physics: const ClampingScrollPhysics(),
                children: [
                  LeopardPage(pageListener: _pageListener),
                  VulturePage(
                    pageListener: _pageListener,
                    animation: _animationController,
                  )
                ],
              ),
            ),
            The72Number(pageListener: _pageListener),
            LeopardImage(
              pageListener: _pageListener,
              animation: _animationController,
            ),
            VultureImage(
              pageListener: _pageListener,
              animation: _animationController,
            ),
            const Header(),
            _Footer(pageListener: _pageListener),
            BlurBox(animation: _animationController),
            Arrow(
              animation: _animationController,
              valueListener: _pageListener,
              animationController: _animationController,
            ),
            TravelDetails(
              pageListener: _pageListener,
              animation: _animationController,
            ),
            OnMapText(animation: _animationController),
            StartCampLabel(pageListener: _pageListener),
            BaseCampLabel(
              pageListener: _pageListener,
              animation: _animationController,
            ),
            StartCampTime(pageListener: _pageListener),
            BaseCampTime(
              pageListener: _pageListener,
              animation: _animationController,
            ),
            The72Km(pageListener: _pageListener),
            VirticleLine(animation: _animationController),
            AnimatedDot(
              pageListener: _pageListener,
              color: mainBlack,
              animationController: _animationController,
            ),
            AnimatedSmallDot(
              pageListener: _pageListener,
              isleft: true,
              animationController: _animationController,
            ),
            AnimatedSmallDot(
              pageListener: _pageListener,
              isleft: false,
              animationController: _animationController,
            ),
            AnimatedDot(
              pageListener: _pageListener,
              color: white,
              animationController: _animationController,
            ),
            VultureIconMainPage(animation: _animationController),
            LeopardIconMainPage(animation: _animationController),
          ],
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({required ValueNotifier pageListener})
      : _pageListener = pageListener;

  final ValueNotifier _pageListener;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isTablet = Responsive.isTablet(context);
    return Positioned(
      bottom: kBottomNavigationBarHeight / 1.5,
      right: isTablet ? 30.0 : 20.0,
      width: screenWidth / 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ValueListenableBuilder(
              valueListenable: _pageListener,
              builder: (_, value, child) {
                final percent = value / screenWidth;
                return Row(
                  children: [
                    const SizedBox(width: 10.0),
                    Icon(
                      CupertinoIcons.circle_fill,
                      color: percent != 1.0 ? white : lightGrey,
                      size: 8.0,
                    ),
                    const SizedBox(width: 6.0),
                    Icon(
                      CupertinoIcons.circle_fill,
                      color: percent == 1.0 ? white : lightGrey,
                      size: 8.0,
                    ),
                  ],
                );
              }),
          const Icon(Icons.share, color: white),
        ],
      ),
    );
  }
}
