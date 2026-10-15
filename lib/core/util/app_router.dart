import 'package:go_router/go_router.dart';
import 'package:islam/features/home/presentation/view/home_view.dart';
import 'package:islam/features/home/presentation/view/sura_content_view.dart';
import 'package:islam/features/home/presentation/view/widgets/hadith_view/hadith_content_view.dart';
import 'package:islam/features/home/presentation/view/widgets/radio_view/favorite/favorite_view.dart';
import 'package:islam/features/home/presentation/view/widgets/time_view/athkar_content_view.dart';
import 'package:islam/features/intro/presentation/view/intro_view.dart';
import 'package:islam/features/spash/presentation/view/splash_view.dart';

abstract class AppRouter {
  static final String kIntroView = '/IntroView';
  static final String kHomeView = '/HomeView';
  static final String kSearchView = '/SearchView';
  static final String kSuraContentView = '/SuraContentView';
  static final String kHadithContentView = '/HadithContentView';
  static final String kAthkarContentView = '/AthkarContentView';
  static final String kFavoriteView = '/FavoriteView';


  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(path: kFavoriteView,builder: (context,state)=>FavoriteView()),
      GoRoute(
        path: kAthkarContentView,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;

          return AthkarContentView(
            title: data['title'],
            indexCat: data['indexCat'],
          );
        },
      ),
      GoRoute(
        path: kHadithContentView,
        builder: (context, state) {
          final hadithNumber = state.extra as int;
          return HadithContentView(hadithNumber: hadithNumber);
        },
      ),

      GoRoute(
        path: kSuraContentView,
        builder: (context, state) {
          final surahNumber = state.extra as int;
          return SuraContentView(surahNumber: surahNumber);
        },
      ),
      GoRoute(path: '/', builder: (context, state) => SplashView()),
      GoRoute(path: kIntroView, builder: (context, state) => IntroView()),
      GoRoute(path: kHomeView, builder: (context, state) => HomeView()),
    ],
  );
}
