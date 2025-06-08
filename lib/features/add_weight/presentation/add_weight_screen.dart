import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:opennutritracker/features/add_weight/presentation/bloc/weight_bloc.dart';
import 'package:opennutritracker/core/utils/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opennutritracker/generated/l10n.dart';
import 'package:opennutritracker/core/domain/usecase/add_weight_usecase.dart';
import 'package:opennutritracker/core/domain/usecase/get_weight_usecase.dart';
import 'package:opennutritracker/core/domain/entity/user_weight_entity.dart';
import 'package:opennutritracker/core/utils/id_generator.dart';
import 'package:opennutritracker/features/home/presentation/bloc/home_bloc.dart';
import 'package:opennutritracker/core/presentation/widgets/editable_text_widget.dart';
import 'package:opennutritracker/features/diary/presentation/bloc/calendar_day_bloc.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class AddWeightScreen extends StatefulWidget {
  const AddWeightScreen({super.key});

  @override
  State<AddWeightScreen> createState() => _AddWeightScreenState();
}

class _AddWeightScreenState extends State<AddWeightScreen> {
  late HomeBloc _homeBloc;
  late WeightBloc _weightBloc;
  late AddWeightUsecase _addWeightUsecase;
  late GetWeightUsecase _getWeightUsecase;
  late CalendarDayBloc _calendarDayBloc;
  late DateTime _day;
  late bool _isButtonDisabled;
  final nbDays = 7;

  @override
  void initState() {
    super.initState();
    _homeBloc = locator<HomeBloc>();
    _weightBloc = locator<WeightBloc>();
    _addWeightUsecase = locator<AddWeightUsecase>();
    _getWeightUsecase = locator<GetWeightUsecase>();
    _calendarDayBloc = locator<CalendarDayBloc>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as AddWeightScreenArguments;
    _day = DateTime(args.day.year, args.day.month, args.day.day);
    _isButtonDisabled = args.toSaveWeight;
  }

  Future<List<_WeightData>> getWeights() async {
    final lastSavedWeights = await _getWeightUsecase
        .getWeightsFromPastDays(_day, nbDays, includeToday: true);

    return lastSavedWeights.map((e) {
      // Normalize date to midnight for proper alignment with daily axis ticks
      final normalizedDate = DateTime(e.date.year, e.date.month, e.date.day);
      return _WeightData(normalizedDate, e.weight);
    }).toList();
  }

  Future<List<dynamic>> _loadAsyncData() {
    return Future.wait([
      getWeights(), // Future<List<_WeightData>>
      _getWeightUsecase.getAverageWeight(_day, nbDays), // Future<double>
    ]);
  }

  @override
  Widget build(BuildContext context) {
    /* init state.weight */
    _weightBloc.add(WeightLoadInitialRequested(_day));

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).weightLabel),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            // Wrap the Column with SingleChildScrollView
            child: Column(
              children: [
                Container(
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
                            onPressed: _isButtonDisabled
                                ? null
                                : () => _weightBloc.add(WeightDecrement()),
                          ),
                          BlocBuilder<WeightBloc, WeightState>(
                            bloc: _weightBloc,
                            builder: (context, state) {
                              return Center(
                                  child: EditableTextWidget(
                                      initialValue:
                                          state.weight.toStringAsFixed(1),
                                      disabledEnter: _isButtonDisabled));
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: _isButtonDisabled
                                ? null
                                : () => _weightBloc.add(WeightIncrement()),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                            onPressed: _isButtonDisabled
                                ? null
                                : () => _onButtonPressed(context),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                            ).copyWith(
                                elevation: ButtonStyleButton.allOrNull(0.0)),
                            icon: const Icon(Icons.add_outlined),
                            label: Text(S.of(context).buttonSaveLabel)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50),
                Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: ShapeDecoration(
                      color: Theme.of(context).cardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      shadows: kElevationToShadow[2],
                    ),
                    child: FutureBuilder<List<dynamic>>(
                        future: _loadAsyncData(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<dynamic>> snapshot) {
                          if (snapshot.hasData) {
                            final List<_WeightData> weightDataList =
                                snapshot.data![0] as List<_WeightData>;
                            final double avgWeight =
                                snapshot.data![1] as double;
                            return SfCartesianChart(
                                primaryXAxis: DateTimeAxis(
                                    dateFormat: DateFormat('dd/MM/yyyy'),
                                    intervalType: DateTimeIntervalType.days,
                                    interval: 1,
                                    labelRotation: -90,
                                    maximum: _day.add(Duration(hours: 12)),
                                    minimum: _day.subtract(
                                      Duration(days: nbDays),
                                    )),
                                primaryYAxis: NumericAxis(
                                  interval: 0.5,
                                  /*plotBands: <PlotBand>[
                                    PlotBand(
                                      start: avgWeight,
                                      end: avgWeight,
                                      borderColor: Colors.red,
                                      borderWidth: 2,
                                      dashArray: <double>[5, 5],
                                    )
                                  ]*/
                                ),
                                series: <CartesianSeries<_WeightData,
                                    DateTime>>[
                                  ColumnSeries(
                                    xValueMapper: (_WeightData data, _) =>
                                        data.date,
                                    yValueMapper: (_WeightData data, _) =>
                                        data.weight,
                                    dataSource: weightDataList,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  )
                                ]);
                          } else {
                            return const CircularProgressIndicator();
                          }
                        })),
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
    _calendarDayBloc.add(const RefreshCalendarDayEvent());

    /* Add current saved weight in data */
  }
}

class AddWeightScreenArguments {
  final DateTime day;
  final bool toSaveWeight;

  AddWeightScreenArguments({required this.day, required this.toSaveWeight});
}

class _WeightData {
  _WeightData(this.date, this.weight);

  final DateTime date;
  final double weight;
}
