import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:opennutritracker/core/utils/locator.dart';
import 'package:opennutritracker/core/domain/usecase/get_user_usecase.dart';

part 'weight_event.dart';

part 'weight_state.dart';

class WeightBloc extends Bloc<WeightEvent, WeightState> {
  final GetUserUsecase _getUserUsecase = locator<GetUserUsecase>();

  final log = Logger('WeightBloc');

  final double weightStep = 0.1;

  WeightBloc() : super(WeightState(0.0)) {
    on<WeightLoadInitialRequested>((event, emit) async {
      try {
        final userData = await _getUserUsecase.getUserData();
        double initialUserWeight = state.weight;

        if (initialUserWeight == 0) {
          initialUserWeight = userData.weightKG;
        }

        log.fine('Initial user weight: $initialUserWeight');
        emit(WeightState(initialUserWeight));
      } catch (e, stackTrace) {
        log.severe('Failed to load initial weight', e, stackTrace);
      }
    });

    on<WeightIncrement>((event, emit) {
      double currentWeight = state.weight;
      double finalWeight = currentWeight + weightStep;
      emit(WeightState(finalWeight));
    });
    on<WeightDecrement>((event, emit) {
      double currentWeight = state.weight;
      double finalWeight =
          (currentWeight - weightStep) > 0 ? currentWeight - weightStep : 0.0;
      emit(WeightState(finalWeight));
    });
  }
}
