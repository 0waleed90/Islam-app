import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islam/core/util/widgets/logo_image.dart';
import 'package:islam/features/home/presentation/view/widgets/hadith_view/search_text_field.dart';
import 'package:islam/features/home/presentation/manger/hadith_cubit/hadith_cubit.dart';
import 'package:islam/features/home/presentation/manger/hadith_cubit/hadith_state.dart';
import 'package:islam/features/home/presentation/view/widgets/hadith_view/hadith_list_view_item.dart';

class HadithPage extends StatefulWidget {
  const HadithPage({super.key});

  @override
  State<HadithPage> createState() => _HadithPageState();
}

class _HadithPageState extends State<HadithPage> {
  PageController _pageController = PageController();
  final int _currentPage = 0;
  @override
  void initState() {
    _pageController =
    PageController(initialPage: _currentPage, viewportFraction: 0.8)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  double _calculateScale(int index) {
    double pagePosition = _pageController.page ?? 0;
    double distance = (pagePosition - index).abs();
    double scale = 1 - (distance * 0.1);
    return scale.clamp(0.8, 2);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HadithCubit, HadithState>(
      builder: (context, state) {
        if (state is HadithSuccess) {
         // if (state.hadiths.isEmpty) {return Center(child: Text('تعذر ايجاد اي نتائج'));}
          return Scaffold(
            backgroundColor: Color(0xff212120),
            body: Stack(
              children: [
                Image.asset(
                  'assets/photos/Hadith_page_background.png',
                  fit: BoxFit.fill,
                ),
                Column(
                  children: [
                    SizedBox(height: 20,),
                    LogoImage(),
                    SearchTextField(),
                    const SizedBox(height: 20),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * .515,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: state.hadiths.length,
                          itemBuilder: (context, index) {
                            double scale = _calculateScale(index);
                            return Transform.scale(
                              scale: scale,
                              child: HadithListViewItem(
                                hadith: state.hadiths[index].hadith,
                                title: state.hadiths[index].title, hadithNumber: index,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else if (state is HadithFailure) {
          return Text(state.errorMessage);
        } else {
          return LinearProgressIndicator();
        }
      },
    );
  }
}
