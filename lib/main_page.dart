import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation/pull_to_refresh/custom_refresh_indecator.dart';

import 'album_anaimation/album_details.dart';
import 'album_animation/album_page.dart';
import 'animal_animation/main_page_animal_app.dart';
import 'coffee_animation/coffee_home.dart';
import 'pull_to_refresh/liquid_refresh.dart';
import 'nana_splach_screen/nana_splach.dart';
import 'nana_splach_screen/nana_splach2.dart';
import 'nana_splach_screen/nana_splach_3.dart';
import 'nana_splach_screen/nana_splach_lottie.dart';
import 'travel_app_animation/home_feed.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[600],
        title: const Text("main page"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: ListView(
            children: [
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const CustomRefreshAnimation(),
                  ),
                ),
                child: const _MyButton('custom refresh'),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const LiquidRefresh(),
                  ),
                ),
                child: const _MyButton('Liquid refresh'),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const MyHomePage(),
                  ),
                ),
                child: const _MyButton('Travil place'),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const AlbumPage(),
                  ),
                ),
                child: const _MyButton('Album app'),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const MainPageAnimal(),
                    )),
                child: const _MyButton('Animal app'),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const MainPageCoffee(),
                  ),
                ),
                child: const _MyButton('Coffee app'),
              ),
              GestureDetector(
                onTap: () => Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const SplachScreen(),
                    )),
                child: const _MyButton('nana splach'),
              ),
              GestureDetector(
                onTap: () => Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const SplachScreen2(),
                    )),
                child: const _MyButton('nana splach 2'),
              ),
              GestureDetector(
                onTap: () => Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const SplachScreenLottie(),
                    )),
                child: const _MyButton('splach Lottie'),
              ),
              GestureDetector(
                onTap: () => Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const SplachScreen3(),
                    )),
                child: const _MyButton('splach none'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MyButton extends StatelessWidget {
  const _MyButton(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(bottom: 20.0, right: 30.0, left: 30.0),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(color: Colors.deepPurple[200]),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 24,
        ),
      ),
    );
  }
}
