import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

abstract class PlaybackFunctions {
  void setPlaybackSpeed(VideoPlayerController controller, double speed);
}

mixin VideoPlayerPlaybackMixin<T extends StatefulWidget> on State<T>
    implements PlaybackFunctions {
  void onSetPlaybackSpeed(VideoPlayerController? controller, double speed) {
    if (controller!.value.isInitialized) {
      setPlaybackSpeed(controller, speed);
    }
  }
}
