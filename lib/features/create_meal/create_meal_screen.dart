import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:opennutritracker/core/utils/navigation_options.dart';
import 'package:opennutritracker/generated/l10n.dart';

class MealCreationScreen extends StatefulWidget {
  const MealCreationScreen({super.key});

  @override
  State<MealCreationScreen> createState() => _MealCreationScreenState();
}

class _MealCreationScreenState extends State<MealCreationScreen> {
  final log = Logger('MealCreationScreen');
  final TextEditingController _mealNameController = TextEditingController();

  @override
  void dispose() {
    _mealNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add meal"), // Exemple : "Ajouter un Plat"
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _mealNameController,
              decoration: InputDecoration(
                labelText:
                    S.of(context).mealNameLabel, // Exemple : "Nom du plat"
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _onSaveMealPressed,
              child: Text("Sauvegarder"), // Exemple : "Sauvegarder"
            )
          ],
        ),
      ),
    );
  }

  void _onSaveMealPressed() {
    final mealName = _mealNameController.text.trim();
    if (mealName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Le nom du plat est requis")),
      );
      return;
    }

    log.info('Meal Created: $mealName');

    // TODO: Ajouter la logique d'enregistrement dans la BDD / Bloc

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Plat enregistré avec succès")),
    );

    Navigator.of(context).pop(); // Retour à l'écran précédent
  }
}
