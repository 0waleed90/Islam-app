import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islam/features/home/presentation/manger/quran_cubit/quran_cubit.dart';
import 'package:islam/features/home/presentation/view/widgets/quran_view/suras_list_view.dart';
import 'package:islam/features/home/presentation/view/widgets/quran_view/suras_list_view_item.dart';

import '../../../manger/quran_cubit/quran_state.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranCubit, QuranState>(
      builder: (context, state) {
        if (state is QuranSearchResults) {
          return Column(
            children: [
              SizedBox(height: 30),
              SizedBox(
                height: MediaQuery.of(context).size.height * .355,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: state.result.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SurasListViewItem(surahNumber: state.result[index]);
                  },
                ),
              ),
            ],
          );
        } else {
          return SurasListView();
        }
      },
    );
  }
}
