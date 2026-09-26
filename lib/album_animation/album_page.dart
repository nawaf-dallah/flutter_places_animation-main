import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation/album_animation/data.dart';
import 'package:flutter_animation/core/responsive.dart';

const _maxHeightArtistName = kToolbarHeight * 1.6;
const _minHeightArtistName = kToolbarHeight / 1.5;

const _maxHeightAlbumName = kToolbarHeight;
const _minHeightAlbumName = kToolbarHeight / 3;

const _maxFontSize = 30.0;
const _minFontSize = 16.0;

class AlbumPage extends StatefulWidget {
  const AlbumPage({super.key});

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  @override
  Widget build(BuildContext context) {
    final isTaplet = Responsive.isTablet(context);
    return SafeArea(
      maintainBottomViewPadding: true,
      child: CupertinoPageScaffold(
        child: CustomScrollView(
          slivers: [
            // The header of the page,
            // it is pinned and have a custom animation
            SliverPersistentHeader(
              pinned: true,
              delegate: _Mydelegate(
                maxExtent: MediaQuery.sizeOf(context).height * 0.55,
                minExtent:
                    isTaplet ? kToolbarHeight * 2.0 : kToolbarHeight * 1.5,
                builder: (percent) => _AnimatedHeader(percent),
              ),
            ),
            // The content of the page, it is a list of text,
            // you can replace it with any widget you want
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => SizedBox(
                  child: Material(
                    child: Text(AlbumModel.currentAlbum.description),
                  ),
                ),
                childCount: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedHeader extends StatelessWidget {
  const _AnimatedHeader(this.percent);

  final double percent;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.grey[350]!,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _DeskImage(percent: percent),
          _AlbumImage(percent: percent),
          _AlbumName(percent: percent),
          _ArtistName(percent: percent),
        ],
      ),
    );
  }
}

class _ArtistName extends StatelessWidget {
  const _ArtistName({required this.percent});

  final double percent;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final animation = (percent / 0.8).clamp(0.0, 1.0);
    return PositionedDirectional(
      top: lerpDouble(_maxHeightArtistName, _minHeightArtistName, percent),
      start: lerpDouble(
        size.width / 2.0 - (size.width * 0.6) / 2.0,
        size.width / 2.0 - (size.width * 0.6) / 2.0 + 25.0,
        animation,
      ),
      width: size.width * 0.6,
      child: Material(
        type: MaterialType.transparency,
        child: Text(
          AlbumModel.currentAlbum.albumArtist,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: lerpDouble(_maxFontSize, _minFontSize, percent),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _AlbumName extends StatelessWidget {
  const _AlbumName({required this.percent});

  final double percent;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final animation = (percent / 0.8).clamp(0.0, 1.0);
    return PositionedDirectional(
      top: lerpDouble(_maxHeightAlbumName, _minHeightAlbumName, percent),
      start: lerpDouble(
        size.width / 2.0 - (size.width * 0.65) / 2.0,
        size.width / 2.0 - (size.width * 0.7) / 2.0 + 25.0,
        animation,
      ),
      width: size.width * 0.7,
      child: Material(
        type: MaterialType.transparency,
        child: Text(
          AlbumModel.currentAlbum.albumName,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: lerpDouble(_maxFontSize, _minFontSize, percent),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _AlbumImage extends StatelessWidget {
  const _AlbumImage({required this.percent});

  final double percent;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final animation = (percent / 0.8).clamp(0.0, 1.0);
    final isTaplet = Responsive.isTablet(context);
    return PositionedDirectional(
      top: lerpDouble(size.height * 0.22, kToolbarHeight / 4.0, animation),
      start: size.width * 0.05,
      width: isTaplet
          ? lerpDouble(size.width * 0.4, size.width * 0.1, animation)
          : lerpDouble(size.width * 0.5, size.width * 0.15, animation),
      child: Image.asset(
        AlbumModel.currentAlbum.imageAlbum,
      ),
    );
  }
}

class _DeskImage extends StatelessWidget {
  const _DeskImage({required this.percent});

  final double percent;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final animation = (percent / 0.8).clamp(0.0, 1.0);
    final isTaplet = Responsive.isTablet(context);
    return PositionedDirectional(
      top: lerpDouble(size.height * 0.22, kToolbarHeight / 4.0, animation),
      start: lerpDouble(isTaplet ? size.width * 0.4 : size.width * 0.45,
          size.width * 0.05, animation),
      width: isTaplet
          ? lerpDouble(size.width * 0.4, size.width * 0.1, animation)
          : lerpDouble(size.width * 0.5, size.width * 0.15, animation),
      child: RotationTransition(
        turns: AlwaysStoppedAnimation(1 - percent),
        child: Image.asset(
          AlbumModel.currentAlbum.imageDisk,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _Mydelegate extends SliverPersistentHeaderDelegate {
  const _Mydelegate({
    required double maxExtent,
    required double minExtent,
    required Widget Function(double percent) builder,
  })  : _maxExtent = maxExtent,
        _minExtent = minExtent,
        _builder = builder;

  final double _maxExtent;
  final double _minExtent;
  final Widget Function(double percent) _builder;

  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      _builder(shrinkOffset / _maxExtent);

  @override
  double get maxExtent => _maxExtent;

  @override
  double get minExtent => _minExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
