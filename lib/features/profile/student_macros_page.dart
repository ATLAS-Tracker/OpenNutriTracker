import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:opennutritracker/core/utils/locator.dart';
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
    final today = DateTime.now();
    final formattedDay = DateFormat('yyyy-MM-dd').format(today);

    final response = await supabase
        .from('tracked_days')
        .select(
            'calorieGoal, caloriesTracked, carbsGoal, carbsTracked, fatGoal, fatTracked, proteinGoal, proteinTracked')
        .eq('user_id', widget.studentId)
        .eq('day', formattedDay)
        .maybeSingle();

    if (response == null) return null;
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
              child: Text('${S.of(context).errorPrefix} ${snapshot.error}'),
            );
          }

          final data = snapshot.data;
          if (data == null) {
            return Center(child: Text(S.of(context).noDataToday));
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildRow(S.of(context).caloriesLabel, data['caloriesTracked'],
                  data['calorieGoal']),
              _buildRow(S.of(context).carbohydratesLabel, data['carbsTracked'],
                  data['carbsGoal']),
              _buildRow(
                  S.of(context).fatsLabel, data['fatTracked'], data['fatGoal']),
              _buildRow(S.of(context).proteinsLabel, data['proteinTracked'],
                  data['proteinGoal']),
            ],
          );
        },
      ),
    );
  }

  Widget _buildRow(String label, dynamic tracked, dynamic goal) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        '$label : ${tracked?.toStringAsFixed(0) ?? 0} / ${goal?.toStringAsFixed(0) ?? 0}',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
