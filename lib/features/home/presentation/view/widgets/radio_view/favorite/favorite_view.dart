import 'package:flutter/material.dart';
import 'package:islam/core/constants.dart';
import 'package:islam/features/home/presentation/view/widgets/radio_view/radio_list_view.dart';
import 'package:islam/features/home/presentation/view/widgets/radio_view/radio_list_view_item.dart';

import 'favorite_list_view.dart';
class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff032237),
      appBar: AppBar(

        centerTitle: true,
        title: Text("المفضلة"),
        foregroundColor: Colors.white,


        backgroundColor: Color(0xff005b7f),
      ),

      body: Stack(
        children: [
          Image.asset(
            'assets/photos/favorite_view_bavkground.jpg',
            fit: .cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SizedBox(
            height: 1000,
            child:FavoriteListView(),
          ),
        ],
      ),
    );
  }
}
