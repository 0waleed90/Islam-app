import 'dart:async';
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
  late PageController _pageController;
  Timer? _timer;
  final int currentItem = 2;

  double _calculateScale(int index) {
    if (!_pageController.hasClients || _pageController.positions.length != 1) {
      return index == currentItem ? 1.0 : 0.85;
    }
    try {
      double pagePosition = _pageController.page ?? currentItem.toDouble();
      double distance = (pagePosition - index).abs();
      double scale = 1.0 - (distance * 0.15);
      return scale.clamp(0.85, 1.1);
    } catch (_) {
      return index == currentItem ? 1.0 : 0.85;
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: currentItem,
      viewportFraction: 0.35,
    )..addListener(() {
        setState(() {});
      });

    // مؤقت زمني مستمر لتحديث العداد المتبقي للأذان كل ثانية بشكل حي ومباشر
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  String _formatRemainingTime(Duration diff) {
    if (diff.isNegative) return "00:00:00";
    final hours = diff.inHours.toString().padLeft(2, '0');
    final minutes = (diff.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (diff.inSeconds % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    var settingsBox = Hive.box('settings');
    bool isAthanEnabled = settingsBox.get('isAthanEnabled', defaultValue: true);

    return Scaffold(
      backgroundColor: const Color(0xff121212),
      body: BlocBuilder<TimeCubit, TimeState>(
        builder: (context, state) {
          if (state is TimeSuccess) {
            var next = state.prayerTimes.nextPrayer();
            var nextTime = state.prayerTimes.timeForPrayer(next);

            DateTime targetTime;
            if (nextTime != null) {
              targetTime = nextTime.toLocal();
            } else {
              targetTime = state.prayerTimes.fajr.toLocal().add(const Duration(days: 1));
            }
            var diff = targetTime.difference(DateTime.now().toLocal());

            return Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/photos/time_Background.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const LogoImage(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(30)),
                                color: Color(0xff856B3F),
                                image: DecorationImage(
                                  image: AssetImage('assets/photos/Group 10 (2).png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const CustomHistoryWidget(),
                                  const SizedBox(height: 15),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: SizedBox(
                                      height: 140,
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
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              "الأذان القادم بعد ${_formatRemainingTime(diff)}",
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
                                ],
                              ),
                            ),
                            const SizedBox(height: 25),
                            Align(
                              alignment: const Alignment(-0.9, 1),
                              child: Text(
                                'أذكار',
                                style: Styles.textStyle16.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 12,
                                      crossAxisSpacing: 12,
                                      crossAxisCount: 2,
                                      childAspectRatio: 1.15,
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
