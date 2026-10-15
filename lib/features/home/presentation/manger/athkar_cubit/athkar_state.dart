import '../../../data/models/athkar_model.dart';

abstract class AthkarState {}
class AthkarInitial extends AthkarState{}
class AthkarSuccess extends AthkarState{
  final List<AthkarModel> athkar;

  AthkarSuccess({required this.athkar});
}
class AthkarFailure extends AthkarState{
  final String errorMesage;

  AthkarFailure({required this.errorMesage});


}
class AthkarLoading extends AthkarState{}