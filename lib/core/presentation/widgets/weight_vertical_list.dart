import 'package:flutter/material.dart';
import 'package:opennutritracker/core/utils/navigation_options.dart';
import 'package:opennutritracker/features/add_weight/presentation/add_weight_screen.dart';
import 'package:opennutritracker/core/presentation/widgets/placeholder_card.dart';
import 'package:opennutritracker/core/domain/entity/user_weight_entity.dart';

class WeightVerticalList extends StatelessWidget {
  final DateTime day;
  final String title;
  final UserWeightEntity? weightEntity;
  final Function(BuildContext) onItemLongPressedCallback;

  const WeightVerticalList(
      {super.key,
      required this.day,
      required this.title,
      required this.weightEntity,
      required this.onItemLongPressedCallback});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Icon(UserWeightEntity.getIconData(),
                size: 24, color: Theme.of(context).colorScheme.onSurface),
            const SizedBox(width: 4.0),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 160,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            if (weightEntity == null) {
              return PlaceholderCard(
                  day: day,
                  onTap: () => _onPlaceholderCardTapped(context),
                  firstListElement: false);
            } else {
              return Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: InkWell(
                      onTap: () => _onPlaceholderCardTapped(context),
                      onLongPress: () => onItemLongPressedCallback(context),
                      child: Center(
                        child: Text(weightEntity!.weight.toStringAsFixed(1),
                            style: Theme.of(context).textTheme.headlineSmall),
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ),
      )
    ]);
  }

  void _onPlaceholderCardTapped(BuildContext context) {
    Navigator.of(context).pushNamed(NavigationOptions.addWeightRoute,
        arguments: AddWeightScreenArguments(day: day));
  }
}
