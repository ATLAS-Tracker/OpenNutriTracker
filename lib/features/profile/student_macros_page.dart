import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:opennutritracker/core/utils/locator.dart';
import 'package:opennutritracker/features/home/presentation/widgets/macro_nutriments_widget.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:opennutritracker/generated/l10n.dart';

class StudentMacrosPage extends StatefulWidget {
  final String studentId;
  final String studentName;

  const StudentMacrosPage({
    super.key,
    required this.studentId,
    required this.studentName,
  });

  @override
  State<StudentMacrosPage> createState() => _StudentMacrosPageState();
}

class _StudentMacrosPageState extends State<StudentMacrosPage> {
  late Future<Map<String, dynamic>?> _macrosFuture;

  @override
  void initState() {
    super.initState();
    _macrosFuture = _fetchMacros();
  }

  Future<Map<String, dynamic>?> _fetchMacros() async {
    final supabase = locator<SupabaseClient>();
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    final response = await supabase
        .from('tracked_days')
        .select(
            'calorieGoal, caloriesTracked, carbsGoal, carbsTracked, fatGoal, fatTracked, proteinGoal, proteinTracked')
        .eq('user_id', widget.studentId)
        .eq('day', today)
        .maybeSingle();

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.studentName),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _macrosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
                child: Text('${S.of(context).errorPrefix} ${snapshot.error}'));
          }

          final data = snapshot.data;
          if (data == null) {
            return Center(child: Text(S.of(context).noDataToday));
          }

          // Récupération des données avec fallback
          final double calorieGoal = (data['calorieGoal'] ?? 0).toDouble();
          final double caloriesTracked =
              (data['caloriesTracked'] ?? 0).toDouble();
          final double carbsGoal = (data['carbsGoal'] ?? 0).toDouble();
          final double carbsTracked = (data['carbsTracked'] ?? 0).toDouble();
          final double fatGoal = (data['fatGoal'] ?? 0).toDouble();
          final double fatTracked = (data['fatTracked'] ?? 0).toDouble();
          final double proteinGoal = (data['proteinGoal'] ?? 0).toDouble();
          final double proteinTracked =
              (data['proteinTracked'] ?? 0).toDouble();

          final double kcalLeft = calorieGoal - caloriesTracked;
          final double gaugeValue = calorieGoal == 0
              ? 0
              : (caloriesTracked / calorieGoal).clamp(0.0, 1.0);

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Icon(Icons.keyboard_arrow_up_outlined,
                                color: Theme.of(context).colorScheme.onSurface),
                            Text('${caloriesTracked.toInt()}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface)),
                            Text(S.of(context).suppliedLabel,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface)),
                          ],
                        ),
                        CircularPercentIndicator(
                          radius: 90.0,
                          lineWidth: 13.0,
                          animation: true,
                          percent: gaugeValue,
                          arcType: ArcType.FULL,
                          progressColor: Theme.of(context).colorScheme.primary,
                          arcBackgroundColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withAlpha(50),
                          center: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AnimatedFlipCounter(
                                duration: const Duration(milliseconds: 1000),
                                value: kcalLeft.clamp(0, calorieGoal).toInt(),
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                        letterSpacing: -1),
                              ),
                              Text(
                                S.of(context).kcalLeftLabel,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface),
                              )
                            ],
                          ),
                          circularStrokeCap: CircularStrokeCap.round,
                        ),
                        Column(
                          children: [
                            Icon(Icons.keyboard_arrow_down_outlined,
                                color: Theme.of(context).colorScheme.onSurface),
                            Text(
                                '0', // Tu peux adapter si tu veux gérer "burned"
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface)),
                            Text(S.of(context).burnedLabel,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface)),
                          ],
                        ),
                      ],
                    ),
                    MacroNutrientsView(
                      totalCarbsIntake: carbsTracked,
                      totalFatsIntake: fatTracked,
                      totalProteinsIntake: proteinTracked,
                      totalCarbsGoal: carbsGoal,
                      totalFatsGoal: fatGoal,
                      totalProteinsGoal: proteinGoal,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
