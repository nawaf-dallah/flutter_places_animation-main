import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animation/core/responsive.dart';
import 'package:gif/gif.dart';

import '../main_page.dart';

const _duration = Duration(milliseconds: 2000);

class SplachScreen3 extends StatefulWidget {
  const SplachScreen3({super.key});

  @override
  State<SplachScreen3> createState() => _SplachScreen3State();
}

class _SplachScreen3State extends State<SplachScreen3>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeLogoTransition;
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
        curve: const Interval(0.5, 0.9, curve: ElasticOutCurve(0.8)));
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    _gifController.dispose();
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
          _Camel(gifController: _gifController),
          // nana loge at the top
          _Logo(animation: _fadeLogoTransition),
        ],
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
  const _Camel({required GifController gifController})
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
