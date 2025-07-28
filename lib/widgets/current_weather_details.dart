import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CurrentWeatherDetails extends StatelessWidget {
  const CurrentWeatherDetails({
    super.key,
    required this.path,
    required this.label,
  });

  final String path;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset("assets/icons/$path.svg"),
        SizedBox(width: 5.0),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18.0,
          ),
        ),
      ],
    );
  }
}
