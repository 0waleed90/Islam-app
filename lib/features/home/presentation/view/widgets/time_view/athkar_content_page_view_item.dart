import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:islam/features/home/data/models/athkar_model.dart';

import '../../../../../../core/constants.dart';
import '../../../../../../core/util/styles.dart';

class AthkarContentPageViewItem extends StatelessWidget {
  const AthkarContentPageViewItem({
    super.key,
    required this.index,
    required this.athkar,
  });
  final int index;
  final List<AthkarModel> athkar;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        const SizedBox(height: 30,),
        Center(
          child: Text(
            athkar[index].reference,
            style: Styles.textStyle24.copyWith(color: Colors.green),
            textDirection: .rtl,
          ),
        ),

           Center(
            child: Text(
              " مرات التكرار : ${athkar[index].count.toString()}",
              style: Styles.textStyle24.copyWith(
                color: Colors.green,
              ),
              textDirection: .rtl,
            ),
          ),

        SizedBox(height: 20,),
        Center(
          child: FlipCard(
            back: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),

              shadowColor: Colors.black,
              elevation: 100,
              child: Container(
                height: 500,
                width: 350,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: .topCenter,
                    colors: [Colors.black, Colors.grey],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    athkar[index].description,
                    style: Styles.textStyle20,
                    textDirection: .rtl,
                    textAlign: .center,
                  ),
                ),
              ),
            ),
            front: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),

              shadowColor: Colors.black,
              elevation: 100,
              child: Container(
                height: 600,
                width: 350,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: .topCenter,
                    colors: [Colors.grey, kPrimaryColor],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    athkar[index].zekr,
                    textAlign: .center,
                    textDirection: .rtl,
                    style: Styles.textStyle20.copyWith(color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
        ),


      ],
    );
  }
}
