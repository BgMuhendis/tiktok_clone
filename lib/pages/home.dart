import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tiktok/constant/data.dart';
import 'package:tiktok/pages/cameraPage.dart';
import 'package:tiktok/theme/color.dart';
import 'package:tiktok/widgets/icon_widgets.dart';
import 'package:tiktok/widgets/tiktok.dart';
import 'package:video_player/video_player.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: items.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return RotatedBox(
      quarterTurns: 1,
      child: TabBarView(
        controller: _tabController,
        children: List.generate(items.length, (index) {
          return RotatedBox(
            quarterTurns: -1,
            child: VideoPlayerItem(
              size: size,
              name: items[index]["name"],
              caption: items[index]["caption"],
              songName: items[index]["songName"],
              profileImg: items[index]["profileImg"],
              likes: items[index]["likes"],
              comments: items[index]["comments"],
              shares: items[index]["shares"],
              albumImg: items[index]["albumImg"],
              videoUrl: items[index]["videoUrl"],
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return getBody();
  }
}

class VideoPlayerItem extends StatefulWidget {
  final String name;
  final String caption;
  final String songName;
  final String profileImg;
  final String likes;
  final String comments;
  final String shares;
  final String albumImg;
  final String videoUrl;
  const VideoPlayerItem({
    Key key,
    @required this.size,
    this.name,
    this.caption,
    this.songName,
    this.profileImg,
    this.likes,
    this.comments,
    this.shares,
    this.albumImg,
    this.videoUrl,
  }) : super(key: key);

  final Size size;

  @override
  _VideoPlayerItemState createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem>
    with SingleTickerProviderStateMixin {
  VideoPlayerController _videoController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoController = VideoPlayerController.asset(widget.videoUrl)
      ..initialize().then((value) {
        _videoController.play();
      });
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _videoController.value.isPlaying
              ? _videoController.pause()
              : _videoController.play();
        });
      },
      child: Container(
          width: widget.size.width,
          height: widget.size.height,
          child: Stack(
            children: [
              Container(
                width: widget.size.width,
                height: widget.size.height,
                child: VideoPlayer(_videoController),
              ),
              Container(
                width: widget.size.width,
                height: widget.size.height,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 25,
                      right: 20,
                      left: 20,
                    ),
                    child: Column(
                      children: [
                        Flexible(
                          child: Row(
                            children: [
                              LettPanel(
                                size: widget.size,
                                name: widget.name,
                                caption: widget.caption,
                                songName: widget.songName,
                              ),
                              RightPanel(
                                size: widget.size,
                                profileImg: widget.profileImg,
                                likes: widget.likes,
                                comments: widget.comments,
                                shares: widget.shares,
                                albumImg: widget.albumImg,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}

class RightPanel extends StatelessWidget {
  final String profileImg;
  final String likes;
  final String comments;
  final String shares;
  final String albumImg;
  const RightPanel({
    Key key,
    @required this.size,
    this.profileImg,
    this.likes,
    this.comments,
    this.shares,
    this.albumImg,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: size.height * 0.1,
            ),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    getIcon(TikTokIcons.heart, 35.0, likes),
                    SizedBox(height: 40),
                    // getIcon(Icon(Icons.camera), 35.0, comments),
                    getIcon(TikTokIcons.reply, 25.0, shares),
                    SizedBox(height: 10),

                    // getAlbum(albumImg),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LettPanel extends StatelessWidget {
  final String name;
  final String caption;
  final String songName;
  const LettPanel({
    Key key,
    @required this.size,
    this.name,
    this.caption,
    this.songName,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: size.width * 0.78,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            name,
            style: TextStyle(color: white),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            caption,
            style: TextStyle(color: white),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
