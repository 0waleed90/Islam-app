import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/constants.dart';
import '../../../../../../../core/util/styles.dart';
import '../../../../manger/radio_cubit/radio_cubit.dart';
import '../../../../manger/radio_cubit/radio_state.dart';

class FavoriteListViewItem extends StatelessWidget {
  const FavoriteListViewItem({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: kPrimaryColor,
        ),
        child: Column(
          children: [
            SizedBox(height: 10),
            Text(
              context.read<RadioCubit>().favorite[index].suraName,
              style: Styles.textStyle20.copyWith(color: Colors.black),
            ),

            Text(
              context.read<RadioCubit>().favorite[index].qareeName,
              style: Styles.textStyle16.copyWith(color: Colors.black),
            ),

            Stack(
              children: [
                Image.asset(
                  'assets/photos/bottom_quran_details.png',
                  color: Colors.black,
                ),

                Positioned.fill(
                  child: BlocBuilder<RadioCubit, RadioState>(
                    builder: (context, state) {
                      bool isCurrentSura =
                          state is RadioSuccess && state.currentSura == index;
                      bool isBuffering =
                          state is RadioSuccess && state.isBuffering;
                      bool isPlaying = state is RadioSuccess && state.isPlaying;

                      return Column(
                        mainAxisAlignment: .spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: .center,

                            children: [
                              IconButton(
                                onPressed: () {
                                  context.read<RadioCubit>().removeFromFavorite(
                                    context
                                        .read<RadioCubit>()
                                        .favorite[index]
                                        .suraName,
                                    context
                                        .read<RadioCubit>()
                                        .favorite[index]
                                        .qareeName,
                                  );
                                },
                                icon: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 33,
                                ),
                              ),

                              IconButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(
                                    context,
                                  ).hideCurrentSnackBar();
                                  if (isPlaying && isCurrentSura) {
                                    context.read<RadioCubit>().pauseRadio();
                                  } else if (!isBuffering) {
                                    context.read<RadioCubit>().playSura(index);
                                  }
                                },
                                icon: isCurrentSura && isBuffering
                                    ? CircularProgressIndicator(
                                        color: Colors.black,
                                      )
                                    : isCurrentSura && isPlaying
                                    ? Icon(
                                        Icons.pause,
                                        size: 33,
                                        color: Colors.black,
                                      )
                                    : Icon(
                                        Icons.play_arrow,
                                        size: 33,
                                        color: Colors.black,
                                      ),
                              ),

                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.volume_up_sharp,
                                  color: Colors.black,
                                  size: 33,
                                ),
                              ),
                            ],
                          ),

                          StreamBuilder<Duration>(
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
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
