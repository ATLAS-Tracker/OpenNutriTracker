import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:opennutritracker/core/utils/locator.dart';

class StudentMacrosPage extends StatefulWidget {
  final String studentId;
  final String studentName;
  const StudentMacrosPage({super.key, required this.studentId, required this.studentName});

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
    final response = await supabase
        .from('tracked_days')
        .select('calorieGoal, caloriesTracked, carbsGoal, carbsTracked, fatGoal, fatTracked, proteinGoal, proteinTracked')
        .eq('user_id', widget.studentId)
        .eq('day', today.toIso8601String().substring(0, 10))
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
          if (!snapshot.hasData) {
            if (snapshot.hasError) {
              return Center(child: Text('Erreur: ${snapshot.error}'));
            }
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data;
          if (data == null) {
            return const Center(child: Text('Aucune donnée'));
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildRow('Calories', data['caloriesTracked'], data['calorieGoal']),
              _buildRow('Glucides', data['carbsTracked'], data['carbsGoal']),
              _buildRow('Lipides', data['fatTracked'], data['fatGoal']),
              _buildRow('Protéines', data['proteinTracked'], data['proteinGoal']),
            ],
          );
        },
      ),
    );
  }

  Widget _buildRow(String label, dynamic tracked, dynamic goal) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text('$label : ${tracked ?? 0} / ${goal ?? 0}'),
    );
  }
}
