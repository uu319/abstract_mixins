import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

abstract class BaseFunctions {
  void play(VideoPlayerController controller);
}

abstract class VideoPlayerBase<T extends StatefulWidget> extends State<T>
    implements BaseFunctions {
  VideoPlayerController? controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  void onPlay(VideoPlayerController? controller) {
    if (controller!.value.isInitialized) {
      play(controller);
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller!.dispose();
  }
}
