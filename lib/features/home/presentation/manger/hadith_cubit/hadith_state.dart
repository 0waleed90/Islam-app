import 'package:islam/features/home/data/models/hadith_model.dart';

abstract class HadithState {}
class HadithInitial extends HadithState{}
class HadithSuccess extends HadithState{
 final List<HadithModel> hadiths;

  HadithSuccess(this.hadiths);
}
class HadithLoading extends HadithState{}
class HadithFailure extends HadithState{
 final String errorMessage;

  HadithFailure(this.errorMessage);
}
