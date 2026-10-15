import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islam/core/constants.dart';
import 'package:islam/core/util/styles.dart';
import 'package:islam/features/home/presentation/manger/radio_cubit/radio_state.dart';
import 'package:islam/features/home/presentation/view/widgets/radio_view/radio_action_button.dart';

import '../../../../data/models/radio_model/radio_model.dart';
import '../../../manger/radio_cubit/radio_cubit.dart';
import 'custom_progress_par.dart';

class RadioListViewItem extends StatelessWidget {
  const RadioListViewItem({
    super.key,
    required this.radioModel,
    required this.index,
  });
  final RadioModel radioModel;
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
              radioModel.suraName,
              style: Styles.textStyle20.copyWith(color: Colors.black),
            ),

            Text(
              context.read<RadioCubit>().nameQaree,
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
                      bool isFavorite =
                          state is RadioSuccess &&
                          state.favorites.any(
                            (element) =>
                                element.suraName == radioModel.suraName &&
                                element.qareeName ==
                                    context.read<RadioCubit>().nameQaree,
                          );
                      bool isCurrentSura =
                          state is RadioSuccess && state.currentSura == index;
                      bool isBuffering =
                          state is RadioSuccess && state.isBuffering;
                      bool isPlaying = state is RadioSuccess && state.isPlaying;

                      return Column(
                        mainAxisAlignment: .spaceAround,
                        children: [
                          RadioActionButton(
                            index: index,
                            isCurrentSura: isCurrentSura,
                            isPlaying: isPlaying,
                            isBuffering: isBuffering,
                            suraName: radioModel.suraName, isFavorite: isFavorite,
                          ),

                          CustomProgressPar(
                            isCurrentSura: isCurrentSura,
                            isPlaying: isPlaying,
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
