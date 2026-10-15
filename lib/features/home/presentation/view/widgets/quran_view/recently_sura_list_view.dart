import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islam/core/util/styles.dart';
import 'package:islam/features/home/presentation/manger/quran_cubit/quran_cubit.dart';
import 'package:islam/features/home/presentation/manger/quran_cubit/quran_state.dart';
import 'package:islam/features/home/presentation/view/widgets/quran_view/recently_sura_list_view_item.dart';

class RecentlySuraListview extends StatelessWidget {
  const RecentlySuraListview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranCubit, QuranState>(
      builder: (context, state) {
        if (state is QuranHistoryUpdated) {
          return SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RecentlySuraListviewItem(
                    suraNumber: state.suraNumbers[index],
                  ),
                );
              },
              itemCount: state.suraNumbers.length,
            ),
          );
        } else {
          return SizedBox(
            height: 150,
            child: Center(child: Text('السجل فارغ', style: Styles.textStyle20)),
          );
        }
      },
    );
  }
}
