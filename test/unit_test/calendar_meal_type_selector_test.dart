import 'package:flutter/material.dart';
import "package:flutter_localizations/flutter_localizations.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:opennutritracker/features/create_meal/create_meal_modal.dart';
import 'package:opennutritracker/generated/l10n.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget buildWidget() {
    return MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: Scaffold(
        body: CalendarMealTypeSelector(
          onDateSelected: (_) {},
          mealName: 'Test meal',
          idOfRecipeToModify: null,
          imagePath: null,
        ),
      ),
    );
  }

  testWidgets('save button enabled when portions are valid', (tester) async {
    await tester.pumpWidget(buildWidget());
    await tester.enterText(find.byType(TextFormField).at(0), '2');
    await tester.enterText(find.byType(TextFormField).at(1), '1');
    await tester.pumpAndSettle();
    final button = tester.widget<FilledButton>(find.byType(FilledButton));
    expect(button.onPressed, isNotNull);
  });

  testWidgets('portionsEaten is limited to mealPortionCount', (tester) async {
    await tester.pumpWidget(buildWidget());
    await tester.enterText(find.byType(TextFormField).at(0), '2');
    await tester.enterText(find.byType(TextFormField).at(1), '5');
    await tester.pumpAndSettle();
    final field = tester.widget<TextFormField>(find.byType(TextFormField).at(1));
    expect(field.controller?.text, '2');
  });
}
