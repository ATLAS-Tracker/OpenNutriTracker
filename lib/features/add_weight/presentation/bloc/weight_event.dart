part of 'weight_bloc.dart';

class WeightEvent {}

class WeightIncrement extends WeightEvent {}

class WeightDecrement extends WeightEvent {}

class WeightLoadInitialRequested extends WeightEvent {}

class WeightSet extends WeightEvent {
  final double weight;
  WeightSet(this.weight);
}
