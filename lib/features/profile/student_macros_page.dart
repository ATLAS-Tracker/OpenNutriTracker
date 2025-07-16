import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:opennutritracker/core/utils/locator.dart';

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
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final response = await supabase
        .from('tracked_days')
        .select(
            'calorieGoal, caloriesTracked, carbsGoal, carbsTracked, fatGoal, fatTracked, proteinGoal, proteinTracked')
        .eq('user_id', widget.studentId)
        .gte('day', startOfDay.toIso8601String())
        .lt('day', endOfDay.toIso8601String())
        .maybeSingle();

    if (response == null) return null;
    return Map<String, dynamic>.from(response as Map);
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
            return Center(child: Text('Erreur : ${snapshot.error}'));
          }

          final data = snapshot.data;
          if (data == null) {
            return const Center(child: Text('Aucune donnée pour aujourd’hui'));
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildRow(
                  'Calories', data['caloriesTracked'], data['calorieGoal']),
              _buildRow('Glucides', data['carbsTracked'], data['carbsGoal']),
              _buildRow('Lipides', data['fatTracked'], data['fatGoal']),
              _buildRow(
                  'Protéines', data['proteinTracked'], data['proteinGoal']),
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
