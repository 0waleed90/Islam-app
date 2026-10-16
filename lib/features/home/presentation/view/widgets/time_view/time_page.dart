import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islam/core/constants.dart';
import 'package:islam/core/util/styles.dart';
import 'package:islam/core/util/widgets/logo_image.dart';
import 'package:islam/features/home/presentation/view/widgets/time_view/athan_time_list_view_item.dart';
import 'package:islam/features/home/presentation/view/widgets/time_view/athkar_grid_view_item.dart';
import 'package:islam/features/home/presentation/view/widgets/time_view/custom_history_widget.dart';

import '../../../manger/time_cubit/time_cubit.dart';
import '../../../manger/time_cubit/time_state.dart';

class TimePage extends StatefulWidget {
  const TimePage({super.key});

  @override
  State<TimePage> createState() => _TimePageState();
}

class _TimePageState extends State<TimePage> {
  PageController _pageController = PageController();
  final int currentItem = 2;
  double _calculateScale(int index) {
    double pagePosition = _pageController.page ?? 2;
    double distance = (pagePosition - index).abs();
    double scale = 1 - (distance * 0.2);
    return scale.clamp(0.8, 2);
  }

  @override
  void initState() {
    _pageController =
        PageController(initialPage: currentItem, viewportFraction: 0.3)
          ..addListener(() {
            setState(() {});
          });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: BlocBuilder<TimeCubit, TimeState>(
        builder: (context, state) {
          if (state is TimeSuccess) {
            var next = state.prayerTimes.nextPrayer();
            var nextTime = state.prayerTimes.timeForPrayer(next);
            var diff = nextTime!.difference(DateTime.now());

            return Stack(
              alignment: .center,
              children: [
                Image.asset('assets/photos/time_Background.png'),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      LogoImage(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Stack(
                          alignment: .topCenter,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: .only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                                color: Color(0xff856B3F),
                              ),
                              width: 390,
                              height: 100,
                            ),
                            Image.asset('assets/photos/Group 10 (2).png'),
                            Column(
                              children: [
                                CustomHistoryWidget(),
                                SizedBox(height: 30),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: SizedBox(
                                    height: 145,

                                    child: PageView.builder(
                                      controller: _pageController,
                                      itemCount: 5,
                                      itemBuilder: (context, index) {
                                        return Transform.scale(
                                          scale: _calculateScale(index),

                                          child: AthanTimeListViewItem(
                                            index: index,
                                            prayerTimes: state.prayerTimes,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment: .spaceAround,
                                  children: [
                                    Text(
                                      "الأذان القادم بعد ${diff.inHours}:${diff.inMinutes % 60}",
                                      style: Styles.textStyle16.copyWith(
                                        color: Colors.black,
                                      ),
                                    ),

                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.volume_off,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 40),
                                Align(
                                  alignment: .xy(-0.9, 1),
                                  child: Text(
                                    'أذكار',
                                    style: Styles.textStyle16.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.symmetric(),
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 10,
                                          crossAxisCount: 2,
                                        ),
                                    itemBuilder: (context, index) {
                                      return AthkarGridViewItem(indexG: index);
                                    },
                                    itemCount: 5,
                                  ),
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is TimeFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  Icon(Icons.wifi_off, size: 64, color: Colors.grey),
                  SizedBox(height: 16),

                  Text(
                    state.errorMessage,
                    style: Styles.textStyle20,
                    textAlign: .center,
                  ),

                  SizedBox(height: 16),
                  Container(
                    height: 30,
                    width: 300,
                    decoration: BoxDecoration(color: Colors.white),
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<TimeCubit>().getPrayerTimes();
                      },
                      child: const Text('Retry', style: Styles.textStyle20),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: kPrimaryColor,
              body: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
