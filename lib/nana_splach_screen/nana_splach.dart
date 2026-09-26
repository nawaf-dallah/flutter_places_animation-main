import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animation/core/responsive.dart';
import 'package:gif/gif.dart';

import '../main_page.dart';
import 'widget/latters.dart';

const _containerSize = 300.0;
const _duration = Duration(milliseconds: 3000);

class SplachScreen extends StatefulWidget {
  const SplachScreen({super.key});

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeLogoTransition;
  late final Animation<double> _fadeFirstTransition;
  late final Animation<double> _fadeSecondTransition;
  late final Animation<double> _fadeThirdTransition;
  late final Animation<double> _fadeFoarthTransition;
  late final Animation<double> _circleContainerTransition;
  late final GifController _gifController;

  @override
  void initState() {
    _gifController = GifController(vsync: this);
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
        curve: const Interval(0.5, 0.7, curve: ElasticOutCurve(0.8)));
    _fadeFirstTransition = CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.3, curve: ElasticOutCurve(0.8)));
    _fadeSecondTransition = CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.25, 0.4, curve: ElasticOutCurve(0.8)));
    _fadeThirdTransition = CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.35, 0.5, curve: ElasticOutCurve(0.8)));
    _fadeFoarthTransition = CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.45, 0.6, curve: ElasticOutCurve(0.8)));
    _circleContainerTransition =
        CurvedAnimation(parent: _controller, curve: const Interval(0.75, 1.0));
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(233, 233, 233, 1.0),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Camel(gifController: _gifController),
          Logo(animation: _fadeLogoTransition),
          FirstLatter(animation: _fadeFirstTransition),
          SecondLetter(animation: _fadeSecondTransition),
          ThirdLatter(animation: _fadeThirdTransition),
          FoarthLatter(animation: _fadeFoarthTransition),
          CircleContainer(animation: _circleContainerTransition)
        ],
      ),
    );
  }
}

class CircleContainer extends AnimatedWidget {
  const CircleContainer({
    super.key,
    required Animation<double> animation,
  }) : super(listenable: animation);

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

class Logo extends AnimatedWidget {
  const Logo({super.key, required Animation<double> animation})
      : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    final size = MediaQuery.of(context).size;
    return Positioned(
      top: size.height * 0.21 + kToolbarHeight * (1 - animation.value),
      right: size.width * 0.25,
      left: size.width * 0.25,
      child: FadeTransition(
        opacity: animation,
        child: Image.asset(
          'assets/images/nana_images/logo_ar.png',
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Text('Image not found');
          },
        ),
      ),
    );
  }
}

class Camel extends StatelessWidget {
  const Camel({super.key, required GifController gifController})
      : _gifController = gifController;

  final GifController _gifController;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned(
      bottom: 0.0,
      right: size.width * 0.1,
      left: size.width * 0.15,
      height: size.height * 0.65,
      child: Gif(
        controller: _gifController,
        image: const AssetImage('assets/images/nana_images/camel.gif'),
        fit: BoxFit.contain,
        fps: 30,
        autostart: Autostart.once,
      ),
    );
  }
}
