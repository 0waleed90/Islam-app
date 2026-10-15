import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:islam/core/util/app_router.dart';
import 'package:islam/core/util/widgets/logo_image.dart';
import 'package:islam/features/home/presentation/view/widgets/radio_view/quraa_list_view_item.dart';
import 'package:islam/features/home/presentation/view/widgets/radio_view/radio_list_view.dart';

import '../../../../../../core/constants.dart';
import '../../../../../../core/util/styles.dart';
import '../../../manger/radio_cubit/radio_cubit.dart';

class RadioPage extends StatefulWidget {
  const RadioPage({super.key});

  @override
  State<RadioPage> createState() => _RadioPageState();
}

class _RadioPageState extends State<RadioPage> {
  int selectedButtonIndex = 0;
  void selectedButton(int index) {
    setState(() {
      selectedButtonIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: .end,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: .circular(16),
                  border: Border.all(color: Colors.red),
                ),
                child: IconButton(
                  color: Colors.red,
                  iconSize: 33,
                  onPressed: () {
                    GoRouter.of(context).push(AppRouter.kFavoriteView);
                  },
                  icon: Icon(Icons.favorite),
                ),
              ),

              //IconButton(onPressed: (){}, icon:Icon(Icons.save, color: Colors.black, size: 33),)
            ],
          ),
        ),

        body: GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).clearSnackBars();
          },
          child: Stack(
            children: [
              Image.asset(
                'assets/photos/Radio_Background.png',
                fit: BoxFit.fill,
              ),
              Column(
                children: [
                  const SizedBox(height: 20),

                  const LogoImage(),
                  Row(
                    mainAxisAlignment: .center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(185, 40),

                          backgroundColor: selectedButtonIndex == 0
                              ? kPrimaryColor
                              : Colors.transparent,
                          shape: selectedButtonIndex == 0
                              ? RoundedRectangleBorder(
                                  borderRadius: .circular(12),
                                )
                              : const RoundedRectangleBorder(
                                  borderRadius: .only(
                                    topLeft: Radius.circular(12),
                                    bottomLeft: Radius.circular(12),
                                  ),
                                ),
                        ),
                        onPressed: () {
                          selectedButton(0);
                        },
                        child: Text(
                          'الاستماع',
                          style: selectedButtonIndex == 0
                              ? Styles.textStyle16.copyWith(color: Colors.black)
                              : Styles.textStyle16.copyWith(
                                  color: Colors.white,
                                ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(185, 40),

                          backgroundColor: selectedButtonIndex == 1
                              ? kPrimaryColor
                              : Colors.transparent,
                          shape: selectedButtonIndex == 1
                              ? RoundedRectangleBorder(
                                  borderRadius: .circular(8),
                                )
                              : const RoundedRectangleBorder(
                                  borderRadius: .only(
                                    topRight: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                ),
                        ),
                        onPressed: () {
                          selectedButton(1);
                        },
                        child: Text(
                          'القراء',
                          style: selectedButtonIndex == 1
                              ? Styles.textStyle16.copyWith(color: Colors.black)
                              : Styles.textStyle16.copyWith(
                                  color: Colors.white,
                                ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * .6,
                    child: selectedButtonIndex == 0
                        ? const RadioListView()
                        : ListView.builder(
                            itemCount: context
                                .read<RadioCubit>()
                                .radioRepo
                                .reciters
                                .length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedButtonIndex = 0;
                                  });

                                  context.read<RadioCubit>().changeReciter(
                                    index,
                                  );
                                },
                                child: QuraaListViewItem(
                                  name: context
                                      .read<RadioCubit>()
                                      .radioRepo
                                      .reciters[index]
                                      .name,
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
