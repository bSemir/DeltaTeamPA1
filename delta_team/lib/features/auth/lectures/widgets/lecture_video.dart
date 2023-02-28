import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class LectureVideo extends StatefulWidget {
  final String contentLink;
  const LectureVideo({super.key, required this.contentLink});

  @override
  State<LectureVideo> createState() => _LectureVideoState();
}

class _LectureVideoState extends State<LectureVideo> {
  late final _controller = YoutubePlayerController.fromVideoId(
    videoId: widget.contentLink.substring(widget.contentLink.indexOf('=') + 1),
    params: const YoutubePlayerParams(),
  );

  @override
  void dispose() {
    _controller.duration;
    super.dispose();
  }

  // final _controller = YoutubePlayerController.fromVideoId(
  //   videoId: '2_uX7GxPzDI',
  //   autoPlay: false,
  //   params: const YoutubePlayerParams(showFullscreenButton: true),
  // );
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
          border: Border.all(width: 1.5)),
      height: 200.0,
      width: double.infinity,
      child: YoutubePlayer(
        aspectRatio: 16 / 9,
        controller: _controller,
      ),
    );
  }
}
