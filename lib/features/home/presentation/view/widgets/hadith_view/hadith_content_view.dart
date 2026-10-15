import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islam/core/util/styles.dart';
import 'package:islam/core/util/widgets/top_item_quran_hadith.dart';
import 'package:islam/features/home/presentation/manger/hadith_cubit/hadith_cubit.dart';
import 'package:islam/features/home/presentation/manger/hadith_cubit/hadith_state.dart';
import 'package:islam/features/home/presentation/view/widgets/hadith_view/hadith_content_app_bar.dart';

class HadithContentView extends StatelessWidget {
  const HadithContentView({super.key, required this.hadithNumber});
  final int hadithNumber;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HadithCubit, HadithState>(
      builder: (context, state) {
        if (state is HadithSuccess) {
          return Scaffold(
            body: Column(
              children: [
                HadithContentAppBar(hadithNumber: (hadithNumber+1).toString(),),
                TopItemQuranHadith(
                  centerText: state.hadiths[hadithNumber].title,
                  textStyle: Styles.textStyle24,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: SingleChildScrollView(
                      child: Text(
                        "${state.hadiths[hadithNumber].hadith}\n\n\n ${state.hadiths[hadithNumber].source} ",
                        style: Styles.textStyle20,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ),
                ),
Spacer(),
                Image.asset('assets/photos/bottom_quran_details.png'),
              ],
            ),
          );
        } else if (state is HadithFailure) {
          return Text(state.errorMessage);
        } else {
          return Center(child: LinearProgressIndicator());
        }
      },
    );
  }
}
