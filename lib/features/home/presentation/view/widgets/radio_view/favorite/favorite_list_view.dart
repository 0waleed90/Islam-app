import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islam/core/util/styles.dart';
import 'package:islam/features/home/presentation/manger/radio_cubit/radio_state.dart';

import '../../../../manger/radio_cubit/radio_cubit.dart';
import 'favorite_list_view_item.dart';

class FavoriteListView extends StatelessWidget {
  const FavoriteListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RadioCubit, RadioState>(
      builder: (context, state) {
        final favorites = (state is RadioSuccess)
            ? state.favorites
            : context.read<RadioCubit>().favorite;
        if (favorites.isEmpty) {
          return Center(child: Text('!! القائمة فارغة',style: Styles.textStyle24,));
        }

        return ListView.builder(
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            return FavoriteListViewItem(index: index);
          },
        );
      },
    );
  }
}
