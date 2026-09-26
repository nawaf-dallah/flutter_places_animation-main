import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:snap_scroll_physics/snap_scroll_physics.dart';

import '../core/responsive.dart';
import 'data/album_model.dart';
import 'widget/animated_header_album.dart';

const _maxHeightImageAlbum = 160.0;
const _minHeightImageAlbum = 60;

const _maxHeightImageAlbumTablet = 220.0;
const _minHeightImageAlbumTablet = 60;

const _maxArtistName = 30.0;
const _minArtistName = 18.0;

const _maxArtistNameTablet = 42.0;
const _minArtistNameTablet = 24.0;

const _maxAlbumName = 18.0;
const _minAlbumName = 12.0;

const _maxAlbumNameTablet = 24.0;
const _minAlbumNameTablet = 16.0;

class AlbumDetails extends StatelessWidget {
  const AlbumDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: SnapScrollPhysics.preventStopBetween(
          kToolbarHeight,
          size.height * 0.3,
        ),
        slivers: [
          SliverPersistentHeader(
            delegate: AlbumDeleaget(
              maxExtent: size.height * 0.5,
              minExtent: kToolbarHeight * 2.0,
              builder: (percent) {
                final imagePercent = lerpDouble(
                  _minHeightImageAlbum,
                  _maxHeightImageAlbum,
                  1 - percent,
                );
                final artistNamePercent = lerpDouble(
                  _minArtistName,
                  _maxArtistName,
                  1 - percent,
                );
                final albumNamePercent = lerpDouble(
                  _minAlbumName,
                  _maxAlbumName,
                  1 - percent,
                );
                final imageTabletPercent = lerpDouble(
                  _minHeightImageAlbumTablet,
                  _maxHeightImageAlbumTablet,
                  1 - percent,
                );
                final artistNamePercentTablet = lerpDouble(
                  _minArtistNameTablet,
                  _maxArtistNameTablet,
                  1 - percent,
                );
                final albumNamePercentTablet = lerpDouble(
                  _minAlbumNameTablet,
                  _maxAlbumNameTablet,
                  1 - percent,
                );
                return AnimatedHeaderAlbum(
                  imagePercent: imagePercent!,
                  size: size,
                  artistNamePercent: artistNamePercent!,
                  albumNamePercent: albumNamePercent!,
                  percent: percent,
                  imageTabletPercent: imageTabletPercent!,
                  artistNamePercentTablet: artistNamePercentTablet!,
                  albumNamePercentTablet: albumNamePercentTablet!,
                );
              },
            ),
            pinned: true,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              child: Text(
                AlbumModel.currentAlbum.description,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  wordSpacing: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AlbumDeleaget extends SliverPersistentHeaderDelegate {
  final double _maxExtent;
  final double _minExtent;
  final Widget Function(double percent) builder;

  AlbumDeleaget({
    required double maxExtent,
    required double minExtent,
    required this.builder,
  })  : _maxExtent = maxExtent,
        _minExtent = minExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return builder(shrinkOffset / _maxExtent);
  }

  @override
  double get maxExtent => _maxExtent;

  @override
  double get minExtent => _minExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
