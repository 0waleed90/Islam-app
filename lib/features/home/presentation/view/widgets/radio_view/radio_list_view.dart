import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islam/features/home/presentation/manger/radio_cubit/radio_cubit.dart';
import 'package:islam/features/home/presentation/manger/radio_cubit/radio_state.dart';
import 'package:islam/features/home/presentation/view/widgets/radio_view/radio_list_view_item.dart';

class RadioListView extends StatelessWidget {
  const RadioListView({super.key});
final int itmCount=0 ;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RadioCubit, RadioState>(
      builder: (context, state) {
        if (state is RadioSuccess) {
          return ListView.builder(

            itemCount: state.surahs.length,
            itemBuilder: (context, index) {
              return RadioListViewItem(
                radioModel: state.surahs[index],
                index: index,
              );
            },
          );
        } else if (state is RadioFailure) {
          return Center(
            child: Column(
              children: [
                Text(state.errorMessage),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    context.read<RadioCubit>().fetchSurahs();
                  },
                  child: Text("إعادة المحاولة"),
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: Column(
              children: [
                LinearProgressIndicator(),
                SizedBox(height: 10),
                Text("جاري تحميل قائمة السور..."),
              ],
            ),
          );
        }
      },
      listener: (context, state) {
        if (state is RadioSuccess && state.playbackError != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.playbackError!),
              backgroundColor: Colors.amber,
              action: SnackBarAction(
                label: "إعادة المحاولة",
                onPressed: () {
                  context.read<RadioCubit>().playSura(state.currentSura);
                },
              ),
            ),
          );
        }
      },
    );
  }
}
