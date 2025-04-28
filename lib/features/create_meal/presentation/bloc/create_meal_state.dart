part of 'create_meal_bloc.dart';

class CreateMealState extends Equatable {
  final bool isOnCreateMealScreen;
  final List<IntakeEntity> intakeList;

  const CreateMealState({
    this.isOnCreateMealScreen = false,
    this.intakeList = const [],
  });

  @override
  List<Object> get props => [isOnCreateMealScreen, intakeList];

  CreateMealState copyWith({
    bool? isOnCreateMealScreen,
    List<IntakeEntity>? intakeList,
  }) {
    return CreateMealState(
      isOnCreateMealScreen: isOnCreateMealScreen ?? this.isOnCreateMealScreen,
      intakeList: intakeList ?? this.intakeList,
    );
  }
}
