import 'package:flutter/material.dart';
import 'package:mixin_app_sample/models/VideoPlayerPause.dart';
import 'package:video_player/video_player.dart';

import 'package:mixin_app_sample/models/VideoPlayerBase.dart';
import 'package:mixin_app_sample/models/VideoPlayerPlayback.dart';

class MainVideoPlayer extends StatefulWidget {
  @override
  _MainVideoPlayerState createState() => _MainVideoPlayerState();
}

class _MainVideoPlayerState extends VideoPlayerBase<MainVideoPlayer>
    with
        VideoPlayerPlayback<MainVideoPlayer>,
        VideoPlayerPause<MainVideoPlayer> {
  @override
  void pause(VideoPlayerController controller) {
    controller.pause();
  }

  @override
  void play(VideoPlayerController controller) {
    controller.play();
  }

  @override
  Future<void> setPlaybackSpeed(
      VideoPlayerController controller, double speed) async {
    if (speed < 0) {
      throw ArgumentError.value(
        speed,
        'Negative playback speeds are generally unsupported.',
      );
    } else if (speed == 0) {
      throw ArgumentError.value(
        speed,
        'Zero playback speed is generally unsupported. Consider using [pause].',
      );
    }

    await controller.setPlaybackSpeed(speed);
  }

  void onPlayButtonPressed() {
    setState(() {
      controller!.value.isPlaying ? onPause(controller!) : onPlay(controller);
    });
  }

  @override
  Widget build(BuildContext context) {
    var buttonIcon = Icon(
      controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
    );
    var mainVideo = controller!.value.isInitialized
        ? Column(
            children: [
              AspectRatio(
                aspectRatio: controller!.value.aspectRatio,
                child: VideoPlayer(controller!),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      onSetPlaybackSpeed(controller, 1);
                    },
                    icon: Icon(
                      Icons.keyboard_arrow_left,
                      size: 50,
                      color: Colors.blue[300],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      onSetPlaybackSpeed(controller, 2);
                    },
                    icon: Icon(
                      Icons.keyboard_arrow_right,
                      size: 50,
                      color: Colors.blue[300],
                    ),
                  ),
                ],
              )
            ],
          )
        : Container();

    return Scaffold(
      appBar: AppBar(
        title: Text('Mixin Sample'),
      ),
      body: Center(
        child: mainVideo,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onPlayButtonPressed,
        child: buttonIcon,
      ),
    );
  }
}
