import 'package:flutter/material.dart';
import 'package:flutter_animation/core/responsive.dart';

class FirstLatter extends AnimatedWidget {
  const FirstLatter({super.key, required Animation<double> animation})
      : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    final size = MediaQuery.of(context).size;
    final isSmallMobile = Responsive.isSmallMobile(context);
    final isTablet = Responsive.isTablet(context);
    return Positioned(
      top: (isSmallMobile
              ? size.height * 0.05
              : isTablet
                  ? 0.0
                  : size.height * 0.05) +
          (size.height * 0.05) * animation.value,
      left: size.width * 0.28,
      child: FadeTransition(
        opacity: animation,
        child: Text(
          "n",
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: size.width * 0.2,
                fontWeight: FontWeight.w800,
              ),
        ),
      ),
    );
  }
}

class SecondLetter extends AnimatedWidget {
  const SecondLetter({super.key, required Animation<double> animation})
      : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    final size = MediaQuery.of(context).size;
    final isSmallMobile = Responsive.isSmallMobile(context);
    final isTablet = Responsive.isTablet(context);
    return Positioned(
      top: (isSmallMobile
              ? size.height * 0.05
              : isTablet
                  ? 0.0
                  : size.height * 0.05) +
          (size.height * 0.05) * animation.value,
      left: size.width * 0.28 + size.width * 0.12,
      child: FadeTransition(
        opacity: animation,
        child: Text(
          "a",
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: size.width * 0.2,
                fontWeight: FontWeight.w800,
              ),
        ),
      ),
    );
  }
}

class ThirdLatter extends AnimatedWidget {
  const ThirdLatter({super.key, required Animation<double> animation})
      : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    final size = MediaQuery.of(context).size;
    final isSmallMobile = Responsive.isSmallMobile(context);
    final isTablet = Responsive.isTablet(context);
    return Positioned(
      top: (isSmallMobile
              ? size.height * 0.05
              : isTablet
                  ? 0.0
                  : size.height * 0.05) +
          (size.height * 0.05) * animation.value,
      left: size.width * 0.28 + size.width * 0.12 * 2.0,
      child: FadeTransition(
        opacity: animation,
        child: Text(
          "n",
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: size.width * 0.2,
                fontWeight: FontWeight.w800,
              ),
        ),
      ),
    );
  }
}

class FoarthLatter extends AnimatedWidget {
  const FoarthLatter({super.key, required Animation<double> animation})
      : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    final size = MediaQuery.of(context).size;
    final isSmallMobile = Responsive.isSmallMobile(context);
    final isTablet = Responsive.isTablet(context);
    return Positioned(
      top: (isSmallMobile
              ? size.height * 0.05
              : isTablet
                  ? 0.0
                  : size.height * 0.05) +
          (size.height * 0.05) * animation.value,
      left: size.width * 0.28 + size.width * 0.12 * 3.0,
      child: FadeTransition(
        opacity: animation,
        child: Text(
          "a",
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              fontSize: size.width * 0.2, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
