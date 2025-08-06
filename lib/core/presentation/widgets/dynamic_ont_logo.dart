import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:opennutritracker/core/utils/extensions.dart';

class DynamicOntLogo extends StatelessWidget {
  const DynamicOntLogo({super.key});

  static const logoAcolorLabel = "Acolor";
  static const logoTcolorLabel = "Tcolor";

  @override
  Widget build(BuildContext context) {
    String logoAcolor = Theme.of(context).colorScheme.primaryContainer.toHex();
    String logoTcolor = Theme.of(context).colorScheme.primaryContainer.toHex();

    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context)
          .loadString('assets/icon/ont_logo_atlas_tracker.svg'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          String? svgString = snapshot.data!;

          // Replace the "placeholders" with desired colors.
          svgString = svgString.replaceAll(logoAcolorLabel, logoAcolor);

          svgString = svgString.replaceAll(logoTcolorLabel, logoTcolor);

          return SvgPicture.string(svgString);
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        } else {
          return Image.asset(Theme.of(context).brightness == Brightness.light
              ? 'assets/icon/ont_logo_atlas_tracker_white.png'
              : 'assets/icon/ont_logo_atlas_tracker_dark.png');
        }
      },
    );
  }
}
