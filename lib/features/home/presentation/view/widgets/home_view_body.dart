import 'package:flutter/material.dart';
import 'package:flutter_openmoji/flutter_openmoji.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:islam/core/constants.dart';
import 'package:islam/features/home/presentation/view/widgets/hadith_view/hadith_page.dart';
import 'package:islam/features/home/presentation/view/widgets/quran_view/quran_page.dart';
import 'package:islam/features/home/presentation/view/widgets/radio_view/radio_page.dart';
import 'package:islam/features/home/presentation/view/widgets/tasbih_view/tasbih_page.dart';
import 'package:islam/features/home/presentation/view/widgets/time_view/time_page.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  int selectedIndex = 0;

  void onItemTaped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const TimePage(),
    const QuranPage(),
    const HadithPage(),
    const TasbihPage(),
    const RadioPage(),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        backgroundColor: kPrimaryColor,
        onDestinationSelected: onItemTaped,
        indicatorColor: Color(0xff6F5F45),
        destinations: [
          NavigationDestination(
            selectedIcon: Icon(Icons.analytics, color: Colors.white),
            icon: Icon(Icons.analytics, color: Colors.black),
            label: 'الوقت',
          ),
          NavigationDestination(
            selectedIcon: FaIcon(
              FontAwesomeIcons.bookQuran,
              color: Colors.white,
            ),
            icon: FaIcon(FontAwesomeIcons.bookQuran, color: Colors.black),
            label: 'القرءان',
          ),
          NavigationDestination(
            selectedIcon: FaIcon(
              FontAwesomeIcons.bookOpen,
              color: Colors.white,
            ),
            icon: FaIcon(FontAwesomeIcons.bookOpen, color: Colors.black),
            label: 'الاحاديث',
          ),
          NavigationDestination(
            selectedIcon: Icon(OpenmojiIcons.prayer_beads, color: Colors.white),
            icon: Icon(OpenmojiIcons.prayer_beads, color: Colors.black),
            label: 'أذكار',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.radio, color: Colors.white),
            icon: Icon(Icons.radio, color: Colors.black),
            label: 'الاستماع',
          ),

        ],
      ),
      body: _pages[selectedIndex],
    );
  }
}
