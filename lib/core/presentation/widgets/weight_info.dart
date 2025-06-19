import 'package:flutter/material.dart';
import 'package:opennutritracker/core/presentation/widgets/info_dialog.dart';

class WeightInfo extends StatefulWidget {
  final Widget widget;
  final String title;
  final String body;
  const WeightInfo(
      {super.key,
      required this.widget,
      required this.title,
      required this.body});

  @override
  State<WeightInfo> createState() => _WeightInfoState();
}

class _WeightInfoState extends State<WeightInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 117,
      height: 75,
      padding: const EdgeInsets.all(20.0),
      decoration: ShapeDecoration(
        color: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        shadows: kElevationToShadow[2],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          InkWell(
            child: Center(
              child: widget.widget,
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => InfoDialog(
                        title: widget.title,
                        body: widget.body,
                      ));
            },
          ),
          Positioned(
              top: -10,
              right: -13.0,
              child: InkWell(
                child: const Icon(
                  Icons.help_outline_outlined,
                  size: 20,
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => InfoDialog(
                            title: widget.title,
                            body: widget.body,
                          ));
                },
              ))
        ],
      ),
    );
  }
}
