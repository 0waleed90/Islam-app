import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islam/core/util/app_router.dart';
import 'package:islam/features/home/data/repo/athkar_repo/athkar_repo_impl.dart';
import 'package:islam/features/home/data/repo/hadith_repo/hadith_repo_impl.dart';
import 'package:islam/features/home/data/repo/tasbih_repo/tasbih_repo_impl.dart';
import 'package:islam/features/home/data/repo/radio_repo/radio_repo_impl.dart';
import 'package:islam/features/home/data/repo/time_repo/time_repo_impl.dart';
import 'package:islam/features/home/presentation/manger/athkar_cubit/athkar_cubit.dart';
import 'package:islam/features/home/presentation/manger/hadith_cubit/hadith_cubit.dart';
import 'package:islam/features/home/presentation/manger/tasbih_cubit/tasbih_cubit.dart';
import 'package:islam/features/home/presentation/manger/radio_cubit/radio_cubit.dart';
import 'package:islam/features/home/presentation/manger/time_cubit/time_cubit.dart';
import 'package:islam/features/home/presentation/view/widgets/time_view/athan_notification_service.dart';
import 'package:just_audio_background/just_audio_background.dart';

import 'features/home/presentation/manger/quran_cubit/quran_cubit.dart';
bool isFirstTime =true;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AthanNotificationService.init();
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.example.islam.channel.audio',
    androidNotificationChannelName: "Islam App Radio",
    androidNotificationOngoing: true,
    androidShowNotificationBadge: true,
  );
  await initializeDateFormatting('ar', null);

  await Hive.initFlutter();
  var box =await Hive.openBox('settings');
   isFirstTime = box.get('isFirstTime',defaultValue: true);
  runApp(const Islam());
}

class Islam extends StatelessWidget {
  const Islam({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [


        BlocProvider(create: (context) => QuranCubit()..loadHistory()),
        BlocProvider(
            create: (context)=>AthkarCubit(AthkarRepoImpl())..fetchAthkar()),
        BlocProvider(
          create: (context) => TimeCubit(TimeRepoImpl())..getPrayerTimes(),
        ),
        BlocProvider(
          create: (context) => HadithCubit(HadithRepoImpl())..fetchHadithData(),
        ),
        BlocProvider(
          create: (context) => TasbihCubit(TasbihRepoImpl())..fetchTasbih(),
        ),
        BlocProvider(
          create: (context) =>
              RadioCubit(radioRepo: RadioRepoImpl())..fetchSurahs()..getFavorite(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
