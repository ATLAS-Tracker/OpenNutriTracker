import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:opennutritracker/core/utils/locator.dart';
import 'student_macros_page.dart';

class CoachStudentsPage extends StatefulWidget {
  const CoachStudentsPage({super.key});

  @override
  State<CoachStudentsPage> createState() => _CoachStudentsPageState();
}

class _CoachStudentsPageState extends State<CoachStudentsPage> {
  late Future<List<Map<String, dynamic>>> _studentsFuture;

  @override
  void initState() {
    super.initState();
    _studentsFuture = _fetchStudents();
  }

  Future<List<Map<String, dynamic>>> _fetchStudents() async {
    final supabase = locator<SupabaseClient>();
    final coachId = supabase.auth.currentUser?.id;
    if (coachId == null) return [];

    final response = await supabase
        .from('users')
        .select('id, display_name')
        .eq('coach_id', coachId);

    final students = (response as List)
        .map((e) => Map<String, dynamic>.from(e as Map))
        .map((e) => {
              'id': e['id'],
              'name': e['display_name'] ?? e['id'],
            })
        .toList();

    return students;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes élèves'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _studentsFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            if (snapshot.hasError) {
              return Center(child: Text('Erreur: ${snapshot.error}'));
            }
            return const Center(child: CircularProgressIndicator());
          }

          final students = snapshot.data!;
          if (students.isEmpty) {
            return const Center(child: Text('Aucun élève'));
          }

          return ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index];
              final studentId = student['id'].toString();
              final studentName = student['name'].toString();
              return ListTile(
                title: Text(studentName),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => StudentMacrosPage(
                        studentId: studentId,
                        studentName: studentName,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
