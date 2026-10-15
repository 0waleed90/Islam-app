import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:islam/core/constants.dart';
import 'package:islam/core/util/styles.dart';
import 'package:islam/core/util/widgets/logo_image.dart';
import 'package:islam/features/home/presentation/manger/quran_cubit/quran_cubit.dart';
import 'package:islam/features/home/presentation/view/widgets/quran_view/normal_content.dart';
import 'package:islam/features/home/presentation/view/widgets/quran_view/search_results.dart';

class QuranPage extends StatefulWidget {
  const QuranPage({super.key});

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  final FocusNode _searchFocusNode = FocusNode();
  bool _isSearching = false;
  @override
  void initState() {
    _searchFocusNode.addListener(() {
      setState(() {
        _isSearching = _searchFocusNode.hasFocus;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('assets/photos/home_Background.png', fit: BoxFit.fill),
        Column(
          children: [
            SizedBox(height: 20),

            LogoImage(),

            TextField(
              focusNode: _searchFocusNode,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 14, top: 10),
                  child: FaIcon(
                    FontAwesomeIcons.bookQuran,
                    size: 28,
                    color: kPrimaryColor,
                  ),
                ),
                hintText: 'اسم السورة',
                hintStyle: Styles.textStyle16.copyWith(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: kPrimaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: kPrimaryColor),
                ),
              ),
              onChanged: (value) {
                context.read<QuranCubit>().searchQuran(value);
              },
            ),
            _isSearching ? SearchResults() : Expanded(child: NormalContent()),
          ],
        ),
      ],
    );
  }
}
