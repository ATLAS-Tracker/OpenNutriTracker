import 'package:flutter/material.dart';

class WeightCard extends StatefulWidget {
  final String weight;
  final VoidCallback onTap;
  final Function(BuildContext) onLongTap;

  const WeightCard(
      {super.key,
      required this.weight,
      required this.onTap,
      required this.onLongTap});

  @override
  State<WeightCard> createState() => _WeightCardState();
}

class _WeightCardState extends State<WeightCard> {
  @override
  Widget build(BuildContext context) {
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
            onTap: widget.onTap,
            onLongPress: () => widget.onLongTap(context),
            child: Center(
              child: Text(widget.weight,
                  style: Theme.of(context).textTheme.headlineSmall),
            ),
          ),
        ),
      ),
    );
  }
}
