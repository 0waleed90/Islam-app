import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:islam/core/constants.dart';
import 'package:islam/core/util/styles.dart';
import 'package:islam/features/home/presentation/manger/hadith_cubit/hadith_cubit.dart';
class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});
  static final FocusNode searchFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: .right,
      textDirection: .rtl,
      focusNode: searchFocusNode,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 14, top: 10),
          child: FaIcon(
            FontAwesomeIcons.bookQuran,
            size: 28,
            color: kPrimaryColor,
          ),
        ),
        hintText: 'اسم الحديث',
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
        context.read<HadithCubit>().searchHadith(value);
      },
    );
  }
}
