import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opennutritracker/core/domain/entity/intake_entity.dart';
import 'package:opennutritracker/core/domain/usecase/get_config_usecase.dart';
import 'package:opennutritracker/features/add_meal/domain/entity/meal_entity.dart';
import 'package:opennutritracker/core/domain/entity/intake_type_entity.dart';
import 'package:opennutritracker/core/utils/id_generator.dart';

part 'create_meal_event.dart';
part 'create_meal_state.dart';

class CreateMealBloc extends Bloc<CreateMealEvent, CreateMealState> {
  final GetConfigUsecase _getConfigUsecase;
  List<IntakeEntity> _intakeList = [];

  CreateMealBloc(this._getConfigUsecase) : super(const CreateMealState()) {
    on<InitializeCreateMealEvent>((event, emit) async {
      emit(state.copyWith(isOnCreateMealScreen: true));
    });
    on<ExitCreateMealScreenEvent>((event, emit) async {
      emit(state.copyWith(isOnCreateMealScreen: false));
    });
  }

  void addIntake(String unit, String amountText, IntakeTypeEntity type,
      MealEntity meal, DateTime day) {
    final quantity = double.tryParse(amountText.replaceAll(',', '.'));
    if (quantity == null) return;

    final intakeEntity = IntakeEntity(
      id: IdGenerator.getUniqueID(),
      unit: unit,
      amount: quantity,
      type: type,
      meal: meal,
      dateTime: day,
    );

    _intakeList.add(intakeEntity);

    // Émet un nouvel état avec la liste mise à jour
    emit(state.copyWith(intakeList: List.from(_intakeList)));
  }

  void updateIntakeAmount(String intakeId, double newAmount) {
    final index = _intakeList.indexWhere((intake) => intake.id == intakeId);
    if (index != -1) {
      final updatedIntake = _intakeList[index].copyWith(amount: newAmount);
      _intakeList[index] = updatedIntake;
      emit(state.copyWith(intakeList: List.from(_intakeList)));
    }
  }
}
