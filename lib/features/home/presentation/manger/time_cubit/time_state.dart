import 'package:adhan/adhan.dart';

abstract class TimeState {}
class TimeInitial extends TimeState{}
class TimeSuccess extends TimeState{
final PrayerTimes prayerTimes;

  TimeSuccess({required this.prayerTimes});

}
class TimeFailure extends TimeState{
  final String errorMessage;

  TimeFailure({required this.errorMessage});
}
class TimeLoading extends TimeState{}