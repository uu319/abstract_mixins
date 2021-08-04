import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

abstract class PlaybackFunctions {
  void pause(VideoPlayerController controller);
}

mixin VideoPlayerPauseMixin<T extends StatefulWidget> on State<T>
    implements PlaybackFunctions {
  void onPause(VideoPlayerController? controller) {
    if (controller!.value.isInitialized) {
      pause(controller);
    }
  }
}
