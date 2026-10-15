import '../../../data/models/tasbih_model.dart';

abstract class TasbihState {}

class TasbihSuccess extends TasbihState {
  final int counter;
  final int currentZkr;
  final List<TasbihModel> tasbih;
  TasbihSuccess(this.tasbih, this.currentZkr, this.counter);
}

class TasbihLoading extends TasbihState {}

class TasbihFailure extends TasbihState {
  final String errorMessage;

  TasbihFailure(this.errorMessage);
}

class TasbihInitial extends TasbihState {}
