import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../manger/radio_cubit/radio_cubit.dart';
class CustomProgressPar extends StatelessWidget {
  const CustomProgressPar({super.key, required this.isCurrentSura, required this.isPlaying});
final bool isCurrentSura, isPlaying;
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<Duration>(
      stream: context
          .read<RadioCubit>()
          .radioRepo
          .player
          .positionStream,
      builder: (context, snapshot) {
        var position = snapshot.data ?? Duration.zero;
        final total =
            context
                .read<RadioCubit>()
                .radioRepo
                .player
                .duration ??
                Duration.zero;
        return isCurrentSura && isPlaying
            ? Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: ProgressBar(
            thumbColor: Colors.blue,
            baseBarColor: Colors.grey,
            thumbGlowColor: Colors.grey,
            progress: position,
            total: total,
            onSeek: (duration) => context
                .read<RadioCubit>()
                .radioRepo
                .player
                .seek(duration),
            progressBarColor: Colors.black,
          ),
        )
            : Container(height: 0);
      },
    );
  }
}
