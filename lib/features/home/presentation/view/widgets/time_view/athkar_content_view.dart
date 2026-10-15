import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islam/features/home/presentation/manger/athkar_cubit/athkar_cubit.dart';
import 'package:islam/features/home/presentation/manger/athkar_cubit/athkar_state.dart';

import 'athkar_content_page_view_item.dart';

class AthkarContentView extends StatelessWidget {
  const AthkarContentView({
    super.key,
    required this.title,
    required this.indexCat,
  });
  final String title;
  final int indexCat;
  int getIndex(int index) {
    if (indexCat == 0) {
      return index;
    } else if (indexCat == 1) {
      return index + 8;
    } else if (indexCat == 2) {
      return index + 10;
    } else if (indexCat == 3) {
      return index + 14;
    } else {
      return index + 15;
    }
  }
  int getItemCount() {
    if (indexCat == 0) {
      return 8;
    } else if (indexCat == 1) {
      return  2;
    } else if (indexCat == 2) {
      return 4;
    } else if (indexCat == 3) {
      return  1;
    } else {
      return  1;
    }
  }




  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AthkarCubit, AthkarState>(
      builder: (context, state) {
        if (state is AthkarSuccess) {
          return Scaffold(
            backgroundColor: Color(0xff032237),
            appBar: AppBar(
              centerTitle: true,
              title: Text(title),
              foregroundColor: Colors.white,

              backgroundColor: Color(0xff020B1c),
            ),

            body: Stack(
              children: [
                Image.asset(
                  'assets/photos/athkar_content_background.jpg',
                  fit: .cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                Positioned.fill(
                  child: PageView.builder(
                    itemCount: getItemCount(),
                    scrollDirection: .horizontal,
                    itemBuilder: (context, index) {
                      return AthkarContentPageViewItem(
                        index: getIndex(index),
                        athkar: state.athkar,
                      );
                    },//ادريس ابكر و      ماهر المعيقلي  الوقت المتبقي للصلاة و البحث في القرءان عدد الايات اضافة مساحة في ليست الراديو في الاسفل
                  ),
                ),
              ],
            ),
          );
        } else if (state is AthkarFailure) {
          return Text(state.errorMesage);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
