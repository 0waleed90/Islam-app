import 'package:flutter/material.dart';
import 'package:islam/features/intro/presentation/view/widgets/custom_control_widgets.dart';
import 'package:islam/features/intro/presentation/view/widgets/lists_of_item.dart';

import '../../../../../core/util/styles.dart';
import '../../../../../core/util/widgets/logo_image.dart';

class IntroViewBody extends StatefulWidget {
  const IntroViewBody({super.key});

  @override
  State<IntroViewBody> createState() => _IntroViewBodyState();
}

class _IntroViewBodyState extends State<IntroViewBody> {
  PageController pageController = PageController();
  int currentPage = 0;
  @override
  void initState() {
    pageController = PageController(initialPage: currentPage)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: 4,
        controller: pageController,
        itemBuilder: (BuildContext context, int index) {
          return Center(
            child: Column(
              mainAxisAlignment: .spaceEvenly,
              children: [
                const LogoImage(),
                Image.asset(ListsOfItem.images[index]),
                Text(ListsOfItem.mainText[index], style: Styles.textStyle24),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    ListsOfItem.crossText[index],
                    style: Styles.textStyle20,
                    textAlign: .center,
                  ),
                ),
                CustomControlWidgets(
                  index: index,
                  pageController: pageController,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
