import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:islam/core/constants.dart';
import 'package:islam/core/util/styles.dart';
import 'package:islam/core/util/widgets/logo_image.dart';
import 'package:islam/features/home/presentation/view/widgets/time_view/athan_settings_dialog.dart';
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
    var settingsBox = Hive.box('settings');
    bool isAthanEnabled = settingsBox.get('isAthanEnabled', defaultValue: true);

    return Scaffold(
      backgroundColor: Colors.white,

      body: BlocBuilder<TimeCubit, TimeState>(
        builder: (context, state) {
          if (state is TimeSuccess) {
            var next = state.prayerTimes.nextPrayer();
            var nextTime = state.prayerTimes.timeForPrayer(next);
            var diff = nextTime!.difference(DateTime.now());

            return Stack(
              alignment: Alignment.center,
              children: [
                Image.asset('assets/photos/time_Background.png'),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const LogoImage(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                                color: Color(0xff856B3F),
                              ),
                              width: double.infinity,
                              height: 100,
                            ),
                            Image.asset('assets/photos/Group 10 (2).png'),
                            Column(
                              children: [
                                const CustomHistoryWidget(),
                                const SizedBox(height: 30),
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

                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            "الأذان القادم بعد ${diff.inHours.abs().toString().padLeft(2, '0')}:${(diff.inMinutes.remainder(60)).abs().toString().padLeft(2, '0')}",
                                            style: Styles.textStyle16.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          await showDialog(
                                            context: context,
                                            builder: (context) => const AthanSettingsDialog(),
                                          );
                                          setState(() {});
                                        },
                                        icon: Icon(
                                          isAthanEnabled ? Icons.volume_up : Icons.volume_off,
                                          color: isAthanEnabled ? Colors.green[800] : Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 40),
                                Align(
                                  alignment: const Alignment(-0.9, 1),
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
                                    physics: const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                                const SizedBox(height: 20),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),

                  Text(
                    state.errorMessage,
                    style: Styles.textStyle20,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 16),
                  Container(
                    height: 30,
                    width: 300,
                    decoration: const BoxDecoration(color: Colors.white),
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
              body: const Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
