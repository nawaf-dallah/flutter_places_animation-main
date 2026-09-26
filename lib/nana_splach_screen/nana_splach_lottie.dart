import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animation/core/responsive.dart';
import 'package:lottie/lottie.dart';

import '../main_page.dart';

const _containerSize = 300.0;
const _duration = Duration(milliseconds: 3000);

class SplachScreenLottie extends StatefulWidget {
  const SplachScreenLottie({super.key});

  @override
  State<SplachScreenLottie> createState() => _SplachScreenLottieState();
}

class _SplachScreenLottieState extends State<SplachScreenLottie>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeLogoTransition;
  late final Animation<double> _circleContainerTransition;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: _duration)
      ..forward().then((_) => Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, animation, ___) => const MainPage(),
            transitionsBuilder: (_, animation, __, child) => FadeTransition(
              opacity: animation,
              child: child,
            ),
          )));
    _fadeLogoTransition = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.5, 0.9, curve: ElasticOutCurve(0.8)),
    );
    _circleContainerTransition = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.75, 1.0),
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(233, 233, 233, 1.0),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // nana camel image
          const _Camel(),
          // nana loge at the top
          _Logo(animation: _fadeLogoTransition),
          // the animated circle container at the end of the animation
          _CircleContainer(animation: _circleContainerTransition)
        ],
      ),
    );
  }
}

class _CircleContainer extends AnimatedWidget {
  const _CircleContainer({required Animation<double> animation})
      : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    final size = MediaQuery.of(context).size;
    final value = (animation.value / 0.5).clamp(0.0, 1.0);
    final isTablet = Responsive.isTablet(context);
    return Positioned(
      top: -size.height * 0.5,
      left: size.width / 2 - _containerSize / 2,
      child: Transform.scale(
        scale: isTablet ? 15.0 * value : 9.0 * value,
        child: Container(
          width: _containerSize,
          height: _containerSize,
          transformAlignment: Alignment.center,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [
                  0.4,
                  0.8,
                  1.0
                ],
                colors: [
                  Color.fromRGBO(124, 172, 112, 1.0),
                  Color.fromRGBO(54, 97, 51, 1.0),
                  Color.fromRGBO(44, 63, 34, 1.0),
                ]),
          ),
        ),
      ),
    );
  }
}

class _Logo extends AnimatedWidget {
  const _Logo({required Animation<double> animation})
      : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    final size = MediaQuery.of(context).size;
    final isTablet = Responsive.isTablet(context);
    return Positioned(
      top: isTablet ? size.height * 0.1 : size.height * 0.15,
      right: isTablet ? size.width * 0.3 : size.width * 0.25,
      left: isTablet ? size.width * 0.3 : size.width * 0.25,
      child: ScaleTransition(
        scale: animation,
        child: FadeTransition(
          opacity: animation,
          child: Image.asset(
            'assets/images/nana_images/logo.png',
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Text('Image not found');
            },
          ),
        ),
      ),
    );
  }
}

class _Camel extends StatelessWidget {
  const _Camel();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned(
      bottom: 0.0,
      right: size.width * 0.1,
      left: size.width * 0.15,
      height: size.height * 0.65,
      child: Lottie.asset(
        'assets/images/nana_images/camel.json',
        repeat: false,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return const Text('Image not found');
        },
      ),
    );
  }
}
