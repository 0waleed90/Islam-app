import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../manger/radio_cubit/radio_cubit.dart';

class RadioActionButton extends StatelessWidget {
  const RadioActionButton({
    super.key,
    required this.index,
    required this.isCurrentSura,
    required this.isPlaying,
    required this.isBuffering,
    required this.suraName,
    required this.isFavorite,
  });
  final int index;
  final String suraName;
  final bool isCurrentSura, isPlaying, isBuffering, isFavorite;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .center,

      children: [
        IconButton(
          onPressed: () {
            !isFavorite
                ? context.read<RadioCubit>().addToFavorite(
                    suraName,
                    context.read<RadioCubit>().nameQaree,
                  )
                : context.read<RadioCubit>().removeFromFavorite(
                    suraName,
                    context.read<RadioCubit>().nameQaree,
                  );
          },
          icon: Icon(
            Icons.favorite,

            color: isFavorite ? Colors.red : Colors.black,
            size: 33,
          ),
        ),

        IconButton(
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            if (isPlaying && isCurrentSura) {
              context.read<RadioCubit>().pauseRadio();
            } else if (!isBuffering) {
              context.read<RadioCubit>().playSura(index);
            }
          },
          icon: isCurrentSura && isBuffering
              ? CircularProgressIndicator(color: Colors.black)
              : isCurrentSura && isPlaying
              ? Icon(Icons.pause, size: 33, color: Colors.black)
              : Icon(Icons.play_arrow, size: 33, color: Colors.black),
        ),

        IconButton(
          onPressed: () {},
          icon: Icon(Icons.volume_up_sharp, color: Colors.black, size: 33),
        ),
      ],
    );
  }
}
