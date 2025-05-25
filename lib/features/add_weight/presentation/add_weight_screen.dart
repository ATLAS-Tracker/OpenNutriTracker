import 'package:flutter/material.dart';
import 'package:opennutritracker/features/add_weight/presentation/bloc/weight_bloc.dart';
import 'package:opennutritracker/core/utils/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opennutritracker/generated/l10n.dart';
import 'package:opennutritracker/core/domain/usecase/add_weight_usecase.dart';
import 'package:opennutritracker/core/domain/entity/user_weight_entity.dart';
import 'package:opennutritracker/core/utils/id_generator.dart';
import 'package:opennutritracker/features/home/presentation/bloc/home_bloc.dart';

class AddWeightScreen extends StatefulWidget {
  const AddWeightScreen({super.key});

  @override
  State<AddWeightScreen> createState() => _AddWeightScreenState();
}

class _AddWeightScreenState extends State<AddWeightScreen> {
  late HomeBloc _homeBloc;
  late WeightBloc _weightBloc;
  late AddWeightUsecase _addWeightUsecase;
  late DateTime _day;

  @override
  void initState() {
    _homeBloc = locator<HomeBloc>();
    _weightBloc = locator<WeightBloc>();
    _addWeightUsecase = locator<AddWeightUsecase>();
    super.initState();

    /* init state.weight */
    _weightBloc.add(WeightLoadInitialRequested());
  }

  @override
  void didChangeDependencies() {
    final args =
        ModalRoute.of(context)!.settings.arguments as AddWeightScreenArguments;
    _day = args.day;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).weightLabel),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: ShapeDecoration(
              color: Theme.of(context).cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              shadows: kElevationToShadow[2],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () => _weightBloc.add(WeightDecrement()),
                    ),
                    BlocBuilder<WeightBloc, WeightState>(
                      bloc: _weightBloc,
                      builder: (context, state) {
                        return Text(
                          "${state.weight.toStringAsFixed(1)} kg",
                          style: Theme.of(context).textTheme.headlineMedium,
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () => _weightBloc.add(WeightIncrement()),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                      onPressed: () => _onButtonPressed(context),
                      style: ElevatedButton.styleFrom(
                        foregroundColor:
                            Theme.of(context).colorScheme.onPrimaryContainer,
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                      ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                      icon: const Icon(Icons.add_outlined),
                      label: Text(S.of(context).buttonSaveLabel)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onButtonPressed(BuildContext context) {
    _addWeightUsecase.addUserWeight(UserWeightEntity(
        id: IdGenerator.getUniqueID(),
        weight: _weightBloc.state.weight,
        date: _day));
    _homeBloc.add(const LoadItemsEvent());
  }
}

class AddWeightScreenArguments {
  final DateTime day;

  AddWeightScreenArguments({required this.day});
}
