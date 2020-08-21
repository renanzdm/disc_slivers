import 'package:disc_chellenge/album_model.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              delegate: MyDiscHeader(),
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(currentAlbum.description),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const _maxHeaderExtent = 350.0;
const _minHeaderExtent = 100.0;
const _maxImageSize = 160.0;
const _minImageSize = 60.0;
const _leftMargin = 150.0;
const _maxTitle = 25.0;
const _maxSubTitle = 18.0;
const _minTitle = 15.0;
const _minSubTitle = 12.0;

class MyDiscHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final percent = shrinkOffset / _maxHeaderExtent;
    final sizes = MediaQuery.of(context).size;
    final currentImageSize =
        (_maxImageSize * (1 - percent)).clamp(_minImageSize, _maxImageSize);
    final titleSize =
        (_maxTitle * (1 - percent)).clamp(_minTitle, _maxImageSize);
    final subTitleSize =
        (_maxSubTitle * (1 - percent)).clamp(_minSubTitle, _maxSubTitle);
    final maxMargin = sizes.width / 4;
    double movimentText = 30.0;
    double leftTextMargin = maxMargin + (movimentText * percent);
    print(percent);
    return Container(
      color: Color(0xFFECECEA),
      child: Stack(
        children: [
          Positioned(
            top: 50,
            left: leftTextMargin,
            child: Column(
              children: [
                Text(
                  currentAlbum.album,
                  style: TextStyle(
                      fontSize: titleSize, fontWeight: FontWeight.bold),
                ),
                Text(
                  currentAlbum.artist,
                  style: TextStyle(fontSize: subTitleSize, color: Colors.grey),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: (_leftMargin * (1 - percent)).clamp(50.0, _leftMargin),
            height: currentImageSize,
            child: Transform.rotate(
                angle: vector.radians(360 * percent),
                child: Image.asset(currentAlbum.imageDisc)),
          ),
          Positioned(
            bottom: 20,
            left: 35,
            height: currentImageSize,
            child: Image.asset(currentAlbum.imageAlbum),
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => _maxHeaderExtent;

  @override
  double get minExtent => _minHeaderExtent;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}
